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
@interface FindNewSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@end

@implementation FindNewSubViewController

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
}


- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"婚庆圈",
                        @"商城圈"];
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
    
    ShangchengQuanViewController *shangcheng = [[ShangchengQuanViewController alloc] init];
    HunqinQuanViewController *hunqin = [[HunqinQuanViewController alloc] init];
    if (index == 0) {
        return hunqin;
    }else {
        return shangcheng;
    }
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat height = isIPhoneX ? 52 : 34;
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
