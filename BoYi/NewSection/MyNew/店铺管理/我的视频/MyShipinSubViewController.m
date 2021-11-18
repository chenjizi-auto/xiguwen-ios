//
//  MyShipinSubViewController.m
//  BoYi
//
//  Created by heng on 2018/1/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyShipinSubViewController.h"
#import "MyShipinViewController.h"
#import "AddShiPinViewController.h"

@interface MyShipinSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@end

@implementation MyShipinSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的视频";
    [self addPopBackBtn];
    self.titleColorSelected = MAINCOLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addRightBtnWithTitle:nil image:@"添加银行卡"];
    ZL_Navigation_Height(navigationHeight);
	UIView *lineView = [[UIView alloc] init];
	[lineView setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
	[self.view addSubview:lineView];
	lineView.sd_layout
	.topSpaceToView(self.view, 44+navigationHeight)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(1.0f);
}

- (void)addRightBtnWithTitle:(NSString *)title image:(NSString *)image {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0,10);
    [backBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    backBtn.backgroundColor = [UIColor clearColor];
    if (image) {
        [backBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (title) {
        [backBtn setTitle:title forState:UIControlStateNormal];
    }
    [backBtn addTarget:self action:@selector(respondsToRightBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItems = @[placeBarButton,bar];
}
- (void)respondsToRightBtn {
    AddShiPinViewController *add = [[AddShiPinViewController alloc] init];
	add.isEdit = NO;
    [self.navigationController pushViewController:add animated:YES];
    
}
- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0,10);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
}
- (void)popViewConDelay
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}


- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"审核中",
                        @"审核通过",
                        @"审核未通过"];
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
    
    
    MyShipinViewController *BaoJia = [[MyShipinViewController alloc] init];
	BaoJia.index = index + 1;
    return BaoJia;
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    ZL_Navigation_Height(navigationHeight);
    CGFloat height = navigationHeight;
    return CGRectMake(leftMargin, height, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
