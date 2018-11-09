//
//  MyNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewViewController.h"
#import "MyNewViewModel.h"
#import "MyNewModel.h"
#import "MyNewHeader.h"
#import "SetNewViewController.h"
#import "FansViewController.h"
#import "GuanzhuSubNewViewController.h"
#import "YuENewViewController.h"
#import "XianjingDikouViewController.h"
#import "HunQinOrderSubViewController.h"
#import "ShangchengJiedanSubViewController.h"
#import "ShangchengOrderSubViewController.h"
#import "HunqingJiedanSubViewController.h"
#import "ShimingrenZhenViewController.h"
#import "XuqiuSubViewController.h"
#import "MysheTuanViewController.h"
#import "MyYaoqingHomeViewController.h"
#import "LiulanJiLuSubViewController.h"
#import "PingjiaGuanliViewController.h"
#import "HunliXInwenSubViewController.h"
#import "DianpuRenZhenSubViewController.h"
#import "MyDangQiViewController.h"
#import "MyTuceSubViewController.h"
#import "MyAnLieSubViewController.h"
#import "MyShipinSubViewController.h"
#import "FuWuCityMyViewController.h"
#import "TuiGUangZhushouViewController.h"
#import "TuijianTuanduiMyViewController.h"
#import "ShangjiaHomeSubViewController.h"
#import "HunliLiuchengViewController.h"
#import "JizhangZhuShouViewController.h"
#import "PushXuqiuViewController.h"
#import "HuangdaoDayViewController.h"
#import "DianziQingjianHomeViewController.h"
#import "RiChengNewViewController.h"
#import "FayangaoViewController.h"
#import "BoyiXueyuanSubViewController.h"
#import "UserVIPViewController.h"
#import "ShangJiaVIPViewController.h"
#import "YaoHaoYouViewController.h"
#import "DaiLiViewController.h"
#import "GuanYuWomenViewController.h"
#import "DiPuDataViewController.h"
#import "HunyinDengjiViewController.h"
#import "MybaojiaSubViewController.h"
#import "MyGoodsListViewController.h"
#import "CheckDemandViewController.h"

#import "TuanDuiCenterViewController.h"
#import "QiyeRenzhenViewController.h"
#import "GerenRenzhengViewController.h"
#import "CHengweishangjiaViewController.h"

#import "ZLIntegralShopHomeViewController.h"
#import "ZLElectronicInvitationHomeViewController.h"
#import <IQKeyboardManager.h>
#import "ZLActivitiesVoteViewController.h"

@interface MyNewViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyNewViewModel *viewModel;

@end

@implementation MyNewViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES;
    keyboardManager.enableAutoToolbar = YES;
    //重新获取用户数据
    [self updateUserInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //单元格的点击
    [self cellClick];
    //设置滑动视图
    [self setupTableView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 点击事件
- (void)cellClick {
    @weakify(self);
    //用户
    [self.viewModel.userTagSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x integerValue] == 1) {//实名认证
            ShimingrenZhenViewController *renzhen = [[ShimingrenZhenViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 2){//我的需求
            XuqiuSubViewController *vc = [[XuqiuSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 3){//我的社团
			// 判断是否已经加入社团
			if ([[UserDataNew sharedManager].userInfoModel.user.association isEqualToString:@""]) {
				MysheTuanViewController *renzhen = [[MysheTuanViewController alloc] init];
				[self pushToNextVCWithNextVC:renzhen];
			} else {
				TuanDuiCenterViewController *vc = [[TuanDuiCenterViewController alloc] init];
				[self pushToNextVCWithNextVC:vc];
			}
        }else if ([x integerValue] == 4){//我的邀请
            MyYaoqingHomeViewController *renzhen = [[MyYaoqingHomeViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 5){//评价管理
            PingjiaGuanliViewController *renzhen = [[PingjiaGuanliViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 6){//浏览记录
            LiulanJiLuSubViewController *vc = [[LiulanJiLuSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 7){//婚礼新闻
            HunliXInwenSubViewController *vc = [[HunliXInwenSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 201){//积分商城
            [self goToIntegralShop];
        }else if ([x integerValue] == 202){//活动投票
            [self goToActivitiesVote];
        }else if ([x integerValue] == 11){//发布需求
            PushXuqiuViewController *vc = [[PushXuqiuViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 12){//黄道吉日
            HuangdaoDayViewController *vc = [[HuangdaoDayViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 13){//电子请柬
            
            [self goToElectronicInvitation];
        }else if ([x integerValue] == 14){//日程安排
            RiChengNewViewController *vc = [[RiChengNewViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 15){//发言稿
            FayangaoViewController *vc = [[FayangaoViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 16){//婚礼流程
            HunliLiuchengViewController *vc = [[HunliLiuchengViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 17){//记账助手
            JizhangZhuShouViewController *vc = [[JizhangZhuShouViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 18){//登记处
            HunyinDengjiViewController *vc = [[HunyinDengjiViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 21){//博艺学院
            //待新增
        }else if ([x integerValue] == 22){//商家vip
            ShangJiaVIPViewController *vc = [[ShangJiaVIPViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 23){//用户vip
            UserVIPViewController *vc = [[UserVIPViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 24){//邀请朋友
            YaoHaoYouViewController *vc = [[YaoHaoYouViewController alloc] init];
            vc.isYaoqingYonghu = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 29){//邀请商家
            YaoHaoYouViewController *vc = [[YaoHaoYouViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 25){//代理招募
            DaiLiViewController *vc = [[DaiLiViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 26){//查看朋友婚礼
			DLog(@"查看朋友婚礼");
        }else if ([x integerValue] == 27){//关于我们
            GuanYuWomenViewController *vc = [[GuanYuWomenViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 28){//申请成为商家
            CHengweishangjiaViewController *vc = [[CHengweishangjiaViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }
        NSLog(@"%ld",[x integerValue]);
    }];
    
    //商城商家
    [self.viewModel.shangjiaTagSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x integerValue] == 1) {//婚庆接单
            self.isShangChengJie = NO;
        }else if ([x integerValue] == 2){//商城接单
            self.isShangChengJie = YES;
        }else if ([x integerValue] == 11//全部订单
                  || [x integerValue] == 12//待付款
                  || [x integerValue] == 13//待发货
                  || [x integerValue] == 14//待收货
                  || [x integerValue] == 15){//待评价
            HunqingJiedanSubViewController *vc = [[HunqingJiedanSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.statusFlag = [x integerValue] - 11;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 16//全部订单
                  || [x integerValue] == 17//待付款
                  || [x integerValue] == 18//待发货
                  || [x integerValue] == 19//待收货
                  || [x integerValue] == 20){//待评价
            ShangchengJiedanSubViewController *vc = [[ShangchengJiedanSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.statusFlag = [x integerValue] - 16;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 21){//实名认证
            ShimingrenZhenViewController *renzhen = [[ShimingrenZhenViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 22){//我的需求
            XuqiuSubViewController *vc = [[XuqiuSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 23){//我的社团
			// 判断是否已经加入社团
			if ([[UserDataNew sharedManager].userInfoModel.user.association isEqualToString:@""]) {
				MysheTuanViewController *renzhen = [[MysheTuanViewController alloc] init];
				[self pushToNextVCWithNextVC:renzhen];
			} else {
				TuanDuiCenterViewController *vc = [[TuanDuiCenterViewController alloc] init];
				[self pushToNextVCWithNextVC:vc];
			}
        }else if ([x integerValue] == 24){//我的邀请
            MyYaoqingHomeViewController *renzhen = [[MyYaoqingHomeViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 25){//评价管理
            PingjiaGuanliViewController *renzhen = [[PingjiaGuanliViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 26){//浏览记录
            LiulanJiLuSubViewController *vc = [[LiulanJiLuSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 27){//婚礼新闻
            HunliXInwenSubViewController *vc = [[HunliXInwenSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 201){//积分商城
            [self goToIntegralShop];
        }else if ([x integerValue] == 202){//活动投票
            [self goToActivitiesVote];
        }else if ([x integerValue] == 31){//店铺信息
            DiPuDataViewController * vc = [[DiPuDataViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 32){//店铺认证
            DianpuRenZhenSubViewController *vc = [[DianpuRenZhenSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 33){//我的档期
            MyDangQiViewController *dangdi = [[MyDangQiViewController alloc] init];
            [self pushToNextVCWithNextVC:dangdi];
        }else if ([x integerValue] == 34){//我的报价
			MybaojiaSubViewController *vc = [[MybaojiaSubViewController alloc] init];
			vc.titleColorSelected = MAINCOLOR;
			vc.menuViewStyle = WMMenuViewStyleLine;
			vc.automaticallyCalculatesItemWidths = YES;
			vc.progressWidth = 10;
			vc.progressViewIsNaughty = YES;
			vc.showOnNavigationBar = NO;
			vc.hidesBottomBarWhenPushed = YES;
			[self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 35){//我的商品
			MyGoodsListViewController *vc = [[MyGoodsListViewController alloc] init];
			[self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 36){//我的图册
            MyTuceSubViewController *vc = [[MyTuceSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 37){//我的视频
            MyShipinSubViewController *vc = [[MyShipinSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 38){//我的案列
            MyAnLieSubViewController *vc = [[MyAnLieSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 39){//服务城市
            FuWuCityMyViewController *fuwu = [[FuWuCityMyViewController alloc] init];
            [self pushToNextVCWithNextVC:fuwu];
        }else if ([x integerValue] == 40){//推荐团队
            TuijianTuanduiMyViewController *fuwu = [[TuijianTuanduiMyViewController alloc] init];
            [self pushToNextVCWithNextVC:fuwu];
        }else if ([x integerValue] == 41){//查看需求
			CheckDemandViewController *vc = [[CheckDemandViewController alloc] init];
			[self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 42){//推广助手
            TuiGUangZhushouViewController *fuwu = [[TuiGUangZhushouViewController alloc] init];
            [self pushToNextVCWithNextVC:fuwu];
        }else if ([x integerValue] == 43){//店铺主页
            ShangjiaHomeSubViewController *vc = [[ShangjiaHomeSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 49){//if (x.usertype == 1) {//商城
            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
            vc.id = [UserDataNew sharedManager].userInfoModel.token.userid;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 51){//发布需求
            PushXuqiuViewController *vc = [[PushXuqiuViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 52){//黄道吉日
            HuangdaoDayViewController *vc = [[HuangdaoDayViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 53){//电子请柬
            [self goToElectronicInvitation];
        }else if ([x integerValue] == 54){//日程安排
            RiChengNewViewController *vc = [[RiChengNewViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 55){//发言稿
            FayangaoViewController *vc = [[FayangaoViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 56){//婚礼流程
            HunliLiuchengViewController *vc = [[HunliLiuchengViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 57){//记账助手
            JizhangZhuShouViewController *vc = [[JizhangZhuShouViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 58){//婚姻登记处
            HunyinDengjiViewController *vc = [[HunyinDengjiViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 61){//博艺学院
            BoyiXueyuanSubViewController *vc = [[BoyiXueyuanSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 62){//商家vip
            ShangJiaVIPViewController *vc = [[ShangJiaVIPViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 63){//用户vip
            UserVIPViewController *vc = [[UserVIPViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 64){//邀请朋友
            YaoHaoYouViewController *vc = [[YaoHaoYouViewController alloc] init];
            vc.isYaoqingYonghu = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 69){//邀请商家
            YaoHaoYouViewController *vc = [[YaoHaoYouViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 65){//代理招募
            DaiLiViewController *vc = [[DaiLiViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 66){//查看朋友婚礼
			DLog(@"查看朋友婚礼");
        }else if ([x integerValue] == 67){//关于我们
            GuanYuWomenViewController *vc = [[GuanYuWomenViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }
        
    }];

    
    ///婚庆商家
    [self.viewModel.shangjiaHunQinTagSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x integerValue] == 1) {//婚庆接单
            self.isShangChengJie = NO;
        }else if ([x integerValue] == 2){//商城接单
            self.isShangChengJie = YES;
        }else if ([x integerValue] == 11//全部订单
                  || [x integerValue] == 12//待付款
                  || [x integerValue] == 13//待发货
                  || [x integerValue] == 14//待收货
                  || [x integerValue] == 15){//待评价
            HunqingJiedanSubViewController *vc = [[HunqingJiedanSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.statusFlag = [x integerValue] - 11;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 16//全部订单
                  || [x integerValue] == 17//待付款
                  || [x integerValue] == 18//待发货
                  || [x integerValue] == 19//待收货
                  || [x integerValue] == 20){//待评价
            ShangchengJiedanSubViewController *vc = [[ShangchengJiedanSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.statusFlag = [x integerValue] - 16;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 21){//实名认证
            ShimingrenZhenViewController *renzhen = [[ShimingrenZhenViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 22){//我的需求
            XuqiuSubViewController *vc = [[XuqiuSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 23){//我的社团
            // 判断是否已经加入社团
            if ([[UserDataNew sharedManager].userInfoModel.user.association isEqualToString:@""]) {
                MysheTuanViewController *renzhen = [[MysheTuanViewController alloc] init];
                [self pushToNextVCWithNextVC:renzhen];
            }else {
                TuanDuiCenterViewController *vc = [[TuanDuiCenterViewController alloc] init];
                [self pushToNextVCWithNextVC:vc];
            }
        }else if ([x integerValue] == 24){//我的邀请
            MyYaoqingHomeViewController *renzhen = [[MyYaoqingHomeViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 25){//评价管理
            PingjiaGuanliViewController *renzhen = [[PingjiaGuanliViewController alloc] init];
            [self pushToNextVCWithNextVC:renzhen];
        }else if ([x integerValue] == 26){//浏览记录
            LiulanJiLuSubViewController *vc = [[LiulanJiLuSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 27){//婚礼新闻
            HunliXInwenSubViewController *vc = [[HunliXInwenSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 201){//积分商城
            [self goToIntegralShop];
        }else if ([x integerValue] == 202){//活动投票
            [self goToActivitiesVote];
        }else if ([x integerValue] == 31){//店铺信息
            DiPuDataViewController * vc = [[DiPuDataViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 32){//店铺认证
            DianpuRenZhenSubViewController *vc = [[DianpuRenZhenSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 33){//我的档期
            MyDangQiViewController *dangdi = [[MyDangQiViewController alloc] init];
            [self pushToNextVCWithNextVC:dangdi];
        }else if ([x integerValue] == 34){//我的报价
            MybaojiaSubViewController *vc = [[MybaojiaSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 35){//我的商品
            MyGoodsListViewController *vc = [[MyGoodsListViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 36){//我的图册
            MyTuceSubViewController *vc = [[MyTuceSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 37){//我的视频
            MyShipinSubViewController *vc = [[MyShipinSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 38){//我的案列
            MyAnLieSubViewController *vc = [[MyAnLieSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 39){//服务城市
            FuWuCityMyViewController *fuwu = [[FuWuCityMyViewController alloc] init];
            [self pushToNextVCWithNextVC:fuwu];
        }else if ([x integerValue] == 40){//推荐团队
            TuijianTuanduiMyViewController *fuwu = [[TuijianTuanduiMyViewController alloc] init];
            [self pushToNextVCWithNextVC:fuwu];
        }else if ([x integerValue] == 41){//查看需求
            CheckDemandViewController *vc = [[CheckDemandViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 42){//推广助手
            TuiGUangZhushouViewController *fuwu = [[TuiGUangZhushouViewController alloc] init];
            [self pushToNextVCWithNextVC:fuwu];
        }else if ([x integerValue] == 43){//店铺主页
            ShangjiaHomeSubViewController *vc = [[ShangjiaHomeSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 49){//
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = [UserDataNew sharedManager].userInfoModel.token.userid;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 51){//发布需求
            PushXuqiuViewController *vc = [[PushXuqiuViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 52){//黄道吉日
            HuangdaoDayViewController *vc = [[HuangdaoDayViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 53){//电子请柬
            [self goToElectronicInvitation];
        }else if ([x integerValue] == 54){//日程安排
            RiChengNewViewController *vc = [[RiChengNewViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 55){//发言稿
            FayangaoViewController *vc = [[FayangaoViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 56){//婚礼流程
            HunliLiuchengViewController *vc = [[HunliLiuchengViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 57){//记账助手
            JizhangZhuShouViewController *vc = [[JizhangZhuShouViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 58){//婚姻登记处
            HunyinDengjiViewController *vc = [[HunyinDengjiViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 61){//博艺学院
            BoyiXueyuanSubViewController *vc = [[BoyiXueyuanSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 62){//商家vip
            ShangJiaVIPViewController *vc = [[ShangJiaVIPViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 63){//用户vip
            UserVIPViewController *vc = [[UserVIPViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 64){//邀请朋友
            YaoHaoYouViewController *vc = [[YaoHaoYouViewController alloc] init];
            vc.isYaoqingYonghu = YES;
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 69){//邀请商家
            YaoHaoYouViewController *vc = [[YaoHaoYouViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 65){//代理招募
            DaiLiViewController *vc = [[DaiLiViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 66){//查看朋友婚礼
            DLog(@"查看朋友婚礼");
        }else if ([x integerValue] == 67){//关于我们
            GuanYuWomenViewController *vc = [[GuanYuWomenViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }
    }];
}

- (void)setupTableView {
    [self.table registerNib:[UINib nibWithNibName:@"MyNewshangjiaCellTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"MyNewshangjiaCellTableViewCell"];
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat bottomInsetHeight = statusBarHeight == 20.0 ? 0 : 35.0;
    self.table.contentInset = UIEdgeInsetsMake(0, 0, bottomInsetHeight, 0);
    [self setHeaderView];
    @weakify(self);
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        //传入参数 进行刷新
        [self updateUserInfo];
    }];
}
- (void)setHeaderView{
    MyNewHeader *header = [[NSBundle mainBundle]loadNibNamed:@"MyNewHeader" owner:nil options:nil].firstObject;
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.frame = CGRectMake(0, 0, ScreenWidth, 522);
    self.table.tableHeaderView = header;
    @weakify(self);
    [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        //11 全部订单 12 代付款 13 待接单 14 待服务 15 待评价
        if ([x integerValue] == 11
            || [x integerValue] == 12
            || [x integerValue] == 13
            || [x integerValue] == 14
            || [x integerValue] == 15 ) {
            
            HunQinOrderSubViewController *vc = [[HunQinOrderSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.statusFlag = [x integerValue] - 11;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            
            return ;
        }
        
        //11 全部订单 12 代付款 13 待接单 14 待服务 15 待评价
        if ([x integerValue] == 16
            || [x integerValue] == 17
            || [x integerValue] == 18
            || [x integerValue] == 19
            || [x integerValue] == 20 ) {
            
            ShangchengOrderSubViewController *vc = [[ShangchengOrderSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
    
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.statusFlag = [x integerValue] - 16;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
        
        switch ([x integerValue]) {
            case 0:{//设置
                SetNewViewController *set = [[SetNewViewController alloc] init];
                [self pushToNextVCWithNextVC:set];
            }
                break;
            case 1: {//婚庆订单
                self.isShangChengDing = NO;
                break;
            }
            case 2: {//商城订单
                self.isShangChengDing = YES;
                break;
            }
            case 100: {//粉丝
                FansViewController *set = [[FansViewController alloc] init];
                [self pushToNextVCWithNextVC:set];
                break;
            }
            case 101: {//关注
                GuanzhuSubNewViewController *vc = [[GuanzhuSubNewViewController alloc] init];
                vc.titleColorSelected = MAINCOLOR;
                vc.menuViewStyle = WMMenuViewStyleLine;
                vc.automaticallyCalculatesItemWidths = YES;
                vc.progressWidth = 40;
                vc.progressViewIsNaughty = YES;
                vc.showOnNavigationBar = NO;
                vc.hidesBottomBarWhenPushed = YES;
                [self pushToNextVCWithNextVC:vc];
                break;
            }
            case 102: {//余额
                YuENewViewController *set = [[YuENewViewController alloc] init];
                [self pushToNextVCWithNextVC:set];
                break;
            }
            case 103: {//现金抵扣券
                XianjingDikouViewController *set = [[XianjingDikouViewController alloc] init];
                [self pushToNextVCWithNextVC:set];
                break;
            }
            default:
                break;
        }
    }];
}

//初始化viewModel
- (MyNewViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyNewViewModel alloc] init];
    }
    return _viewModel;
}

- (void)updateUserInfo {
    // 重新获取用户信息
    [[RequestManager sharedManager] requestUrl:URL_getNewUserInfo method:POST loding:nil dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)} progress:nil success:^(NSURLSessionDataTask *task, id response) {
        if ([response[@"code"] integerValue] == 0) {
            [UserDataNew WriteUserInfo:response[@"data"]];
            [self.table reloadData];
            [(MyNewHeader *)self.table.tableHeaderView relodata];
        }else {
            [NavigateManager showMessage:response[@"message"]];
        }
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.table.mj_header.isRefreshing) {
            [self.table.mj_header endRefreshing];
        }
    }];
}

#pragma mark - GoToIntegralShop(前往积分商城)
- (void)goToIntegralShop {
    ZLIntegralShopHomeViewController *integralShopHomeVc = [ZLIntegralShopHomeViewController new];
    integralShopHomeVc.userId = [NSString stringWithFormat:@"%ld",[UserDataNew sharedManager].userInfoModel.token.userid];
    integralShopHomeVc.token = [UserDataNew sharedManager].userInfoModel.token.token;
    [self.navigationController pushViewController:integralShopHomeVc animated:YES];
}
#pragma mark - goToElectronicInvitation(前往电子请柬)
- (void)goToElectronicInvitation {
    ZLElectronicInvitationHomeViewController *homeVc = [ZLElectronicInvitationHomeViewController new];
    homeVc.userId = [NSString stringWithFormat:@"%ld",[UserDataNew sharedManager].userInfoModel.token.userid];
    homeVc.token = [UserDataNew sharedManager].userInfoModel.token.token;
    [self.navigationController pushViewController:homeVc animated:YES];
}
#pragma mark - goToActivitiesVote(前往活动投票)
- (void)goToActivitiesVote {
    ZLActivitiesVoteViewController *activitiesVc = [ZLActivitiesVoteViewController new];
    activitiesVc.userId = [NSString stringWithFormat:@"%ld",[UserDataNew sharedManager].userInfoModel.token.userid];
    activitiesVc.token = [UserDataNew sharedManager].userInfoModel.token.token;
    [self.navigationController pushViewController:activitiesVc animated:YES];
}

@end



