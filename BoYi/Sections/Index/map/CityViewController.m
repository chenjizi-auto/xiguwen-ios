//
//  CityViewController.m
//  BoYi
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "CityViewController.h"
#import "ContactDataHelper.h"
#import "MapTableViewCell.h"
#import "MapHeaderView.h"
#import "MapCollectionViewCell.h"
#import "NSString+Utils.h"
#import "CwLocationManager.h"
#import "NewmapModel.h"
@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{
    
    BOOL _isSearch;
    int renConant;
}

@property (nonatomic,strong) NSMutableArray *sectionTitles;
@property (nonatomic,strong) NSMutableArray *contactsSource;
@property (nonatomic,strong) NSMutableArray * foldArray;

@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) NSMutableArray *searchResultArr;//搜索结果

@end

@implementation CityViewController
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    // 收起键盘
//    [self.view endEditing:YES];
//}
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];

}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (isIPhoneX) {
        self.height.constant = 84;
    }
    if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityName"]] isBlankString]) {
        self.titleLabel.text = [NSString stringWithFormat:@"当前城市-%@",[UserData UserDefaults:@"cityName"]];
    }else {
        self.titleLabel.text = @"选择城市";
    }
    renConant = 0;
    self.view.backgroundColor = [UIColor whiteColor];

    [self addtableView];

    [self addDataSource];

    [UserData UserDefaults:@"yes" key:@"isRefreshing1"];
    [UserData UserDefaults:@"yes" key:@"isRefreshing2"];
    [UserData UserDefaults:@"yes" key:@"isRefreshing3"];
    [UserData UserDefaults:@"yes" key:@"isRefreshing4"];
    [UserData UserDefaults:@"yes" key:@"isRefreshing5"];
    
//    [self address];

    
}
- (void)address{
    [[CwLocationManager sharedManager] startWithGeoSearch:YES complete:^(BOOL success, NSString *province, NSString *city) {

        if (success) {
            [self.cityBtn setTitle:[NSString stringWithFormat:@"  %@",city] forState:UIControlStateNormal];
            [self save:city];
        }
    }];
}

- (void)addtableView{
    [UserData ClearUserDefaults:@"fold"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.tableFooterView  =[[UIView alloc]initWithFrame:CGRectZero];//取消多余行数
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _sectionTitles = [[NSMutableArray alloc] init];
    _contactsSource = [[NSMutableArray alloc] init];
    _foldArray = [[NSMutableArray alloc] init];
    _searchResultArr = [[NSMutableArray alloc] init];
    [self.searchview addSubview:self.searchBar];
    
    

}
- (void)addheaderview:(NSMutableArray *)array{
    @weakify(self);
    MapHeaderView *type = [[NSBundle mainBundle]loadNibNamed:@"MapHeaderView" owner:nil options:nil].firstObject;
    int i = 0;
    i = (int)array.count / 3;
    if (array.count % 3 == 0) {
        
    }else {
        i = i + 1;
    }
    
    renConant = i;
    type.frame = CGRectMake(0, 0, ScreenWidth, 48 + 44 * i);
    [type.gotoNextVc subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        NewmapModel *model = x;
//        [UserDataNew reWriteUserInfo:model.name ForKey:@"site"];
        [UserData UserDefaults:model.name key:@"cityName"];
        [UserData UserDefaults:[NSString stringWithFormat:@"%ld",model.id] key:@"cityCityid"];
        [UserDataNew reWriteUserInfo:[NSString stringWithFormat:@"%ld",model.id] ForKey:@"id"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [_tableView reloadData];
    self.tableView.tableHeaderView = type;
    [type refreshData:array];
    
}
- (IBAction)cityAC:(UIButton *)sender {
    [NavigateManager showLoadingMessage:@"正在定位..."];
    [self map];
}
- (IBAction)quanguoAC:(UIButton *)sender {
    
    [self save:@"全国"];
}

- (void)map{
    @weakify(self);
    [[CwLocationManager sharedManager] startWithGeoSearch:YES complete:^(BOOL success, NSString *province, NSString *city) {
        
        @strongify(self);
        if (success) {
            //            _provinceString = province;
            //            _cityString = city;
            [self.cityBtn setTitle:[NSString stringWithFormat:@"  %@",city] forState:UIControlStateNormal];
            [self save:city];
            
        } else {
            [NavigateManager showMessage:@"获取定位失败，请重试！"];
            [self.cityBtn setTitle:@"   定位当前城市" forState:UIControlStateNormal];
        }
        
    }];
}
-(void)save:(NSString *)string{
    [[RequestManager sharedManager] requestUrl:URL_New_citychange
                                        method:POST
                                        loding:nil
                                           dic:@{@"cityname":string}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];

                                              

                                               [UserData UserDefaults:string key:@"cityName"];
                                               [UserData UserDefaults:response[@"data"][@"id"] key:@"cityCityid"];
                                               if ([string isEqualToString:@"全国"]) {
                                                   [UserDataNew reWriteUserInfo:@"-1" ForKey:@"id"];
                                               }else {
                                                   [UserDataNew reWriteUserInfo:response[@"data"][@"id"] ForKey:@"cityid"];
                                               }
                                               [self.navigationController popViewControllerAnimated:YES];
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"保存地址失败"];
                                           
                                       }];
}

- (void)addDataSource{

    [self.refreshDataCommand execute:nil];

}
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_CITY
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _refreshDataCommand;
}

- (void)sortDataArrayWithContactDataHelper{
//    self.contactsSource = [ContactDataHelper getceshi:self.contactsSource];
    
    NSMutableArray *contactsSource = [NSMutableArray arrayWithArray:self.contactsSource];
    [self.contactsSource removeAllObjects];
    [self.sectionTitles removeAllObjects];
    
    self.contactsSource = [ContactDataHelper getFriendListDataBy:contactsSource];
    
    self.sectionTitles = [ContactDataHelper getFriendListSectionBy:[self.contactsSource mutableCopy]];
#pragma mark ----------  第三步
    //获得折叠状态数组
    [self getFoldStateArray];
}
- (void)getFoldStateArray{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"fold"] == nil) {
        for (int i = 0; i < self.sectionTitles.count - 1; i++) {
            NSNumber * isHidden = @0;
            [self.foldArray addObject:isHidden];
        }
        NSArray * foldArr = [NSArray arrayWithArray:self.foldArray];
        [[NSUserDefaults standardUserDefaults] setObject:foldArr forKey:@"fold"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        
        NSArray * foldArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"fold"];
        self.foldArray = [NSMutableArray arrayWithArray:foldArr];
    }
    [_tableView reloadData];
}

#pragma mark -- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.contactsSource.count == 0) {
        return 0;
    }
    if (_isSearch == 1) {
        return 1;
    }
    return self.sectionTitles.count - 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (([self.foldArray[section] boolValue] == YES ||self.contactsSource.count == 0) && _isSearch == 0) {
        return 0;
    }
    
    if (_isSearch == 1) {
        return self.searchResultArr.count;
    }
    return [self.contactsSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Identifier = @"MapTableViewCell";
    MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MapTableViewCell" owner:nil options:nil].firstObject;
    }
    if (_isSearch == 1) {
        NewmapModel * model = self.searchResultArr[indexPath.row];
        cell.city.text = model.name;
        return cell;
    }
    NewmapModel * model = self.contactsSource[indexPath.section][indexPath.row];
    cell.city.text = model.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (_isSearch == 1) {
        NewmapModel * model = self.searchResultArr[indexPath.row];
        
      
//        [UserDataNew reWriteUserInfo:model.name ForKey:@"site"];
        [UserData UserDefaults:model.name key:@"cityName"];
        [UserData UserDefaults:[NSString stringWithFormat:@"%ld",model.id] key:@"cityCityid"];
        [UserDataNew reWriteUserInfo:[NSString stringWithFormat:@"%ld",model.id] ForKey:@"id"];;
        
    }else {
        NewmapModel * model = self.contactsSource[indexPath.section][indexPath.row];

//        [UserDataNew reWriteUserInfo:model.name ForKey:@"site"];
        [UserData UserDefaults:model.name key:@"cityName"];
        [UserData UserDefaults:[NSString stringWithFormat:@"%ld",model.id] key:@"cityCityid"];
        [UserDataNew reWriteUserInfo:[NSString stringWithFormat:@"%ld",model.id] ForKey:@"id"];;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isSearch == 1) {
        return nil;
    }
    return self.sectionTitles;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_isSearch == 1) {
        
//        self.tableView.tableHeaderView.hidden = YES;
//        self.tableView.tableHeaderView.height = 0;
        
        return 0;
    }
//    self.tableView.tableHeaderView.hidden = NO;
//    self.tableView.tableHeaderView.height = 50 + 44 * renConant;
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(_isSearch == 1){
        return nil;
    }
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    view.backgroundColor = RGBA(243, 243, 243,1);
//    UILabel * btn = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 30, 30)];
//    btn.text = self.sectionTitles[section + 1];
//    [view addSubview:btn];
//    return view;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
    view.backgroundColor = RGBA(245, 245, 245, 1);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, ScreenWidth, 18)];
    label.textColor = RGBA(51, 51, 51, 1);
    label.font = [UIFont systemFontOfSize:15];
    label.text = self.sectionTitles[section + 1];;
    [view addSubview:label];
    return view;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSearch == 1) {
        return NO;
    }
    return YES;
}
#pragma mark -- UITextFieldDelegate
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];    //按回车键，键盘回收
//    return YES;
//}

#pragma mark searchBar delegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTintColor:[UIColor grayColor]];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; //searchBar失去焦点
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES; //把enabled设置为yes
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消
    [searchBar resignFirstResponder];
    
    searchBar.text = nil;
    _isSearch = 0;
    
    searchBar.showsCancelButton = NO;
    [self.tableView reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    _isSearch = 1;
    [self.searchResultArr removeAllObjects];
    
   
    
    
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(8, 0, ScreenWidth - 16, 30)];
//        _searchBar.backgroundColor = [UIColor clearColor];
        [_searchBar sizeToFit];
        [_searchBar setPlaceholder:@"输入城市名/拼音查询"];

//        _searchBar.layer.cornerRadius = 25;//设置圆角具体根据实际情况来设置
//         _searchBar.layer.masksToBounds = YES;
        _searchBar.translucent = YES;
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;

        UITextField *searchTextField = nil;
//        self.searchBar.barTintColor = [UIColor redColor];
        searchTextField = [[[[[self.searchBar.subviews firstObject] subviews] lastObject] subviews] lastObject];
        
        //这里改变输入框边框的颜色和边框的宽度
        searchTextField.layer.borderWidth = 1;
        searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        searchTextField.layer.cornerRadius = 18;
        searchTextField.layer.masksToBounds = YES;
        searchTextField.backgroundColor = RGBA(240, 240, 240, 0);
        @weakify(self);
        [[searchTextField.rac_textSignal throttle:0.2] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 [self.searchResultArr removeAllObjects];
                NSMutableArray *tempResults = [NSMutableArray array];
                NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
                
                NSMutableArray *contactsSource = [NSMutableArray arrayWithArray:self.contactsSource];
                
                for (NSArray * array in contactsSource) {
                    for (NewmapModel * model in array) {
                        [tempResults addObject:model];
                    }
                }
                
                for (int i = 0; i < tempResults.count; i++) {
                    NewmapModel *model = tempResults[i];
                    //        NSString *storeString = [model.name pinyin];
                    NSString *storeString = model.pinyin;
                    NSRange storeRange = NSMakeRange(0, storeString.length);
                    
                    //  NSRange storeRange = NSMakeRange(0,searchText.pinyin.length);
                    
                    if (storeString.length < storeRange.length) {
                        continue;
                    }
                    
                    
                    NSRange foundRange = [storeString rangeOfString:x.pinyin options:searchOptions range:storeRange];
                    if (foundRange.length) {
                        
                        [self.searchResultArr addObject:tempResults[i]];
                    }
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            });
        }];
        
    }
    return _searchBar;
}

#pragma mark - 网络请求
- (RACSignal *)requestSignalWithUrl:(NSString *)url
                            loading:(NSString *)loading
                      Authorization:(NSString *)Authorization
                               info:(NSDictionary *)info {
    
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        
        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:POST
                                                                         loding:loading
                                                                            dic:info
                                                                       progress:nil
                                                                        success:^(NSURLSessionDataTask *task, id response) {
                                  
                                                                            NSMutableArray *array = [NewmapModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"site"]];
                                                                            NSMutableArray *arrayremen = [NewmapModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"newsite"]];
                                                                            

                                                                            [self addheaderview:arrayremen];

                                                                            self.contactsSource = array;
                                                                            [self sortDataArrayWithContactDataHelper];
                                                                            
                                                                            [subscriber sendCompleted];

                                                                            [NavigateManager hiddenLoadingMessage];
                                                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                            // 如果网络请求出错，则加载数据库中的旧数据
                                                                            
                                                                            [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
                                                                            [NavigateManager hiddenLoadingMessage];
                                                                            [subscriber sendCompleted];
                                                                        }];
        // 在信号量作废时，取消网络请求
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    //    [requestSignal throttle:1];
    return requestSignal;
}
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
