//
//  MessageSubViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MessageSubViewController.h"
#import "CwChatManager.h"

@interface MessageSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic,strong)    UILabel *titleLabel;
@end

@implementation MessageSubViewController
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTitleView];
}
- (void)setUpTitleView
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    self.titleLabel.text = @"消息";
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    
    UIView *titleView = [[UIView alloc] init];
    [titleView addSubview:self.titleLabel];
    
    self.navigationItem.titleView = titleView;
    
    [self layoutTitleView];
    
}

- (void)layoutTitleView
{
    CGFloat maxLabelWidth = 150.f;
    [self.titleLabel sizeToFit];
    self.titleLabel.width = maxLabelWidth;
    
    
    UIView *titleView = self.navigationItem.titleView;
    
    titleView.width  = self.titleLabel.width;
    titleView.height = self.titleLabel.height;

}

- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"聊天"];
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
    return [CwChatManager sessionListViewController];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGFloat)menuTopInset {
    if (self.showOnNavigationBar) {
        return 0.0;
    }
    if (@available(iOS 11.0, *)) {
        CGFloat safeAreaTop = self.view.safeAreaInsets.top;
        if (safeAreaTop > 0.0) {
            return safeAreaTop;
        }
    }
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (navigationBar && !navigationBar.hidden && navigationBar.superview) {
        CGRect navFrame = [self.view convertRect:navigationBar.frame fromView:navigationBar.superview];
        if (CGRectGetMaxY(navFrame) > 0.0) {
            return CGRectGetMaxY(navFrame);
        }
    }
    CGFloat statusBarHeight = 20.0;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = self.view.window.windowScene;
        if (windowScene.statusBarManager.statusBarFrame.size.height > 0.0) {
            statusBarHeight = windowScene.statusBarManager.statusBarFrame.size.height;
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
#pragma clang diagnostic pop
    }
    return statusBarHeight + 44.0;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    if (self.titleNames.count == 1) {
        return CGRectZero;
    }
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = [self menuTopInset];
    return CGRectMake(leftMargin, originY, CGRectGetWidth(self.view.bounds), 44.0);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = [self menuTopInset];
    if (self.titleNames.count > 1) {
        originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    }
    if (self.titleNames.count > 1 && self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    CGFloat availableHeight = MAX(CGRectGetHeight(self.view.bounds) - originY, 0.0);
    return CGRectMake(0, originY, CGRectGetWidth(self.view.bounds), availableHeight);
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    
}

@end
