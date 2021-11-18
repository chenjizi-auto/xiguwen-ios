//
//  IndexSubViewController.m
//  BoYi
//
//  Created by heng on 2017/11/25.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "IndexSubViewController.h"
#import "AnlieViewController.h"
#import "ShopcityViewController.h"
#import "HunqinViewController.h"
#import "HotViewController.h"
#import "ShetuanViewController.h"
#import "CityViewController.h"
#import "SearchNewViewController.h"
#import "CHadangsubViewController.h"
#import "TebieTuijianViewController.h"
#import "AnlieListModel.h"
#import "AnlieListSearchModel.h"
#import "NewShangjiaModel.h"
#import "AppUpdate.h"

#import "ZLHTTPSessionManager.h"

@interface IndexSubViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSArray *titleNames;



@end

@implementation IndexSubViewController
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityName"]] isBlankString]) {
        self.city.text = [UserData UserDefaults:@"cityName"];
    }

    if ([[UserDataNew UserDefaults:@"indexType"] isEqualToString:@"isfour"]) { 
        self.selectIndex = 4;
    }
    [self getNewApp];
    [self requestShopState];
}

- (void)requestShopState {
    __weak typeof(self)weakSelf = self;
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/index/shop_online_status" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            NSDictionary *infoDict = responseObject[@"data"];
            if ([infoDict[@"onlinestatus"] integerValue]) {
                if ([infoDict[@"onlinestatus"] integerValue] == 2) {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"尊敬的商家，您的店铺当前处于下线状态，是否上线店铺？" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
                    [alert addAction:defaultAction];
                    
                    defaultAction = [UIAlertAction actionWithTitle:@"上线" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                        [weakSelf shopOnline];
                    }];
                    [alert addAction:defaultAction];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
            return;
        }
        
    }];
}
- (void)shopOnline {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"on"] = @(1);
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/index/shop_online" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if (![responseObject[@"code"] integerValue]) {
                [NavigateManager showMessage:@"上线成功！"];
                return;
            }
            return;
        }
        
    }];
}

//benben
- (void)getNewApp{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *dic = @{@"code":appCurVersion};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/system/iseditionios"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                  
                                               if ([[NSString stringWithFormat:@"%@",response[@"data"][@"isshenhezhong"]] isEqualToString:@"1"]) {
                                                   NSLog(@"%@",response[@"data"]);
                                               }else {
                                                   
                                                   NSLog(@"当前应用软件版本:%@",appCurVersion);
                                                   if (![response[@"data"][@"versionname"] isEqualToString:appCurVersion]) {
                                                       [AppUpdate showInView:[UIApplication sharedApplication].keyWindow content:[NSString stringWithFormat:@"%@",response[@"data"][@"message"]] block:^(NSDictionary *dic) {
                                                       
                                                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/id1218673370?l=zh&ls=1&mt=8"]];
                                                       }];
                                                   }
                                                   
                                               }
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       }];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.titleColorSelected = MAINCOLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 32;
    }
   //
    
}
- (void)tongzhi:(NSNotification *)text{
    self.selectIndex = 4;
}

- (IBAction)mapAC:(UIButton *)sender {
    CityViewController *map = [[CityViewController alloc] init];
    map.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:map animated:YES];
}
- (IBAction)searchAC:(UIButton *)sender {
    if (![UserDataNew UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return ;
    }else {
        SearchNewViewController *vc = [[SearchNewViewController alloc] init];
        vc.currentCityName = self.city.text;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
- (IBAction)lookAC:(UIButton *)sender {
    
    CHadangsubViewController *vc = [[CHadangsubViewController alloc] init];
    vc.titleColorSelected = MAINCOLOR;
    vc.menuViewStyle = WMMenuViewStyleLine;
    vc.automaticallyCalculatesItemWidths = YES;
    vc.progressWidth = 40;
//    vc.fenleiArray = self
    vc.progressViewIsNaughty = YES;
    vc.showOnNavigationBar = NO;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"婚庆",
                        @"商城",
//                        @"热门",
                        @"社团",
                        @"案例"];
    }
    return _titleNames;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titleNames.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleNames[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    AnlieViewController *Anlie = [[AnlieViewController alloc] init];
    ShopcityViewController *Shopcity = [[ShopcityViewController alloc] init];
    HunqinViewController *hunqin = [[HunqinViewController alloc] init];
    HotViewController *Hot = [[HotViewController alloc] init];
    ShetuanViewController *Shetuan = [[ShetuanViewController alloc] init];

    @weakify(self);
    [hunqin.seleUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.selectIndex = 4;
        
    }];
    if (index == 0) {
        return hunqin;
    }else if (index == 1) {
        return Shopcity;
    }else if (index == 2) {
//        return Hot;
        return Shetuan;
    }else {
        return Anlie;
    }
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    ZL_Navigation_Height(navigationHeight);
    CGFloat height = navigationHeight;
    return CGRectMake(leftMargin, height, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY - 48);
}


@end




