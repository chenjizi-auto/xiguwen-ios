//
//  NewShangjiaViewController.m
//  BoYi
//
//  Created by heng on 2017/12/21.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewShangjiaViewController.h"
#import "NewShangjiaViewModel.h"
#import "NewShangjiaModel.h"
#import "NewShangjiaTableViewCell.h"
#import "BaojiaDetilViewController.h"
#import "ShangpinNewDetilViewController.h"
#import "AnlieNewDetilViewController.h"
#import "GetFangAnViewController.h"
#import "HuifuiPL.h"
#import "MJPhotoBrowser.h"
#import "VedioView.h"
#import "HunqinQuanModel.h"
#import "DongtaiDetilViewController.h"
@interface NewShangjiaViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NewShangjiaViewModel *viewModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property(nonatomic,assign)NSInteger curPageBaojia;
@property(nonatomic,assign)NSInteger curPageZuopin;
@property(nonatomic,assign)NSInteger curPageDongtai;
@property(nonatomic,assign)NSInteger curPagePinglun;

@property (nonatomic,retain) NSMutableArray *photosArray;

@property (nonatomic, strong) NSArray *imageArray;

@property (strong,nonatomic) ShareNewmodel *sharemodel;
@end

@implementation NewShangjiaViewController



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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家详情";
    [self addPopBackBtn];
    
    [self setupTableView];
    [self cellClick];
    [self.table.mj_header beginRefreshing];
    if (isIPhoneX) {
        self.height.constant = 84;
    }
    [self addRightBtnWithTitle:nil image:@"分享的副本"];
    [self shareData];
	
	WeakSelf(self);
	[self.viewModel.hiddenNavSubject subscribeNext:^(NSNumber *x) {
//		weakSelf.navigationController.navigationBar.translucent = NO;
//		CGFloat navAlpha = 1 - [x floatValue]/64;
//		[weakSelf.navigationController.navigationBar setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:navAlpha]];
//		weakSelf.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.0 alpha:navAlpha];
//		[weakSelf.navView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:navAlpha]];
//		[weakSelf.navigationController.navigationBar setAlpha:navAlpha];
	}];
	
}
- (void)respondsToRightBtn {
    if (self.sharemodel) {
        [CwShareManager shareWebPageToPlatformWithUrl:self.sharemodel.url
                                                image:self.sharemodel.image
                                                title:self.sharemodel.title
                                                descr:self.sharemodel.descr
                                                   vc:self
                                           completion:^(id data, NSError *error) {
                                               
                                           }];
    }
}
- (void)shareData{
    NSDictionary *dic = @{@"id":@(self.shopid)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxiangshop"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.sharemodel = [ShareNewmodel mj_objectWithKeyValues:response[@"data"]];
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];
                                           
                                       }];
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
    }else {
        //分享
    }
}
- (void)isLogin{
    if (![UserDataNew UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
}
- (IBAction)allaction:(UIButton *)sender {
    if (![UserDataNew UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
    
    if (sender.tag == 109) {//im

        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.viewModel.model.user.userid] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 110) {//电话
        if (self.viewModel.model.user.mobile) {
            NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.viewModel.model.user.mobile];
            CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
            if (version >= 10.0) {
                /// 大于等于10.0系统使用此openURL方法
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
            }
        }
    }else if (sender.tag == 111) {//关注
        if ([UserDataNew sharedManager].userInfoModel.token.userid == self.viewModel.model.user.userid) {
            [NavigateManager showMessage:@"自己不能关注自己"];
            return ;
        }
        if (self.viewModel.model.userf) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.user.userid] forKey:@"id"];
            [self.viewModel.deleguanzhuCommand execute:dic];
        }else {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.user.userid] forKey:@"id"];
            [self.viewModel.addguanzhuCommand execute:dic];
        }
        
    }else {//预约
        GetFangAnViewController *vc = [[GetFangAnViewController alloc] init];
        [self pushToNextVCWithNextVC:vc];
    }
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    
    //看图
    [self.viewModel.lookImageSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        NSMutableArray *array = x;
        [self tapImage:array];
    }];
    
    [self.viewModel.refreshUITypeSubject subscribeNext:^(NewShangjiaModel *x) {
        @strongify(self);
        [self.table setContentOffset:CGPointMake(0,0) animated:YES];
        
        if (self.viewModel.markType == 0) {
            _curPagePinglun = 1;
            
            if ([UserDataNew UserLoginState]) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:@(self.shopid) forKey:@"id"];
                [self.viewModel.refreshDataCommand execute:dic];
            }else {
                [self.viewModel.refreshDataCommand execute:@{@"id":@(self.shopid)}];
            }
            
            
            [self.viewModel.refrepinglunDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPagePinglun)}];
        }else if (self.viewModel.markType == 1) {
            _curPageBaojia = 1;
            [self.viewModel.refreshBaojiaListDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPageBaojia)}];
        }else if (self.viewModel.markType == 2) {
            _curPageZuopin = 1;
            [self.viewModel.refreZuopinListDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPageZuopin)}];
        }else if (self.viewModel.markType == 3) {
            _curPagePinglun = 1;
            [self.viewModel.refrepinglunDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPagePinglun)}];
            
        }else if (self.viewModel.markType == 4) {
            _curPageDongtai = 1;
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
      
            [dic setValue:@(self.shopid) forKey:@"id"];
            [dic setValue:@(_curPageDongtai) forKey:@"p"];
            if ([UserDataNew sharedManager].userInfoModel.token.token) {
                
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
     
                [self.viewModel.refreDongtaiListDataCommand execute:dic];
            }else {

                [self.viewModel.refreDongtaiListDataCommand execute:dic];
            }
            
            
        }else if (self.viewModel.markType == 5) {
            [self.viewModel.refredangqiListDataCommand execute:@{@"id":@(self.shopid),@"p":@(1),@"rows":@"1000"}];
        }else {
            [self.viewModel.refreziliaoDataCommand execute:@{@"userid":@(self.shopid)}];
        }
//        [self.table.mj_header beginRefreshing];
    }];
    //观看图片
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger index = [x integerValue];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.viewModel.dataArrayDongtai[index].photourl.count; i ++) {
       
            [array addObject:self.viewModel.dataArrayDongtai[index].photourl[i].photourl];
        }
        [self tapImage:array];
    }];
    //首页 点击报价
    [self.viewModel.shouyeSubject subscribeNext:^(Baojiashangjiafen *x) {
        @strongify(self);
        BaojiaDetilViewController *index = [[BaojiaDetilViewController alloc] init];
        
        index.baojiaid = x.quotationid;
        [self pushToNextVCWithNextVC:index];
    }];
    //首页 点击案列
    [self.viewModel.zuopinindexSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        Zuopinnewfen *model = x;
        if ([model.type isEqualToString:@"sp"]) {
            
            [VedioView showInView:[UIApplication sharedApplication].keyWindow url:model.video_url];
            
        }else if ([model.type isEqualToString:@"al"]) {
            AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
            vc.anlieID = model.id;
            [self pushToNextVCWithNextVC:vc];
        }else {
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < model.photou.count; i++) {
                [array addObject:model.photou[i].photo];
            }
            [self tapImage:array];
        }
        
        
    }];
    
    //tpye = 1报价
    [self.viewModel.baojiaSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        BaojiaDetilViewController *baojia = [[BaojiaDetilViewController alloc] init];
        Baojiashangjiafen *model = x;
        baojia.baojiaid = model.quotationid;
        [self pushToNextVCWithNextVC:baojia];
    }];
    [self.viewModel.zuopinSubject subscribeNext:^(NewShangjiaModel *x) {
        @strongify(self);
    }];
    [self.viewModel.pingjiaSubject subscribeNext:^(NewShangjiaModel *x) {
        @strongify(self);
    }];
    [self.viewModel.dongtaiSubject subscribeNext:^(NewShangjiaModel *x) {
        @strongify(self);
    }];
    [self.viewModel.dangqiSubject subscribeNext:^(NewShangjiaModel *x) {
        @strongify(self);
    }];
    //拨打电话
    [self.viewModel.iphoneSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (![UserDataNew UserLoginState]) {
            //预约cell
            NewLoginViewController *vc = [[NewLoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
        if (self.viewModel.model.user.mobile) {
            NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.viewModel.model.user.mobile];
            CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
            if (version >= 10.0) {
                /// 大于等于10.0系统使用此openURL方法
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
            }
        }
        
    }];
    //更多报价
    [self.viewModel.moreBaojiaSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewModel.markType = 1;
        [self.table.mj_header beginRefreshing];
    }];
    //更多作品
    [self.viewModel.morezuopinSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewModel.markType = 2;
        [self.table.mj_header beginRefreshing];
    }];
    //点击作品
    [self.viewModel.moreBaojiaSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
    }];
    //点击推荐
    [self.viewModel.tuijianSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        Tuijiantd *model = x;
        NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
        vc.shopid = model.shopcode;
        [self pushToNextVCWithNextVC:vc];
    }];
    
    //关注
    [self.viewModel.addguanUISubject subscribeNext:^(id  _Nullable x) {
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.model.userf = 1;
            self.isGuanzhuImage.image = [UIImage imageNamed:@"已关注"];
        }
    }];
    //取消关注
    [self.viewModel.deleteguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            self.viewModel.model.userf = 0;
            self.isGuanzhuImage.image = [UIImage imageNamed:@"关注"];
        }
    }];
    //评论
    [self.viewModel.pinglunseleUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [self isLogin];
        Dongtaiarray *model = x;
//        [HuifuiPL showInView:self.view setid:model.id block:^(NSString *date) {
//            [self.table.mj_header beginRefreshing];
//        }];
        
        Hunqinnewarray *modelnew = [[Hunqinnewarray alloc] init];
        modelnew.zan = model.zan;
        modelnew.shifouzan = model.dianzan;
        modelnew.follow = model.dianzan;
        
        
        DongtaiDetilViewController *dongtai = [[DongtaiDetilViewController alloc] init];
        dongtai.id = model.id;
        dongtai.superModel = modelnew;
        
        [self pushToNextVCWithNextVC:dongtai];
    }];
    
    //点赞
    [self.viewModel.dianzanUISubject subscribeNext:^(id  _Nullable x) {
        
        
        @strongify(self);
        [self isLogin];
        Dongtaiarray *model = x;
        if (model.dianzan) {
            
        }else {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",model.id] forKey:@"id"];
            [self.viewModel.dianzanCommand execute:dic];
        }
        
    }];
    //点赞成功回调
    [self.viewModel.dianzansuessUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if ([x[@"code"] integerValue] == 0 ) {
            //刷新视图
            self.viewModel.dataArrayDongtai[self.viewModel.index - 1].dianzan = 1;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.viewModel.index inSection:0];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [NavigateManager showMessage:x[@"message"]];
        }

    }];
    
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    self.viewModel.markType = 0;
//    [self.table registerNib:[UINib nibWithNibName:@"NewShangjiaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewShangjiaTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"ShangjiaIndexTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShangjiaIndexTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"ShangjianewTwoTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShangjianewTwoTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"ShangjiaNewthreeTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShangjiaNewthreeTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"ShangjianewFourTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ShangjianewFourTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"ZuopinNewTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ZuopinNewTableViewCell"];
//    
//    [self.table registerNib:[UINib nibWithNibName:@"teshupingjiaTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"teshupingjiaTableViewCell"];
//    
//    [self.table registerNib:[UINib nibWithNibName:@"BaojiaNewTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BaojiaNewTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"ZuopinNewTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ZuopinNewTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"PingjiaNewViewTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"PingjiaNewViewTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"DongtaiNewViewTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"DongtaiNewViewTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"ZiliaoNewTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"ZiliaoNewTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"DangqiNewTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"DangqiNewTableViewCell"];

    







    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        //id = 16有数据
        if (self.viewModel.markType == 0) {
            _curPagePinglun = 1;
            
            if ([UserDataNew UserLoginState]) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:@(self.shopid) forKey:@"id"];
                [self.viewModel.refreshDataCommand execute:dic];
            }else {
                [self.viewModel.refreshDataCommand execute:@{@"id":@(self.shopid)}];
            }
            [self.viewModel.refrepinglunDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPagePinglun)}];
        }else if (self.viewModel.markType == 1) {
            _curPageBaojia = 1;
            [self.viewModel.refreshBaojiaListDataCommand execute:@{@"rows":@"100",@"id":@(self.shopid),@"p":@(_curPageBaojia)}];
        }else if (self.viewModel.markType == 2) {
            _curPageZuopin = 1;
            [self.viewModel.refreZuopinListDataCommand execute:@{@"rows":@"100",@"id":@(self.shopid),@"p":@(_curPageZuopin)}];
        }else if (self.viewModel.markType == 3) {
            _curPagePinglun = 1;
            [self.viewModel.refrepinglunDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPagePinglun)}];
            
        }else if (self.viewModel.markType == 4) {
            _curPageDongtai = 1;
            [self.viewModel.refreDongtaiListDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPageDongtai)}];
        }else if (self.viewModel.markType == 5) {
            [self.viewModel.refredangqiListDataCommand execute:@{@"id":@(self.shopid),@"p":@(1),@"rows":@"1000"}];
        }else {
            [self.viewModel.refreziliaoDataCommand execute:@{@"userid":@(self.shopid)}];
        }
        
        
    }];
    
    //请求结束首页
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        if (self.viewModel.model.userf) {
            self.isGuanzhuImage.image = [UIImage imageNamed:@"已关注"];
        }else {
            self.isGuanzhuImage.image = [UIImage imageNamed:@"关注"];
        }
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
        
            [self.table.mj_header endRefreshing];
        }
    
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //请求报价结束
    [self.viewModel.BaojiaListUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    _curPageBaojia ++;
//        
//                    [self.viewModel.refreshBaojiaListDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPageBaojia)}];
//                }];
//            }
            [self.table.mj_header endRefreshing];
        }
        
//        //判断，如果item < size 显示已获取完成
//        NSMutableArray *array = x[@"baojia"];
//        if (array.count < 10) {
//
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//
//        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//        [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.table reloadData];
    }];
    //请求作品结束
    [self.viewModel.ZuopinListUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    _curPageZuopin ++;
//
//                    [self.viewModel.refreZuopinListDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPageZuopin)}];
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
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    //请求作品结束
    [self.viewModel.DongtaiListUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    _curPageDongtai ++;
//                    
//                    [self.viewModel.refreDongtaiListDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPageDongtai)}];
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
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [self.viewModel.pinglunUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel Convertin:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    _curPagePinglun ++;
//
//                    [self.viewModel.refreDongtaiListDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPagePinglun)}];
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
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    //请求结束档期
    [self.viewModel.dangqiUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            [self.table.mj_header endRefreshing];
        }
        //刷新视图
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    //请求结束资料
    [self.viewModel.ziliaoUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            [self.table.mj_header endRefreshing];
        }
        //刷新视图
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    //处理请求失败
    [self.viewModel.refreshBaojiaListDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    //处理请求失败
    [self.viewModel.refreZuopinListDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    //处理请求失败
    [self.viewModel.refreDongtaiListDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    //处理请求失败
    [self.viewModel.refredangqiListDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    //处理请求失败
    [self.viewModel.refreziliaoDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    //处理请求失败
    [self.viewModel.refrepinglunDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
    
}

//初始化viewModel
- (NewShangjiaViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[NewShangjiaViewModel alloc] init];
    }
    return _viewModel;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//	CGPoint point = scrollView.contentOffset;
//	
//	//	if (self.headerHeight.constant > 64 && self.headerHeight.constant < 150) {
//	//		self.headerHeight.constant = 150 - point.y;
//	if (point.y >= 0) {
////		self.topHeight.constant = -point.y;
//		[self.navigationController.navigationBar setAlpha:point.y/64];
//	}
//	//	}
//}


@end
