//
//  BingkeSub.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "BingkeSub.h"
#import "BingkeHuifuViewController.h"
#import "IsfuyanViewController.h"
@interface BingkeSub ()
@property (nonatomic, strong) NSArray *titleNames;
@end

@implementation BingkeSub

- (void)viewDidLoad {
    [super viewDidLoad];    
    if (self.type == 0) {
        self.selectIndex = 0;
    }else {
        self.selectIndex = 1;
    }
    if (isIPhoneX) {
        self.height.constant = 82;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (IBAction)popav:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"宾客祝福",
                        @"是否赴宴"];
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
    BingkeHuifuViewController *vc = [[BingkeHuifuViewController alloc] init];
    IsfuyanViewController *is = [[IsfuyanViewController alloc] init];
    if (index == 0) {
        return vc;
    }else {
        return is;
    }
    
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat height = isIPhoneX ? 82 : 64;
    return CGRectMake(leftMargin, height, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
