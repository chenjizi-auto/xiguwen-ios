//
//  AnlieNewDetilViewController.m
//  BoYi
//
//  Created by heng on 2017/12/24.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieNewDetilViewController.h"
#import "CwChatManager.h"
#import "AnlieNewDetilViewModel.h"
#import "AnlieNewDetilModel.h"
#import "MingxiNewViewController.h"
#import "LookMingxiNewViewController.h"
#import "GetFangAnViewController.h"
@interface AnlieNewDetilViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) AnlieNewDetilViewModel *viewModel;
@property (strong,nonatomic) ShareNewmodel *sharemodel;
@property (nonatomic, strong) UIView *messageContainer;
@property (nonatomic, weak) UIView *phoneContainer;
@property (nonatomic, weak) UIView *careContainer;
@property (nonatomic, weak) UIView *appointmentContainer;
@property (nonatomic, weak) UIStackView *bottomActionStackView;
@property (nonatomic, strong) NSLayoutConstraint *actionStackWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *appointmentWidthConstraint;
@end

@implementation AnlieNewDetilViewController

- (IBAction)gouwuche:(UIButton *)sender {
    
    if (sender.tag == 0) {
        [self.table setContentOffset:CGPointMake(0,0) animated:YES];
    }else {
        SHopcarTwoViewController *orderSub = [[SHopcarTwoViewController alloc] init];
        orderSub.titleColorSelected = MAINCOLOR;
        orderSub.menuViewStyle = WMMenuViewStyleLine;
        orderSub.automaticallyCalculatesItemWidths = YES;
        orderSub.progressWidth = 40;
        orderSub.progressViewIsNaughty = YES;
        orderSub.scrollEnable = NO;
        orderSub.index = 0;
        orderSub.showOnNavigationBar = NO;
        orderSub.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:orderSub];
        
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"案例详情";
    [self rebuildBottomBarLayoutIfNeeded];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
    [self addPopBackBtn];
    [self addRightBtnWithTitle:nil image:@"分享的副本"];
    [self shareData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateMessageEntryVisibility];
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
    NSDictionary *dic = @{@"id":@(self.anlieID)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxianganli"]
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

- (void)fuzhidata{
    
}

- (BOOL)shouldShowMessageEntry {
    return APP_MESSAGE_ENTRY_ENABLED;
}

- (UIView *)bottomActionItemWithImageNamed:(NSString *)imageName buttonTag:(NSInteger)buttonTag {
    UIView *containerView = [[UIView alloc] init];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    containerView.backgroundColor = UIColor.whiteColor;

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.tag = 9000 + buttonTag;
    [containerView addSubview:imageView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.tag = buttonTag;
    [button addTarget:self action:@selector(allaction:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:button];

    [NSLayoutConstraint activateConstraints:@[
        [imageView.centerXAnchor constraintEqualToAnchor:containerView.centerXAnchor],
        [imageView.centerYAnchor constraintEqualToAnchor:containerView.centerYAnchor],
        [button.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [button.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [button.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [button.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor]
    ]];
    return containerView;
}

- (void)rebuildBottomBarLayoutIfNeeded {
    UIButton *appointmentButton = [self.view viewWithTag:12];
    UIView *bottomBar = appointmentButton.superview.superview;
    if (!bottomBar || self.bottomActionStackView) {
        return;
    }

    for (UIView *subview in [bottomBar.subviews copy]) {
        [subview removeFromSuperview];
    }

    UIStackView *actionStackView = [[UIStackView alloc] init];
    actionStackView.translatesAutoresizingMaskIntoConstraints = NO;
    actionStackView.axis = UILayoutConstraintAxisHorizontal;
    actionStackView.distribution = UIStackViewDistributionFillEqually;
    actionStackView.alignment = UIStackViewAlignmentFill;
    [bottomBar addSubview:actionStackView];
    self.bottomActionStackView = actionStackView;

    UIView *messageContainer = [self bottomActionItemWithImageNamed:@"私信" buttonTag:109];
    UIView *phoneContainer = [self bottomActionItemWithImageNamed:@"电话的副本" buttonTag:110];
    UIView *careContainer = [self bottomActionItemWithImageNamed:@"关注" buttonTag:111];
    [actionStackView addArrangedSubview:messageContainer];
    [actionStackView addArrangedSubview:phoneContainer];
    [actionStackView addArrangedSubview:careContainer];
    self.messageContainer = messageContainer;
    self.phoneContainer = phoneContainer;
    self.careContainer = careContainer;
    self.isGuanzhuImage = [careContainer viewWithTag:9111];

    UIView *appointmentContainer = [[UIView alloc] init];
    appointmentContainer.translatesAutoresizingMaskIntoConstraints = NO;
    appointmentContainer.backgroundColor = UIColor.whiteColor;
    [bottomBar addSubview:appointmentContainer];
    self.appointmentContainer = appointmentContainer;

    UIButton *newAppointmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newAppointmentButton.translatesAutoresizingMaskIntoConstraints = NO;
    newAppointmentButton.tag = 12;
    newAppointmentButton.backgroundColor = RGBA(255, 83, 132, 1);
    [newAppointmentButton setTitle:@"免费获取方案" forState:UIControlStateNormal];
    [newAppointmentButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    newAppointmentButton.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    [newAppointmentButton addTarget:self action:@selector(allaction:) forControlEvents:UIControlEventTouchUpInside];
    [appointmentContainer addSubview:newAppointmentButton];

    self.actionStackWidthConstraint = [actionStackView.widthAnchor constraintEqualToAnchor:bottomBar.widthAnchor multiplier:(2.0 / 5.0)];
    self.appointmentWidthConstraint = [appointmentContainer.widthAnchor constraintEqualToAnchor:bottomBar.widthAnchor multiplier:(3.0 / 5.0)];

    [NSLayoutConstraint activateConstraints:@[
        [actionStackView.leadingAnchor constraintEqualToAnchor:bottomBar.leadingAnchor],
        [actionStackView.topAnchor constraintEqualToAnchor:bottomBar.topAnchor],
        [actionStackView.bottomAnchor constraintEqualToAnchor:bottomBar.bottomAnchor],
        self.actionStackWidthConstraint,

        [appointmentContainer.leadingAnchor constraintEqualToAnchor:actionStackView.trailingAnchor],
        [appointmentContainer.topAnchor constraintEqualToAnchor:bottomBar.topAnchor],
        [appointmentContainer.trailingAnchor constraintEqualToAnchor:bottomBar.trailingAnchor],
        [appointmentContainer.bottomAnchor constraintEqualToAnchor:bottomBar.bottomAnchor],
        self.appointmentWidthConstraint,

        [newAppointmentButton.leadingAnchor constraintEqualToAnchor:appointmentContainer.leadingAnchor],
        [newAppointmentButton.trailingAnchor constraintEqualToAnchor:appointmentContainer.trailingAnchor],
        [newAppointmentButton.topAnchor constraintEqualToAnchor:appointmentContainer.topAnchor],
        [newAppointmentButton.bottomAnchor constraintEqualToAnchor:appointmentContainer.bottomAnchor]
    ]];

    [self updateMessageEntryVisibility];
}

- (void)updateMessageEntryVisibility {
    if (!self.messageContainer || !self.bottomActionStackView) {
        return;
    }
    BOOL showMessageEntry = [self shouldShowMessageEntry];
    UIButton *messageButton = [self.messageContainer viewWithTag:109];
    messageButton.hidden = !showMessageEntry;
    messageButton.userInteractionEnabled = showMessageEntry;
    BOOL containsMessageContainer = [self.bottomActionStackView.arrangedSubviews containsObject:self.messageContainer];
    if (showMessageEntry && !containsMessageContainer) {
        [self.bottomActionStackView insertArrangedSubview:self.messageContainer atIndex:0];
    } else if (!showMessageEntry && containsMessageContainer) {
        [self.bottomActionStackView removeArrangedSubview:self.messageContainer];
        [self.messageContainer removeFromSuperview];
    }
    [self.bottomActionStackView layoutIfNeeded];
}
- (IBAction)popac:(UIButton *)sender {
    [self popViewConDelay];
}


#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Gdanli *x) {
        @strongify(self);
        AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
        vc.anlieID = x.id;
        [self pushToNextVCWithNextVC:vc];
    }];
    //明细
    [self.viewModel.lookmingxiUISubject subscribeNext:^(AnlieNewDetilModel *x) {
        @strongify(self);
        
        if (![UserDataNew UserLoginState]) {
            NewLoginViewController *vc = [[NewLoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
        LookMingxiNewViewController *mingxi = [[LookMingxiNewViewController alloc] init];
        mingxi.id = self.viewModel.model.info.userid;
        [self pushToNextVCWithNextVC:mingxi];
    }];
    //商家
    [self.viewModel.lookshangjiaUISubject subscribeNext:^(AnlieNewDetilModel *x) {
        @strongify(self);
        NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
        vc.shopid = self.viewModel.model.user.userid;
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
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {

    [self.table registerNib:[UINib nibWithNibName:@"AnlieNewDetilTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnlieNewDetilTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    __weak typeof(self)weakSelf = self;
    self.viewModel.reload = ^ {
        [weakSelf.table reloadData];
    };
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@(self.anlieID) forKey:@"id"];
        if ([UserDataNew sharedManager].userInfoModel.token.token) {
            
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [self.viewModel.refreshDataCommand execute:dic];
        }else {
            [self.viewModel.refreshDataCommand execute:dic];
        }

    }];
    
    //请求结束
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
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (AnlieNewDetilViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AnlieNewDetilViewModel alloc] init];
    }
    return _viewModel;
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
        
        [CwChatManager pushP2PSessionWithIMUserId:[NSString stringWithFormat:@"%ld", (long)self.viewModel.model.user.userid] fromViewController:self];
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
        
        if (self.viewModel.model.userf) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.info.id] forKey:@"id"];
            [self.viewModel.deleguanzhuCommand execute:dic];
        }else {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:[NSString stringWithFormat:@"%ld",self.viewModel.model.info.id] forKey:@"id"];
            [self.viewModel.addguanzhuCommand execute:dic];
        }
        
    }else {//预约
        GetFangAnViewController *vc = [[GetFangAnViewController alloc] init];
        [self pushToNextVCWithNextVC:vc];
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

@end
