//
//  FindNewSubViewController.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FindNewSubViewController.h"
#import "ShangchengQuanViewController.h"
#import "HunqinQuanViewController.h"
#import "WriteDongtaiViewController.h"
@interface FindNewSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic, strong) UIView *findHeaderView;
@property (nonatomic, strong) UILabel *findTitleLabel;
@property (nonatomic, strong) NSLayoutConstraint *findHeaderHeightConstraint;
@property (nonatomic, strong) UIButton *floatingDynamicButton;
@property (nonatomic, strong) UIView *findHeaderBottomLine;
@property (nonatomic, strong) UIView *findMenuBottomLine;
@end

@implementation FindNewSubViewController

- (CGFloat)currentTopSafeInset {
    CGFloat topInset = self.view.safeAreaInsets.top;
    if (topInset > 0.0) {
        return topInset;
    }
    CGFloat statusBarHeight = 0.0;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = self.view.window.windowScene ?: UIApplication.sharedApplication.connectedScenes.allObjects.firstObject;
        if (windowScene.statusBarManager.statusBarFrame.size.height > 0.0) {
            statusBarHeight = windowScene.statusBarManager.statusBarFrame.size.height;
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
#pragma clang diagnostic pop
    }
    if (statusBarHeight > 0.0) {
        return statusBarHeight;
    }
    ZL_Discern_Bang_Device(isBangDevice);
    return isBangDevice ? 44.0 : 20.0;
}

- (CGFloat)findHeaderHeight {
    return [self currentTopSafeInset] + 44.0;
}

- (void)updateFindHeaderLayout {
    self.findHeaderHeightConstraint.constant = [self findHeaderHeight];
    self.findHeaderBottomLine.frame = CGRectMake(0.0,
                                                 [self findHeaderHeight] - 1.0 / UIScreen.mainScreen.scale,
                                                 CGRectGetWidth(self.view.bounds),
                                                 1.0 / UIScreen.mainScreen.scale);
}

- (void)setupFindHeaderView {
    if (self.findHeaderView) {
        return;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.textColor = [UIColor colorWithRed:0.05 green:0.08 blue:0.16 alpha:1.0];
    titleLabel.text = @"婚庆圈子";
    [headerView addSubview:titleLabel];

    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLine.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
    [headerView addSubview:bottomLine];
    
    [self.view addSubview:headerView];
    self.findHeaderHeightConstraint = [headerView.heightAnchor constraintEqualToConstant:[self findHeaderHeight]];
    [NSLayoutConstraint activateConstraints:@[
        [headerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [headerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [headerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        self.findHeaderHeightConstraint,
        
        [titleLabel.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor constant:20.0],
        [titleLabel.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:-8.0]
    ]];
    
    self.findHeaderView = headerView;
    self.findTitleLabel = titleLabel;
    self.findHeaderBottomLine = bottomLine;
}

- (void)setupFloatingDynamicButton {
    if (self.floatingDynamicButton) {
        return;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.backgroundColor = UIColor.clearColor;
    button.adjustsImageWhenHighlighted = NO;
    [button setImage:[UIImage imageNamed:@"新增日程"] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.layer.shadowColor = [UIColor colorWithRed:0.90 green:0.26 blue:0.25 alpha:1.0].CGColor;
    button.layer.shadowOpacity = 0.18;
    button.layer.shadowOffset = CGSizeMake(0.0, 10.0);
    button.layer.shadowRadius = 18.0;
    [button addTarget:self action:@selector(handleFloatingDynamicButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UILayoutGuide *bottomGuide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [button.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16.0],
        [button.bottomAnchor constraintEqualToAnchor:bottomGuide.bottomAnchor constant:-20.0],
        [button.widthAnchor constraintEqualToConstant:56.0],
        [button.heightAnchor constraintEqualToConstant:56.0]
    ]];

    self.floatingDynamicButton = button;
}

- (void)handleFloatingDynamicButtonTapped {
    WriteDongtaiViewController *vc = [[WriteDongtaiViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)shouldHideMenuView {
    return self.titleNames.count <= 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
    [self setupFindHeaderView];
    [self setupFloatingDynamicButton];
    self.menuView.hidden = [self shouldHideMenuView];
    self.menuView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateFindHeaderLayout];
    [self updateFindMenuAppearance];
}


- (NSArray *)titleNames {
    if (_titleNames == nil) {
        NSMutableArray *titles = [NSMutableArray arrayWithObject:@"婚庆圈"];
        if (APP_MALL_FEATURES_ENABLED) {
            [titles addObject:@"商城圈"];
        }
        _titleNames = [titles copy];
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
    HunqinQuanViewController *hunqin = [[HunqinQuanViewController alloc] init];
    if (index == 0) {
        return hunqin;
    }else {
        ShangchengQuanViewController *shangcheng = [[ShangchengQuanViewController alloc] init];
        return shangcheng;
    }
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = [self findHeaderHeight];
    return CGRectMake(leftMargin, originY, self.view.frame.size.width, [self shouldHideMenuView] ? 0 : 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    CGFloat availableHeight = MAX(CGRectGetHeight(self.view.bounds) - originY, 0.0);
    return CGRectMake(0, originY, CGRectGetWidth(self.view.bounds), availableHeight);
}

- (void)updateFindMenuAppearance {
    if (self.menuView.hidden) {
        self.findMenuBottomLine.hidden = YES;
        return;
    }
    if (!self.findMenuBottomLine) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
        [self.menuView addSubview:line];
        self.findMenuBottomLine = line;
    }
    self.findMenuBottomLine.hidden = NO;
    self.findMenuBottomLine.frame = CGRectMake(0.0,
                                               CGRectGetHeight(self.menuView.bounds) - 1.0 / UIScreen.mainScreen.scale,
                                               CGRectGetWidth(self.menuView.bounds),
                                               1.0 / UIScreen.mainScreen.scale);
}


@end
