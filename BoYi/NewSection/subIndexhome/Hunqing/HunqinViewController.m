//
//  HunqinViewController.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "HunqinViewController.h"
#import "HunqinViewModel.h"
#import "HunqinModel.h"
#import "SDCycleScrollView.h"
#import "AllTpyeViewController.h"
#import "AnlieListViewController.h"
#import "AnlieListSearchViewController.h"
#import "HuangdaoDayViewController.h"
#import "PushXuqiuViewController.h"
#import "DianziQingjianHomeViewController.h"
#import "FayangaoViewController.h"
#import "RiChengNewViewController.h"
#import "GetFangAnViewController.h"
#import "TebieTuijianViewController.h"
#import "WenZangDetilViewController.h"
#import "ZXVideo.h"
#import "HunLiYuYueVCViewController.h"
#import "fenLeiModel.h"
#import "BannerWebViewController.h"
#import "ZiDingYisubViewController.h"
#import "VideoPlayViewController.h"
#import "VedioView.h"
#import "MJPhotoBrowser.h"
#import "IndexSubViewController.h"
#import "ZiDingYingLanMuViewController.h"
@interface HunqinViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,retain) NSMutableArray *photosArray;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HunqinViewModel *viewModel;
@property (strong, nonatomic) SDCycleScrollView *adView;
@property (strong, nonatomic) NSMutableArray *photos;

@property (nonatomic, strong) NSArray *imageArray;
@property(nonatomic,assign)NSInteger curPage;
@end

@implementation HunqinViewController


- (void)viewWillAppear:(BOOL)animated{
    
    if ([[UserData UserDefaults:@"isRefreshing1"] isEqualToString:@"yes"]) {
        [self.table.mj_header beginRefreshing];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self setupTableView];
    self.photosArray = [NSMutableArray array];
    [self.table.mj_header beginRefreshing];
}
- (RACSubject *)seleUISubject {
    
    if (!_seleUISubject) _seleUISubject = [RACSubject subject];
    
    return _seleUISubject;
}

#pragma mark - 点击事件
- (void)tapImage:(NSArray *)urls
{
    NSInteger count = urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        
        // 替换为中等尺寸图片
        NSString *url = urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = nil;//self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;//tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
#pragma mark - 点击事件
- (void)cellClick {
    
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Youlike *x) {
        @strongify(self);
        
        Youlike *model = x;
        if ([model.typee isEqualToString:@"1"]) {//type == 1 1代表案
            
            AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
            vc.anlieID = model.id;
            [self pushToNextVCWithNextVC:vc];
            
        }else if ([model.typee isEqualToString:@"2"]){//type == 2 2 代表图册
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i < x.photourl.count; i ++) {
                
                
                [array addObject:x.photourl[i].photo];
            }
            
            [self tapImage:array];
        }else if ([model.typee isEqualToString:@"3"]){//type == 3 3 代表视频
         
    
            [VedioView showInView:[UIApplication sharedApplication].keyWindow url:model.video_url];
           
        }else {//type == 4 4 代表报价

            BaojiaDetilViewController *vc = [[BaojiaDetilViewController alloc] init];
            vc.baojiaid = model.id;
            [self pushToNextVCWithNextVC:vc];
        }
    
    }];
    //qu关注
    [self.viewModel.deleguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x[@"code"] integerValue] == 0 ) {
            //刷新视图
            self.viewModel.dataArray[self.viewModel.index - 6].follow = 0;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }
        
    }];
    //add关注
    [self.viewModel.addguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        if ([x[@"code"] integerValue] == 0 ) {
            //刷新视图
            self.viewModel.dataArray[self.viewModel.index - 6].follow = 1;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
       
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }
    }];
    //分累
    [self.viewModel.typeSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Fenleiarray *model = x;
        if (model.occupationid == 10000) {
            AllTpyeViewController *all = [[AllTpyeViewController alloc] init];
            all.isHunqin = 1;
            [self.navigationController pushViewController:all animated:YES];
            
        }else {
            AnlieListViewController *anlist = [[AnlieListViewController alloc] init];
            anlist.typeFenleiguolai = model.occupationid;
            anlist.titlew = model.proname;
            [self pushToNextVCWithNextVC:anlist];
        }
        
    }];
    //常用工具
    [self.viewModel.gongjuSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        if (![UserDataNew UserLoginState]) {
            
            NewLoginViewController *vc = [[NewLoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
        if ([x integerValue] == 0) {//发布需求
            PushXuqiuViewController *push = [[PushXuqiuViewController alloc] init];
            [self pushToNextVCWithNextVC:push];
        }else if ([x integerValue] == 1) {//黄道吉日
            HuangdaoDayViewController *huangdao = [[HuangdaoDayViewController alloc] init];
            [self pushToNextVCWithNextVC:huangdao];
        }else if ([x integerValue] == 2) {//电子请柬
            
            DianziQingjianHomeViewController *qingjian = [[DianziQingjianHomeViewController alloc] init];
            [self pushToNextVCWithNextVC:qingjian];
            
        }else if ([x integerValue] == 3) {//发言稿
            
            FayangaoViewController *vc = [[FayangaoViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
        }else if ([x integerValue] == 4) {//记账助手
            JizhangZhuShouViewController *fayan = [[JizhangZhuShouViewController alloc] init];
            [self pushToNextVCWithNextVC:fayan];
        }else {//更多
            self.navigationController.tabBarController.selectedIndex = 4;
        }
        
    }];
    //个人列表
    [self.viewModel.gerenSHangjiaListSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Dataone *model = x;
        if ([NSStringFormatter(model.src) isBlankString]) {
            if (model.aptype == 1) {//婚庆商家
                
                NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
                vc.shopid = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else if (model.aptype == 2){//商城商家
                ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
                vc.id = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else if (model.aptype == 3){//案例
                
                AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
                vc.anlieID = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else if (model.aptype == 5){//商品
                
                ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
                vc.shangpinID = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else {//报价
                BaojiaDetilViewController *vc = [[BaojiaDetilViewController alloc] init];
                vc.baojiaid = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }
        }else {
            BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
            bannerweb.hidesBottomBarWhenPushed = YES;
            bannerweb.urlString = NSStringFormatter(model.src);
            [self pushToNextVCWithNextVC:bannerweb];
        }
        
    }];
    //团队列表
    [self.viewModel.tuanduiSHangjiaListSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Datatwo *model = x;
        if ([NSStringFormatter(model.src) isBlankString]) {
            if (model.aptype == 1) {//婚庆商家
                
                NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
                vc.shopid = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else if (model.aptype == 2){//商城商家
                ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
                vc.id = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else if (model.aptype == 3){//案例
                
                AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
                vc.anlieID = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else if (model.aptype == 5){//商品
                
                ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
                vc.shangpinID = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }else {//报价
                BaojiaDetilViewController *vc = [[BaojiaDetilViewController alloc] init];
                vc.baojiaid = model.aptid;
                [self pushToNextVCWithNextVC:vc];
            }
        }else {
            BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
            bannerweb.hidesBottomBarWhenPushed = YES;
            bannerweb.urlString = NSStringFormatter(model.src);
            [self pushToNextVCWithNextVC:bannerweb];
        }
    }];
    //热门活动五个按钮
    [self.viewModel.hotHuoFiveBtnSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.viewModel.model.xiaoguanggaoyi.count > 0) {
            if ([x integerValue] == 0) {
                Xiaoguanggaoyi *model = self.viewModel.model.xiaoguanggaoyi[0];
                
                if ([NSStringFormatter(model.src) isBlankString]) {
                    if (model.aptype == 1) {//婚庆商家
                        
                        NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
                        vc.shopid = model.aptid;
                        [self pushToNextVCWithNextVC:vc];
                    }else if (model.aptype == 2){//商城商家
                        ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
                        vc.id = model.aptid;
                        [self pushToNextVCWithNextVC:vc];
                    }else if (model.aptype == 3){//案例
                        
                        AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
                        vc.anlieID = model.aptid;
                        [self pushToNextVCWithNextVC:vc];
                    }else if (model.aptype == 5){//商品
                        
                        ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
                        vc.shangpinID = model.aptid;
                        [self pushToNextVCWithNextVC:vc];
                    }else {//报价
                        BaojiaDetilViewController *vc = [[BaojiaDetilViewController alloc] init];
                        vc.baojiaid = model.aptid;
                        [self pushToNextVCWithNextVC:vc];
                    }
                }else {
                    BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
                    bannerweb.hidesBottomBarWhenPushed = YES;
                    bannerweb.urlString = NSStringFormatter(model.src);
                    [self pushToNextVCWithNextVC:bannerweb];
                }
            }else if ([x integerValue] == 1) {
                TebieTuijianViewController *tuandui = [[TebieTuijianViewController alloc] init];
                tuandui.guanggaoID = self.viewModel.model.remenhuodong.rmhd1.adid;
                [self pushToNextVCWithNextVC:tuandui];
            }else if ([x integerValue] == 2) {
                HunLiYuYueVCViewController *hunli = [[HunLiYuYueVCViewController alloc] init];
                hunli.guanggaoID = self.viewModel.model.remenhuodong.rmhd2.adid;
                [self pushToNextVCWithNextVC:hunli];
            }else if ([x integerValue] == 3) {
                
//                NSMutableArray *array =  [NSMutableArray array];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd3.title];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd4.title];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd5.title];
//
//                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"zidingyilianmu"];
//
//                ZiDingYisubViewController *vc = [[ZiDingYisubViewController alloc] init];
//                vc.menuViewStyle = WMMenuViewStyleLine;
//                vc.automaticallyCalculatesItemWidths = YES;
//                vc.progressWidth = 80;
//                vc.progressViewIsNaughty = YES;
//                vc.showOnNavigationBar = NO;
//                vc.hidesBottomBarWhenPushed = YES;
//                vc.guanggaoID1 = self.viewModel.model.remenhuodong.rmhd1.adid;
//                vc.guanggaoID2 = self.viewModel.model.remenhuodong.rmhd2.adid;
//                vc.guanggaoID3 = self.viewModel.model.remenhuodong.rmhd3.adid;
//
//                [self pushToNextVCWithNextVC:vc];
                
                ZiDingYingLanMuViewController *vc = [[ZiDingYingLanMuViewController alloc] init];
                vc.statusFlag = self.viewModel.model.remenhuodong.rmhd1.adid;
                vc.type = 3;
                vc.name = self.viewModel.model.remenhuodong.rmhd3.title;
                [self pushToNextVCWithNextVC:vc];
                
            }else if ([x integerValue] == 4) {
//                NSMutableArray *array =  [NSMutableArray array];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd3.title];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd4.title];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd5.title];
//
//                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"zidingyilianmu"];
//
//                ZiDingYisubViewController *vc = [[ZiDingYisubViewController alloc] init];
//                vc.menuViewStyle = WMMenuViewStyleLine;
//                vc.automaticallyCalculatesItemWidths = YES;
//                vc.progressWidth = 80;
//                vc.titleColorNormal = RGBA(137, 137, 137, 1);
//                vc.titleColorSelected = [UIColor whiteColor];
//                vc.progressViewIsNaughty = YES;
//                vc.showOnNavigationBar = NO;
//                vc.selectIndex = 1;
//                vc.hidesBottomBarWhenPushed = YES;
//
//                vc.guanggaoID1 = self.viewModel.model.remenhuodong.rmhd1.adid;
//                vc.guanggaoID2 = self.viewModel.model.remenhuodong.rmhd2.adid;
//                vc.guanggaoID3 = self.viewModel.model.remenhuodong.rmhd3.adid;
//                [self pushToNextVCWithNextVC:vc];
                
                ZiDingYingLanMuViewController *vc = [[ZiDingYingLanMuViewController alloc] init];
                vc.statusFlag = self.viewModel.model.remenhuodong.rmhd2.adid;
                vc.name = self.viewModel.model.remenhuodong.rmhd4.title;
                vc.type = 4;
                [self pushToNextVCWithNextVC:vc];
            }else {
//                NSMutableArray *array =  [NSMutableArray array];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd3.title];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd4.title];
//                [array addObject:self.viewModel.model.remenhuodong.rmhd5.title];
//
//                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"zidingyilianmu"];
//
//                ZiDingYisubViewController *vc = [[ZiDingYisubViewController alloc] init];
//                vc.menuViewStyle = WMMenuViewStyleLine;
//                vc.automaticallyCalculatesItemWidths = YES;
//                vc.progressWidth = 80;
//                vc.titleColorNormal = RGBA(137, 137, 137, 1);
//                vc.titleColorSelected = [UIColor whiteColor];
//                vc.progressViewIsNaughty = YES;
//                vc.showOnNavigationBar = NO;
//                vc.selectIndex = 2;
//                vc.hidesBottomBarWhenPushed = YES;
//
//                vc.guanggaoID1 = self.viewModel.model.remenhuodong.rmhd1.adid;
//                vc.guanggaoID2 = self.viewModel.model.remenhuodong.rmhd2.adid;
//                vc.guanggaoID3 = self.viewModel.model.remenhuodong.rmhd3.adid;
//                [self pushToNextVCWithNextVC:vc];
                ZiDingYingLanMuViewController *vc = [[ZiDingYingLanMuViewController alloc] init];
                vc.statusFlag = self.viewModel.model.remenhuodong.rmhd3.adid;
                vc.name = self.viewModel.model.remenhuodong.rmhd5.title;
                vc.type = 5;
                [self pushToNextVCWithNextVC:vc];
            }
        }
    }];
    //查看案例和我要办婚礼
    [self.viewModel.lookMakeHunliBtnSelectSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        if ([x integerValue] == 0) {
            AnlieListSearchViewController *search = [[AnlieListSearchViewController alloc] init];
            search.types = 0;
            [self pushToNextVCWithNextVC:search];
        }else {
            GetFangAnViewController *vc = [[GetFangAnViewController alloc] init];
            [self pushToNextVCWithNextVC:vc];
            
        }
    }];
    [self.viewModel.loginSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }];
}

#pragma mark - view
- (void)setupBannerView {

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    header.backgroundColor = [UIColor whiteColor];
    self.adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 170) delegate:self placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.adView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.adView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.adView.pageDotColor = RGBA(220, 146, 196, 1);
    self.adView.autoScrollTimeInterval = 5.0;
    self.adView.showPageControl = YES;
    [header addSubview:self.adView];
    self.table.tableHeaderView = header;
}
#pragma mark - 点击事件
//banner 点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    Guanggaolunbo *model = self.photos[index];
    
    if ([NSStringFormatter(model.src) isBlankString]) {
        if (model.aptype == 1) {//婚庆商家
            
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }else if (model.aptype == 2){//商城商家
            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
            vc.id = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }else if (model.aptype == 3){//案例
            
            AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
            vc.anlieID = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }else if (model.aptype == 5){//商品
            
            ShangpinNewDetilViewController *vc = [[ShangpinNewDetilViewController alloc] init];
            vc.shangpinID = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }else {//报价
            BaojiaDetilViewController *vc = [[BaojiaDetilViewController alloc] init];
            vc.baojiaid = model.aptid;
            [self pushToNextVCWithNextVC:vc];
        }
    }else {
        BannerWebViewController *bannerweb = [[BannerWebViewController alloc] init];
        bannerweb.hidesBottomBarWhenPushed = YES;
        bannerweb.urlString = NSStringFormatter(model.src);
        [self pushToNextVCWithNextVC:bannerweb];
    }
}
//配置tableView
- (void)setupTableView {
    
    [self.table registerNib:[UINib nibWithNibName:@"HunqinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunqinTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunqinTwoTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunqinTwoTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunQinThreeTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunQinThreeTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunqinFourTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunqinFourTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunqinfiveTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunqinfiveTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunqinSixTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunqinSixTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunqinsevenTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunqinsevenTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunqinEightTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunqinEightTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"HunqinNineTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HunqinNineTableViewCell"];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    [self setupBannerView];
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        _curPage = 1;
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@(_curPage) forKey:@"p"];
        if ([UserDataNew sharedManager].userInfoModel.token.token) {
            if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
            }
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [self.viewModel.refreshDataCommand execute:dic];
        }else {
            
            if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
                [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
            }
            
            [self.viewModel.refreshDataCommand execute:dic];
            
        }
        [UserData UserDefaults:@"no" key:@"isRefreshing1"];
        //分类列表
        
        [self.viewModel.fenleilistDataCommand execute:@{}];
    }];
    [self.viewModel.fenleilistUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        //分类数据处理
        self.viewModel.fenleiArray = [Fenleiarray mj_objectArrayWithKeyValuesArray:x];

        NSMutableArray *arrayName = [[NSMutableArray alloc] init];
        NSMutableArray *arrayID = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.viewModel.fenleiArray.count; i ++) {
            Fenleiarray *model = self.viewModel.fenleiArray[i];
            NSString *name = model.proname;
            NSInteger Id = model.occupationid;
            [arrayName addObject:name];
            [arrayID addObject:@(Id)];
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrayName forKey:@"zhiweiname"];
        [[NSUserDefaults standardUserDefaults] setObject:arrayID forKey:@"zhiweiid"];
        
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
     
    }];
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        //数据处理
        HunqinModel *model = [[HunqinModel alloc] init];
        model = [HunqinModel mj_objectWithKeyValues:x];
        self.viewModel.model = model;
        self.photos = [NSMutableArray arrayWithArray:model.guanggaolunbo];
        [self configDataForHeaderCode:self.photos];
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
//                _curPage ++;
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//                    [dic setValue:@(_curPage) forKey:@"p"];
//                    //传入参数 进行刷新
//                    if ([UserDataNew sharedManager].userInfoModel.token.token) {
//
//                        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
//                        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
//                        if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
//                            [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
//                        }
//
//                        [self.viewModel.refreshDataCommand execute:dic];
//                    }else {
//                        if (![[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] isBlankString]) {
//                            [dic setValue:[NSString stringWithFormat:@"%@",[UserData UserDefaults:@"cityCityid"]] forKey:@"cityid"];
//                        }
//                        [self.viewModel.refreshDataCommand execute:dic];
//                    }
//
//                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
//        if ([x[@"youlike"] count] < 20) {
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
- (void)configDataForHeaderCode:(NSMutableArray *)array{
    NSMutableArray *ay = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        
        Guanggaolunbo *model = array[i];
        [ay addObject: model.wapimg];
        
    }
    self.adView.imageURLStringsGroup = ay;
}

//初始化viewModel
- (HunqinViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HunqinViewModel alloc] init];
    }
    return _viewModel;
}

@end
