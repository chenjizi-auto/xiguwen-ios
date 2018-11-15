//
//  MessageSubViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MessageSubViewController.h"
#import "NTESSessionListViewController.h"
#import "JiaoyiViewController.h"
#import "TongzhiViewController.h"
#import "YouhuiViewController.h"
#import "SessionSubHeaderView.h"

@interface MessageSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic,strong)    UILabel *titleLabel;
@property (nonatomic, strong) SessionSubHeaderView *header;
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
    [self showTop];
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

- (void)showTop {
    
//    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
//    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
//    CGFloat height = isIPhoneX ? 82 : 64;
    
    _header = [SessionSubHeaderView showInView:self.view];
    WeakSelf(self);
    _header.block = ^(NSInteger tag) {
        weakSelf.selectIndex = tag;
    };
    
}



//- (void)viewDidLayoutSubviews {
////    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
//    CGFloat height = isIPhoneX ? 82 : 64;
//    _header.frame = CGRectMake(0, height, self.view.frame.size.width, 60);
//}

- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"聊天",
                        @"交易消息",
                        @"通知消息",
                        @"优惠"];
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
    
    NTESSessionListViewController *vc = [[NTESSessionListViewController alloc] init];
    JiaoyiViewController *vc1 = [[JiaoyiViewController alloc] init];
    TongzhiViewController *vc2 = [[TongzhiViewController alloc] init];
    YouhuiViewController *vc3 = [[YouhuiViewController alloc] init];

    if (index == 0) {
        return vc;
    }else if (index == 1) {
        return vc1;
    }else if (index == 2) {
        return vc2;
    }else {
        return vc3;
    }
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
//    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
//    CGFloat height = isIPhoneX ? 82 : 64;
    return CGRectMake(leftMargin, UIApplication.sharedApplication.statusBarFrame.size.height + 44.0, self.view.frame.size.width, 80);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY - 49);
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    NSArray *arr = @[ [NTESSessionListViewController class],
                      [JiaoyiViewController class],
                      [TongzhiViewController class],
                      [YouhuiViewController class]];
    NSInteger index = 0;
    
    for (int i = 0; i < arr.count; i++) {
        if ([viewController isKindOfClass:arr[i]]) {
            index = i;
            break;
        }
    }
//    [_header selectBtn:(UIButton *)[_header viewWithTag:100 + index]];
}

@end
