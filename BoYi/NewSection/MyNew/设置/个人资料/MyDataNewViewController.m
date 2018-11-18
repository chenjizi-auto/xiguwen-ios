//
//  MyDataNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/9.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyDataNewViewController.h"
#import "MyDataNewViewModel.h"
#import "MyDataNewModel.h"
#import "WeightNewViewController.h"
#import "HeightNewViewController.h"
#import "AgeNewViewController.h"
#import "NameNewViewController.h"
#import "AddressNewViewController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <TZImagePickerController/TZImagePickerController.h>
//#import <MWPhotoBrowser.h>
#import "CwDatePiker.h"
#import "CityViewController.h"
#import "DiPuPickerView.h"
#import "DiPuRequestCityViewModel.h"
#import "DipuModel.h"
#import "CwChooseAreaPikerView.h"
@interface MyDataNewViewController () {
    NSArray * CityArray;
    NSDictionary *_needUpdateInfo;  //记录修改成功的数据，用于修改本地数据
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyDataNewViewModel *viewModel;
@property(nonatomic,strong)DiPuPickerView * pickerView;
@property(nonatomic,strong)DiPuRequestCityViewModel * CityViewModel;
@end

@implementation MyDataNewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightBtnWithTitle:@"保存" image:nil];
    self.navigationItem.title = @"个人资料";
    [self addPopBackBtn];
    [self cellClick];
    [self requestDiqu];
    [self setupTableView];
//    [self.viewModel ConvertingToObject:[[UserDataNew sharedManager].userInfoModel.user mj_keyValues] isHeaderRefersh:NO];
//    [self.table reloadData];
    [self updateCompelete];
    [self.table.mj_header beginRefreshing];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}


#pragma mark - 点击事件

/*
 * 修改完成
 */
- (void)updateCompelete {
    
    @weakify(self);
    [self.viewModel.updateRequestSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSMutableDictionary *dic = [[UserDataNew sharedManager].userInfoModel.user mj_keyValues];
        [_needUpdateInfo enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [dic setObject:obj forKey:key];
        }];
        
        [UserDataNew reWriteUserInfo:dic];
        
        [NavigateManager showMessage:@"更新成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}
/**
 * 城市获取
 */
- (void)requestDiqu{
    
    __weak typeof(self)weakSelf = self;
    [self.CityViewModel.DataCommand execute:nil];
    [self.CityViewModel.Subject subscribeNext:^(id  _Nullable x) {
        
        //        [[NSUserDefaults standardUserDefaults] setObject:x forKey:@"CITYARRAY"];
        //        [[NSUserDefaults standardUserDefaults] synchronize];
        
        CityArray = [DipuCityModel mj_objectArrayWithKeyValuesArray:x];
    }];
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x integerValue] == 0) {
            //头像
            [self getImage];
        }else if ([x integerValue] == 1){

            NameNewViewController *name = [[NameNewViewController alloc] init];
            name.placeHolder = @"请输入昵称";
            name.textValue = self.viewModel.dicInfo[@"nickname"];
            WeakSelf(self);
            name.block = ^(NSString *value) {
                [weakSelf.viewModel.dicInfo setObject:value forKey:@"nickname"];
                [weakSelf.table reloadData];
            };
            [self pushToNextVCWithNextVC:name];
        }else if ([x integerValue] == 2){//性别
            [self getSex];
        }else if ([x integerValue] == 3){//生日
            [self getBrithday];
        }else if ([x integerValue] == 4){//年龄
//            AgeNewViewController *age = [[AgeNewViewController alloc] init];
//            [self pushToNextVCWithNextVC:age];
            NameNewViewController *name = [[NameNewViewController alloc] init];
            name.placeHolder = @"请输入年龄";
            name.textValue = [NSString stringWithFormat:@"%@",self.viewModel.dicInfo[@"age"]];
            WeakSelf(self);
            name.block = ^(NSString *value) {
                [weakSelf.viewModel.dicInfo setObject:value forKey:@"age"];
                [weakSelf.table reloadData];
            };
            [self pushToNextVCWithNextVC:name];
        }else if ([x integerValue] == 5){//身高
//            HeightNewViewController *name = [[HeightNewViewController alloc] init];
//            [self pushToNextVCWithNextVC:name];
            NameNewViewController *name = [[NameNewViewController alloc] init];
            name.placeHolder = @"请输入身高(cm)";
            name.textValue = [NSString stringWithFormat:@"%@",self.viewModel.dicInfo[@"height"]];
            WeakSelf(self);
            name.block = ^(NSString *value) {
                [weakSelf.viewModel.dicInfo setObject:value forKey:@"height"];
                [weakSelf.table reloadData];
            };
            [self pushToNextVCWithNextVC:name];
        }else if ([x integerValue] == 6){//体重
//            WeightNewViewController *name = [[WeightNewViewController alloc] init];
//            [self pushToNextVCWithNextVC:name];
            NameNewViewController *name = [[NameNewViewController alloc] init];
            name.placeHolder = @"请输入体重(kg)";
            name.textValue = [NSString stringWithFormat:@"%@",self.viewModel.dicInfo[@"weight"]];
            WeakSelf(self);
            name.block = ^(NSString *value) {
                [weakSelf.viewModel.dicInfo setObject:value forKey:@"weight"];
                [weakSelf.table reloadData];
            };
            [self pushToNextVCWithNextVC:name];
        }else if ([x integerValue] == 7){//城市
//            CityViewController *map = [[CityViewController alloc] init];
//            map.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:map animated:YES];
//                [self.pickerView PickdataSources:CityArray  type:3];
            
            
            
            __weak typeof(self)weakSelf = self;
            
            [CwChooseAreaPikerView showInView:self.view block:^(NSString *province, NSString *city, NSString *area) {
                
                
//                if ([province isEqualToString:city]) {
//
//
//                    [weakSelf.viewModel.dicInfo setObject:[NSString stringWithFormat:@"%@,%@",province,area] forKey:@"city"];
//
//                }else {
//                    [weakSelf.viewModel.dicInfo setObject:[NSString stringWithFormat:@"%@,%@,%@",province,city,area] forKey:@"city"];
//
//                }
                [weakSelf.viewModel.dicInfo setObject:[NSString stringWithFormat:@"%@,%@,%@",province,city,area] forKey:@"city"];
                [weakSelf.table reloadData];
                
            }];
        }else {//联系地址
//            AddressNewViewController *adress = [[AddressNewViewController alloc] init];
//            [self pushToNextVCWithNextVC:adress];
            NameNewViewController *name = [[NameNewViewController alloc] init];
            name.placeHolder = @"请输入联系地址";
            name.textValue = [NSString stringWithFormat:@"%@",self.viewModel.dicInfo[@"address"]];
            WeakSelf(self);
            name.block = ^(NSString *value) {
                [weakSelf.viewModel.dicInfo setObject:value forKey:@"address"];
                [weakSelf.table reloadData];
            };
            [self pushToNextVCWithNextVC:name];
        }
    }];
    
//    [self.viewModel.updateExampleViewCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
        //        [NavigateManager showMessage:@"操作成功"];
        //        [self.table.mj_header beginRefreshing];
//    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MyDataNewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyDataNewTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);

    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        @strongify(self);
        NSDictionary *dicc = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:dicc];
    }];

    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {

        @strongify(self);

        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];

        //正在下啦
        if (self.table.mj_header.isRefreshing) {

//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
//                }];
//            }
            [self.table.mj_header endRefreshing];
        }

        //判断，如果item < size 显示已获取完成
//        if ([x count] < 10) {
//
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//
//        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];

    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (MyDataNewViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyDataNewViewModel alloc] init];
    }
    return _viewModel;
}
//性别
- (void)getSex{
    __weak typeof(self) weakSelf = self;
    CwPikerView *piker = [CwPikerView showInView:self.view block:^(NSString *title, NSInteger index) {
        
        [weakSelf.viewModel.dicInfo setObject:title forKey:@"sex"];
        [weakSelf.table reloadData];
        /*
         [NavigateManager showLoadingMessage:@"正在保存..."];
         [[RequestManager sharedManager] updatePic:nil
         parameters:@{@"username":USERID,@"sex":index == 0 ? @0 : @2}
         response:^(id response) {
         if (response) {
         [NavigateManager showMessage:@"修改成功"];
         [UserData reWriteUserInfo:response[@"r"][@"sex"] ForKey:@"sex"];
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [weakSelf.table reloadData];
         });
         } else {
         [NavigateManager showMessage:@"修改失败，请重试"];
         }
         }];
         */
        
    }];
    
    piker.dataSource = @[@"男",@"女"];
}
- (void)getBrithday{
    __weak typeof(self) weakSelf = self;
    
    [CwDatePiker showInView:weakSelf.view issele:NO block:^(NSDate *date) {
        
        
        NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
        [weakSelf.viewModel.dicInfo setObject:dateString forKey:@"birthday"];
        [weakSelf.table reloadData];
//        [weakSelf.timeBtn setTitle:dateString forState:UIControlStateNormal];
//        [weakSelf.dicm setObject:dateString forKey:@"schedule_date"];
    }];
}
//照片头像
- (void)getImage{
    
    WeakSelf(self);
    [self showImagePikerWithActionTitle:@"选择方式" imageEditing:YES imageBlock:^(UIImage *image) {
        [weakSelf.viewModel.dicInfo setObject:image forKey:@"head"];
        [weakSelf.table reloadData];
    }];

//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *photographicAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持拍照！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//            return;
//        }
//
//        NSString *mediaType = AVMediaTypeVideo;
//
//        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//
//        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的”设置-隐私-相机“选项中允许浮游使用相机权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//            return;
//
//        }
//
//        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.allowsEditing = YES;
//        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//
//    }];
//    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        @weakify(self);
//
//        //        [[CwChooseVideoOrPhotoManager sharedManager] chooseWithCount:1 isCamera:NO vc:self block:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isVideo) {
//        //
//        //            @strongify(self);
//        //
//        //            self.imageArray = photos;
//        //            [self editHeaderImage];
//        //        }];
//
//        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
//        imagePickerVc.allowPickingVideo = NO;
//        imagePickerVc.maxImagesCount = 1;
//        imagePickerVc.showSelectBtn = NO;
//        imagePickerVc.allowPickingOriginalPhoto = NO;
//        imagePickerVc.allowTakePicture = NO;
//        WeakSelf(self);
//        // 你可以通过block或者代理，来得到用户选择的照片.
//        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
//
//            [weakSelf.viewModel.dicInfo setObject:photos.firstObject forKey:@"head"];
//            [weakSelf.table reloadData];
////            self.imageArray = photos;
////            [self editHeaderImage];
//
//        }];
//        [self presentViewController:imagePickerVc animated:YES completion:NULL];
//
//    }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alertController addAction:photographicAction];
//    [alertController addAction:photoAction];
//    [alertController addAction:cancelAction];
//    [self presentViewController:alertController animated:YES completion:nil];
}
- (DiPuPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[NSBundle mainBundle]loadNibNamed:@"DiPuPickerView" owner:self options:nil].firstObject;
        _pickerView.frame = CGRectMake(0, ScreenHeight + 200, ScreenWidth, 200);
        [self.view addSubview:_pickerView];
        __weak typeof(self)weakSelf = self;
        _pickerView.Mblock = ^(NSString *cityNames, NSString *citys,DiPuPickerType type) {
            if (type==city) {
   
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    weakSelf.Address.text = cityNames;
                    [weakSelf.viewModel.dicInfo setObject:cityNames forKey:@"city"];
                    [weakSelf.table reloadData];
//                });
                
            
            }
            
        };
    }
    return _pickerView;
}
- (DiPuRequestCityViewModel *)CityViewModel{
    if (!_CityViewModel) {
        _CityViewModel = [[DiPuRequestCityViewModel alloc]init];
    }
    return _CityViewModel;
}


//保存
- (void)respondsToRightBtn {
    
    
    
    __weak typeof(self) weakSelf = self;
    if ([self.viewModel.dicInfo[@"head"] isKindOfClass:[UIImage class]]) {
        
        UIImage *image = self.viewModel.dicInfo[@"head"];
        
        [NavigateManager showLoadingMessage:@"正在保存..."];
//        [[RequestManager sharedManager] updatePic:UIImagePNGRepresentation(image)
//                                       parameters:@{@"username":USERID}
//                                         response:^(id response) {
//                                             if (response) {
//                                                 [weakSelf update:response];
//                                             } else {
//                                                 [NavigateManager showMessage:@"修改失败，请重试"];
//                                             }
//
//                                         }];
        [self UpImage:UIImageJPEGRepresentation(image, 0.6f) block:^(NSString *url) {
            [weakSelf update:url];
        }];
    } else {
        [self update:nil];
    }
    
    
    
}
/**
 * 上传图片
 */
-(void)UpImage:(NSData*)ImageData block:(void(^)(NSString *url))block {
    NSString *base64String = [ImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    AFHTTPSessionManager * mager = [AFHTTPSessionManager manager];
    mager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];
    NSDictionary *dict = @{@"img":[@"data:image/jpg;base64," stringByAppendingString:base64String]};
    [mager POST:@"http://www.boyihunjia.com/appapi/System/uploadimgba" parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue]==0) {
            block(responseObject[@"data"]);
        }
        [NavigateManager hiddenLoadingMessage];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NavigateManager hiddenLoadingMessage];
    }];
}

- (void)update:(NSString *)head {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.viewModel.dicInfo];
    if (head) {
        [dic setObject:head forKey:@"head"];
    }
    NSString *str = dic[@"city"];
    NSArray *arr = [str componentsSeparatedByString:@","];
    for (int i = 0;i < 3;i++) {
        NSString *key = self.viewModel.cityKeyArray[i];
        if (arr.count == 3) {
            [dic setObject:arr[i] forKey:key];
        } else {
            [dic setObject:@"" forKey:key];
        }
        
    }
    [dic removeObjectForKey:@"city"];
    
    
    [dic setObject:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setObject:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    _needUpdateInfo = dic;
    [self.viewModel.updateDataCommand execute:dic];
}


@end
