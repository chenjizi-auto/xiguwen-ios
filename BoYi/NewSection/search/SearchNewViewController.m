//
//  SearchNewViewController.m
//  BoYi
//
//  Created by heng on 2018/2/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SearchNewViewController.h"
#import "SearchCollectionViewCell.h"
#import "SearchHeaderCollectionReusableView.h"
#import "AnlieListModel.h"
#import "AnlieListSearchModel.h"
#import "NewShangjiaModel.h"
#import "SearchshangjiaListViewController.h"
#import "AnlieListSearchViewController.h"
#import "BaojiaListNewViewController.h"
#import "NewLoginViewController.h"
#import "SearchSubViewController.h"
@interface SearchNewViewController (){
    NSInteger types;
}
@property (nonatomic, strong) NSArray <Shangjiatuanduilist *>*dataSJ;
@property (nonatomic, strong) NSArray <Anlielistsearcharray *>*dataAL;
@property (nonatomic, strong) NSArray <Baojiashangjiafen *>*dataBJ;
@property (nonatomic, strong) NSArray <Shangjiatuanduilist *>*dataSP;
@end

@implementation SearchNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (isIPhoneX) {
        self.heightwu.constant = 40;
    }else {
        self.heightwu.constant = 20;
    }
    types = 1;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.search.delegate = self;
    self.search.returnKeyType = UIReturnKeySearch;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(60,0,60,26)];
    leftView.backgroundColor = [UIColor clearColor];
    
    self.search.leftView = leftView;
    self.search.leftViewMode = UITextFieldViewModeAlways;
    self.search.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.search.inputAccessoryView = [self addToolbar];
    
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collection registerNib:[UINib nibWithNibName:@"SearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SearchCollectionViewCell"];
    [self.collection registerClass:[SearchHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHeaderCollectionReusableView"];
    self.remenArray = [NSMutableArray array];
    self.lishiArray = [NSMutableArray array];
    
    self.type = @"sj";
    if (![UserDataNew UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }else {

        [self getData];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    [self getData];
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (IBAction)pop:(id)sender {
    [self popViewConDelay];
}

- (void)getData{
    NSDictionary *dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"type":self.type,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    [[RequestManager sharedManager] requestUrl:URL_New_search
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.model = [SearchLsModel mj_objectWithKeyValues:response[@"data"]];
                                               self.remenArray = [NSMutableArray arrayWithArray:self.model.hot];
                                               self.lishiArray = [NSMutableArray arrayWithArray:self.model.lishi];;
                                               [self.collection reloadData];
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           
                                       }];
}
- (IBAction)popac:(UIButton *)sender {
    [self popViewConDelay];
}

- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {//商家
        [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        self.image1.hidden = NO;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        self.iamge4.hidden = YES;
        self.type = @"sj";
    }else if (sender.tag == 1) {//案例
        [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        self.image1.hidden = YES;
        self.image2.hidden = NO;
        self.image3.hidden = YES;
        self.iamge4.hidden = YES;
        self.type = @"al";
    }else if (sender.tag == 2) {//服务
        [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn3 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = NO;
        self.iamge4.hidden = YES;
        self.type = @"fw";
    }else {//商品
        [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn4 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        self.iamge4.hidden = NO;
        self.type = @"sp";
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return section == 0 ? self.remenArray.count : self.lishiArray.count;
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth,30);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    //从缓存中获取 Headercell
    SearchHeaderCollectionReusableView *header =nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        SearchHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHeaderCollectionReusableView" forIndexPath:indexPath];
        
        headerView.titleLabel.text = indexPath.section == 0 ? @"热门搜索" : @"历史搜索";
        [headerView.btn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [headerView.btn addTarget:self action:@selector(deleAC) forControlEvents:UIControlEventTouchUpInside];
        headerView.btn.hidden = indexPath.section == 0 ? YES : NO;
        header = headerView;
    }
    return header;
}
- (void)deleAC{
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionViewCell" forIndexPath:indexPath];
    
    cell.content.text = indexPath.section == 0 ? self.remenArray[indexPath.row].title : self.lishiArray[indexPath.row].title;
    cell.content.tag = indexPath.row;
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.search resignFirstResponder];
    if (indexPath.section == 0) {

        [self pushSearch:self.remenArray[indexPath.row].title];
    }else {
        [self pushSearch:self.lishiArray[indexPath.row].title];
    }
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UILabel *lbl_text = [[UILabel alloc]init];
    lbl_text.text = indexPath.section == 0 ? self.remenArray[indexPath.row].title : self.lishiArray[indexPath.row].title;
    UIFont *fnt = [UIFont fontWithName:@"Courier New" size:12.0f];
    lbl_text.font = fnt;
    // 根据字体得到NSString的尺寸
    CGSize size = [lbl_text.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName,nil]];
    // 名字的W
    CGFloat nameW = size.width;
    lbl_text = nil;
    return CGSizeMake(nameW + 20,30);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)pushSearch:(NSString *)search{
    SearchSubViewController *orderSub = [[SearchSubViewController alloc] init];
    orderSub.titleColorSelected = MAINCOLOR;
    orderSub.menuViewStyle = WMMenuViewStyleLine;
    orderSub.automaticallyCalculatesItemWidths = YES;
    orderSub.progressWidth = 40;
    orderSub.progressViewIsNaughty = YES;
    orderSub.content = search;
    [self pushToNextVCWithNextVC:orderSub];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.cityView.hidden = YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length != 0) {
        [self pushSearch:textField.text];
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}

- (IBAction)cityac:(UIButton *)sender {
    [self.search resignFirstResponder];
    if (self.cityView.hidden == YES) {
        self.cityView.hidden = NO;
    }else {
        self.cityView.hidden = YES;
    }
}
- (IBAction)actiontiy:(UIButton *)sender {
    if (sender.tag == 0) {
        [self.cityBtn setTitle:@"同城" forState:UIControlStateNormal];
        types =  1;
    }else {
        [self.cityBtn setTitle:@"全国" forState:UIControlStateNormal];
        types =  2;
    }
    self.cityView.hidden = YES;
}



@end
