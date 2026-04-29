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
#import "CwChatManager.h"
#import "ShangjiaNewHeaderView.h"
@interface NewShangjiaViewController ()

@property (weak, nonatomic) UITableView *table;
@property (strong,nonatomic) NewShangjiaViewModel *viewModel;
@property (strong, nonatomic) NSLayoutConstraint *height;
@property (strong, nonatomic) NSLayoutConstraint *tableTopConstraint;

@property(nonatomic,assign)NSInteger curPageBaojia;
@property(nonatomic,assign)NSInteger curPageZuopin;
@property(nonatomic,assign)NSInteger curPageDongtai;
@property(nonatomic,assign)NSInteger curPagePinglun;

@property (nonatomic,retain) NSMutableArray *photosArray;

@property (nonatomic, strong) NSArray *imageArray;

@property (strong,nonatomic) ShareNewmodel *sharemodel;
@property (nonatomic, weak) UIView *floatingBarView;
@property (nonatomic, strong) UIView *floatingBarBackgroundView;
@property (nonatomic, strong) UILabel *floatingTitleLabel;
@property (nonatomic, weak) UIButton *floatingBackButton;
@property (nonatomic, weak) UIButton *floatingShareButton;
@property (nonatomic, strong) UIView *messageContainer;
@property (nonatomic, weak) UIView *phoneContainer;
@property (nonatomic, weak) UIView *careContainer;
@property (nonatomic, weak) UIView *appointmentContainer;
@property (nonatomic, weak) UIStackView *bottomActionStackView;
@property (nonatomic, strong) NSLayoutConstraint *actionStackWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *appointmentWidthConstraint;
@property (nonatomic, strong) UIView *stickyTabContainerView;
@property (nonatomic, strong) ShangjiaNewHeaderView *stickyTabHeaderView;
@end

@implementation NewShangjiaViewController

static const CGFloat kNewShangjiaStickyHeaderHeight = 50.0f;

- (void)loadView {
    UIView *rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    rootView.backgroundColor = RGBA(240, 240, 242, 1);
    self.view = rootView;
    [self buildNativeViewHierarchy];
}

- (BOOL)shouldShowMessageEntry {
    return NO;
}

- (void)buildNativeViewHierarchy {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = RGBA(240, 240, 242, 1);
    [self.view addSubview:tableView];
    self.table = tableView;

    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    bottomBar.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bottomBar];

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

    UIButton *appointmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    appointmentButton.translatesAutoresizingMaskIntoConstraints = NO;
    appointmentButton.tag = 12;
    appointmentButton.backgroundColor = RGBA(255, 83, 132, 1);
    [appointmentButton setTitle:@"预约商家" forState:UIControlStateNormal];
    [appointmentButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    appointmentButton.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    [appointmentButton addTarget:self action:@selector(allaction:) forControlEvents:UIControlEventTouchUpInside];
    [appointmentContainer addSubview:appointmentButton];

    UIView *floatingBar = [[UIView alloc] init];
    floatingBar.translatesAutoresizingMaskIntoConstraints = NO;
    floatingBar.tag = 8080;
    floatingBar.backgroundColor = UIColor.clearColor;
    [self.view addSubview:floatingBar];
    self.floatingBarView = floatingBar;

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.translatesAutoresizingMaskIntoConstraints = NO;
    backButton.tag = 0;
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setImage:[[UIImage imageNamed:@"返回(red)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [floatingBar addSubview:backButton];
    self.floatingBackButton = backButton;

    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    shareButton.tag = 1;
    shareButton.adjustsImageWhenHighlighted = NO;
    [shareButton setImage:[[UIImage imageNamed:@"分享的副本"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [floatingBar addSubview:shareButton];
    self.floatingShareButton = shareButton;
    
    UIView *stickyTabContainer = [[UIView alloc] init];
    stickyTabContainer.translatesAutoresizingMaskIntoConstraints = NO;
    stickyTabContainer.backgroundColor = UIColor.whiteColor;
    stickyTabContainer.hidden = YES;
    [self.view addSubview:stickyTabContainer];
    self.stickyTabContainerView = stickyTabContainer;

    self.height = [floatingBar.heightAnchor constraintEqualToConstant:64.0];
    self.tableTopConstraint = [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0.0];
    NSLayoutConstraint *bottomBarHeightConstraint = [bottomBar.heightAnchor constraintEqualToConstant:50.0];
    self.actionStackWidthConstraint = [actionStackView.widthAnchor constraintEqualToAnchor:bottomBar.widthAnchor multiplier:(2.0 / 5.0)];
    self.appointmentWidthConstraint = [appointmentContainer.widthAnchor constraintEqualToAnchor:bottomBar.widthAnchor multiplier:(3.0 / 5.0)];

    [NSLayoutConstraint activateConstraints:@[
        self.tableTopConstraint,
        [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [tableView.bottomAnchor constraintEqualToAnchor:bottomBar.topAnchor],

        [bottomBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [bottomBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [bottomBar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        bottomBarHeightConstraint,

        [actionStackView.leadingAnchor constraintEqualToAnchor:bottomBar.leadingAnchor],
        [actionStackView.topAnchor constraintEqualToAnchor:bottomBar.topAnchor],
        [actionStackView.bottomAnchor constraintEqualToAnchor:bottomBar.bottomAnchor],
        self.actionStackWidthConstraint,

        [appointmentContainer.leadingAnchor constraintEqualToAnchor:actionStackView.trailingAnchor],
        [appointmentContainer.topAnchor constraintEqualToAnchor:bottomBar.topAnchor],
        [appointmentContainer.trailingAnchor constraintEqualToAnchor:bottomBar.trailingAnchor],
        [appointmentContainer.bottomAnchor constraintEqualToAnchor:bottomBar.bottomAnchor],
        self.appointmentWidthConstraint,

        [appointmentButton.leadingAnchor constraintEqualToAnchor:appointmentContainer.leadingAnchor],
        [appointmentButton.trailingAnchor constraintEqualToAnchor:appointmentContainer.trailingAnchor],
        [appointmentButton.topAnchor constraintEqualToAnchor:appointmentContainer.topAnchor],
        [appointmentButton.bottomAnchor constraintEqualToAnchor:appointmentContainer.bottomAnchor],

        [floatingBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [floatingBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [floatingBar.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        self.height,

        [backButton.leadingAnchor constraintEqualToAnchor:floatingBar.leadingAnchor],
        [backButton.bottomAnchor constraintEqualToAnchor:floatingBar.bottomAnchor],
        [backButton.widthAnchor constraintEqualToConstant:44.0],
        [backButton.heightAnchor constraintEqualToConstant:44.0],

        [shareButton.trailingAnchor constraintEqualToAnchor:floatingBar.trailingAnchor],
        [shareButton.centerYAnchor constraintEqualToAnchor:backButton.centerYAnchor],
        [shareButton.widthAnchor constraintEqualToConstant:44.0],
        [shareButton.heightAnchor constraintEqualToConstant:44.0],

        [stickyTabContainer.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [stickyTabContainer.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [stickyTabContainer.topAnchor constraintEqualToAnchor:floatingBar.bottomAnchor],
        [stickyTabContainer.heightAnchor constraintEqualToConstant:kNewShangjiaStickyHeaderHeight]
    ]];

    [self setupStickyTabHeaderIfNeeded];
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

- (CGFloat)currentNavigationHeight {
    if (@available(iOS 11.0, *)) {
        CGFloat safeTop = self.view.safeAreaInsets.top;
        if (safeTop > 0.0) {
            return safeTop + 44.0;
        }
    }
    ZL_Navigation_Height(navigationHeight);
    return navigationHeight;
}

- (void)updateTopLayoutHeightsIfNeeded {
    CGFloat navigationHeight = [self currentNavigationHeight];
    if (ABS(self.height.constant - navigationHeight) > 0.5) {
        self.height.constant = navigationHeight;
    }
    if (ABS(self.tableTopConstraint.constant) > 0.5) {
        self.tableTopConstraint.constant = 0.0;
    }
}

- (void)updateMessageEntryVisibility {
    if (!self.messageContainer || !self.bottomActionStackView) {
        return;
    }
    BOOL showMessageEntry = APP_MESSAGE_ENTRY_ENABLED && [self shouldShowMessageEntry];
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
    [self updateBottomActionLayout];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateTopLayoutHeightsIfNeeded];
    [self clearNavigationButtonBackgrounds];
    [self updateMessageEntryVisibility];
    [self updateStickyTabHeaderSelection];
    [self updateStickyTabHeaderVisibility];
}

- (void)setupStickyTabHeaderIfNeeded {
    if (self.stickyTabHeaderView || !self.stickyTabContainerView) {
        return;
    }

    ShangjiaNewHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"ShangjiaNewHeaderView" owner:nil options:nil].firstObject;
    if (!headerView) {
        return;
    }

    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    headerView.markType = self.viewModel.markType;
    [self.stickyTabContainerView addSubview:headerView];
    [NSLayoutConstraint activateConstraints:@[
        [headerView.leadingAnchor constraintEqualToAnchor:self.stickyTabContainerView.leadingAnchor],
        [headerView.trailingAnchor constraintEqualToAnchor:self.stickyTabContainerView.trailingAnchor],
        [headerView.topAnchor constraintEqualToAnchor:self.stickyTabContainerView.topAnchor],
        [headerView.bottomAnchor constraintEqualToAnchor:self.stickyTabContainerView.bottomAnchor]
    ]];

    @weakify(self);
    [headerView.gotoNextVc subscribeNext:^(NSNumber *x) {
        @strongify(self);
        [self handleTabSelectionAtIndex:x.integerValue];
    }];
    self.stickyTabHeaderView = headerView;
}

- (void)handleTabSelectionAtIndex:(NSInteger)index {
    if (index < 0 || index > 6) {
        return;
    }
    self.viewModel.markType = index;
    [self updateStickyTabHeaderSelection];
    [self.viewModel.refreshUITypeSubject sendNext:@(index)];
}

- (void)updateStickyTabHeaderSelection {
    self.stickyTabHeaderView.markType = self.viewModel.markType;
}

- (void)updateStickyTabHeaderVisibility {
    if (!self.table || !self.stickyTabContainerView) {
        return;
    }

    CGRect sectionRect = [self.table rectForSection:1];
    if (CGRectIsEmpty(sectionRect) || CGRectIsInfinite(sectionRect)) {
        self.stickyTabContainerView.hidden = YES;
        return;
    }

    CGRect sectionRectInView = [self.table convertRect:sectionRect toView:self.view];
    CGFloat stickyTop = CGRectGetMaxY(self.floatingBarView.frame);
    self.stickyTabContainerView.hidden = CGRectGetMinY(sectionRectInView) > stickyTop;
}

- (void)setupNavigationButtons {
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                target:nil
                                                                                action:nil];
    leftSpace.width = -10;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 24, 24);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setBackgroundImage:nil forState:UIControlStateNormal];
    [backButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    backButton.contentEdgeInsets = UIEdgeInsetsZero;
    backButton.imageEdgeInsets = UIEdgeInsetsZero;
    backButton.layer.cornerRadius = 0.0;
    backButton.layer.masksToBounds = NO;
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setImage:[[UIImage imageNamed:@"返回(red)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popViewConDelay) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItems = @[leftSpace, [self navigationBarButtonItemWithCustomView:backButton]];
    
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                 target:nil
                                                                                 action:nil];
    rightSpace.width = -10;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 24, 24);
    shareButton.backgroundColor = [UIColor clearColor];
    [shareButton setBackgroundImage:nil forState:UIControlStateNormal];
    [shareButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    shareButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    shareButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    shareButton.contentEdgeInsets = UIEdgeInsetsZero;
    shareButton.imageEdgeInsets = UIEdgeInsetsZero;
    shareButton.layer.cornerRadius = 0.0;
    shareButton.layer.masksToBounds = NO;
    shareButton.adjustsImageWhenHighlighted = NO;
    [shareButton setImage:[[UIImage imageNamed:@"分享的副本"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                 forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(respondsToRightBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[rightSpace, [self navigationBarButtonItemWithCustomView:shareButton]];
}

- (UIBarButtonItem *)navigationBarButtonItemWithCustomView:(UIView *)customView {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    if (@available(iOS 26.0, *)) {
        item.hidesSharedBackground = YES;
        item.sharesBackground = NO;
    }
    return item;
}

- (void)clearNavigationButtonBackgrounds {
    [self clearNavigationButtonBackgroundForItem:self.navigationItem.leftBarButtonItem];
    [self clearNavigationButtonBackgroundForItem:self.navigationItem.rightBarButtonItem];
}

- (void)clearNavigationButtonBackgroundForItem:(UIBarButtonItem *)item {
    UIView *view = item.customView;
    NSInteger depth = 0;
    while (view && depth < 4) {
        view.backgroundColor = UIColor.clearColor;
        view.layer.cornerRadius = 0.0;
        view.layer.masksToBounds = NO;
        if ([view isKindOfClass:[UIControl class]]) {
            UIControl *control = (UIControl *)view;
            control.selected = NO;
            control.highlighted = NO;
        }
        view = view.superview;
        depth++;
    }
}



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
    self.view.backgroundColor = RGBA(240, 240, 242, 1);
    self.navigationItem.title = @"商家详情";
    [self setupNavigationButtons];
    [self configureFloatingBar];
    [self updateMessageEntryVisibility];
    
    [self setupTableView];
    [self cellClick];
    [self requestDataForCurrentMarkType];
    [self updateTopLayoutHeightsIfNeeded];
    [self shareData];
	
	@weakify(self);
    [self.viewModel.hiddenNavSubject subscribeNext:^(NSNumber *x) {
        @strongify(self);
        [self updateFloatingBarAlpha:[x floatValue]];
        [self updateStickyTabHeaderVisibility];
	}];
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self updateMessageEntryVisibility];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)configureFloatingBar {
    UIView *floatingBar = self.floatingBarView ?: [self.view viewWithTag:8080];
    if (!floatingBar) {
        return;
    }
    self.floatingBarView = floatingBar;
    floatingBar.hidden = NO;
    floatingBar.backgroundColor = UIColor.clearColor;
    floatingBar.clipsToBounds = YES;

    if (!self.floatingBarBackgroundView) {
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        backgroundView.backgroundColor = UIColor.whiteColor;
        backgroundView.alpha = 0.0;
        [floatingBar insertSubview:backgroundView atIndex:0];
        [NSLayoutConstraint activateConstraints:@[
            [backgroundView.leadingAnchor constraintEqualToAnchor:floatingBar.leadingAnchor],
            [backgroundView.trailingAnchor constraintEqualToAnchor:floatingBar.trailingAnchor],
            [backgroundView.topAnchor constraintEqualToAnchor:floatingBar.topAnchor],
            [backgroundView.bottomAnchor constraintEqualToAnchor:floatingBar.bottomAnchor]
        ]];
        self.floatingBarBackgroundView = backgroundView;
    }

    [self updateFloatingBarButtonImagesForProgress:0.0];
    if (!self.floatingTitleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.text = @"商家详情";
        titleLabel.textColor = RGBA(38, 38, 38, 1);
        titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        titleLabel.alpha = 0.0;
        [floatingBar addSubview:titleLabel];
        [NSLayoutConstraint activateConstraints:@[
            [titleLabel.centerXAnchor constraintEqualToAnchor:floatingBar.centerXAnchor],
            [titleLabel.bottomAnchor constraintEqualToAnchor:floatingBar.bottomAnchor constant:-12.0]
        ]];
        self.floatingTitleLabel = titleLabel;
    }
}

- (void)updateFloatingBarAlpha:(CGFloat)offsetY {
    CGFloat progress = MIN(MAX(offsetY / 140.0, 0.0), 1.0);
    self.floatingBarBackgroundView.alpha = progress;
    self.floatingTitleLabel.alpha = progress;
    [self updateFloatingBarButtonImagesForProgress:progress];
}

- (void)updateFloatingBarButtonImagesForProgress:(CGFloat)progress {
    UIImage *backImage = [[UIImage imageNamed:@"返回(red)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *shareImage = [[UIImage imageNamed:@"分享的副本"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.floatingBackButton setImage:backImage forState:UIControlStateNormal];
    [self.floatingShareButton setImage:shareImage forState:UIControlStateNormal];
}

- (void)updateBottomActionLayout {
    if (!self.messageContainer) {
        return;
    }
    [self.bottomActionStackView layoutIfNeeded];
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

- (void)requestDongtaiListForCurrentShop {
    _curPageDongtai = 1;

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.shopid) forKey:@"id"];
    [dic setValue:@(_curPageDongtai) forKey:@"p"];
    [dic setValue:@"10" forKey:@"rows"];

    [self.viewModel.refreDongtaiListDataCommand execute:dic];
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
        [self respondsToRightBtn];
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
            [self requestDongtaiListForCurrentShop];
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
        if (index < 0 || index >= self.viewModel.dataArrayDongtai.count) {
            return;
        }
        Dongtaiarray *model = self.viewModel.dataArrayDongtai[index];
        NSArray *photos = [model.photourl isKindOfClass:[NSArray class]] ? model.photourl : @[];
        for (id item in photos) {
            NSString *urlString = nil;
            if ([item isKindOfClass:[Photourldongtai class]]) {
                urlString = ((Photourldongtai *)item).photourl;
            } else if ([item isKindOfClass:[NSDictionary class]]) {
                id url = item[@"photourl"] ?: item[@"url"] ?: item[@"src"];
                urlString = [url isKindOfClass:[NSString class]] ? url : nil;
            } else if ([item isKindOfClass:[NSString class]]) {
                urlString = item;
            }
            if (urlString.length > 0) {
                [array addObject:urlString];
            }
        }
        if (array.count == 0) {
            return;
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
        [self handleTabSelectionAtIndex:1];
    }];
    //更多作品
    [self.viewModel.morezuopinSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self handleTabSelectionAtIndex:2];
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
        dongtai.hidesBottomBarWhenPushed = YES;
        
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
- (void)requestDataForCurrentMarkType {
    [self updateStickyTabHeaderSelection];
    if (self.viewModel.markType == 0) {
        _curPagePinglun = 1;
        
        if ([UserDataNew UserLoginState]) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
            [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
            [dic setValue:@(self.shopid) forKey:@"id"];
            [self.viewModel.refreshDataCommand execute:dic];
        } else {
            [self.viewModel.refreshDataCommand execute:@{@"id":@(self.shopid)}];
        }
        [self.viewModel.refrepinglunDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPagePinglun)}];
    } else if (self.viewModel.markType == 1) {
        _curPageBaojia = 1;
        [self.viewModel.refreshBaojiaListDataCommand execute:@{@"rows":@"100",@"id":@(self.shopid),@"p":@(_curPageBaojia)}];
    } else if (self.viewModel.markType == 2) {
        _curPageZuopin = 1;
        [self.viewModel.refreZuopinListDataCommand execute:@{@"rows":@"100",@"id":@(self.shopid),@"p":@(_curPageZuopin)}];
    } else if (self.viewModel.markType == 3) {
        _curPagePinglun = 1;
        [self.viewModel.refrepinglunDataCommand execute:@{@"id":@(self.shopid),@"p":@(_curPagePinglun)}];
    } else if (self.viewModel.markType == 4) {
        [self requestDongtaiListForCurrentShop];
    } else if (self.viewModel.markType == 5) {
        [self.viewModel.refredangqiListDataCommand execute:@{@"id":@(self.shopid),@"p":@(1),@"rows":@"1000"}];
    } else {
        [self.viewModel.refreziliaoDataCommand execute:@{@"userid":@(self.shopid)}];
    }
}

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
    self.table.backgroundColor      = RGBA(240, 240, 242, 1);
    self.table.tableFooterView      = [UIView new];
    self.table.estimatedRowHeight = 0.0;
    self.table.estimatedSectionHeaderHeight = 0.0;
    self.table.estimatedSectionFooterHeight = 0.0;
    if (@available(iOS 11.0, *)) {
        self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (@available(iOS 15.0, *)) {
        self.table.sectionHeaderTopPadding = 0.0;
    }
    
    
    @weakify(self);
    
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
