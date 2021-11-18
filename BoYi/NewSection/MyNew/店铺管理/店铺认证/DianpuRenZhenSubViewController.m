//
//  DianpuRenZhenSubViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "DianpuRenZhenSubViewController.h"
#import "PingtaiViewController.h"
#import "ChenxinRenzhenViewController.h"
#import "XueyuanRenzhenViewController.h"

@interface DianpuRenZhenSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;

@end

@implementation DianpuRenZhenSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺认证";
    [self addPopBackBtn];
    self.titleColorSelected = MAINCOLOR;
    self.view.backgroundColor = [UIColor whiteColor];
	
	UIView *lineView = [[UIView alloc] init];
	[lineView setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
	[self.view addSubview:lineView];
    
    
    ZL_Navigation_Height(navigationHeight);
	lineView.sd_layout
	.topSpaceToView(self.view, 50+navigationHeight)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(1.0f);
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}


- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0,10);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
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
        _titleNames = @[@"平台认证",
                        @"诚信认证",
                        @"学院认证"];
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
    
    PingtaiViewController *Pingtai = [[PingtaiViewController alloc] init];
    ChenxinRenzhenViewController *Chenxin = [[ChenxinRenzhenViewController alloc] init];
    XueyuanRenzhenViewController *Xueyuan = [[XueyuanRenzhenViewController alloc] init];
    
    if (index == 0) {
        return Pingtai;
    }else if (index == 1) {
        return Chenxin;
    }else {
        return Xueyuan;
    } 
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    ZL_Navigation_Height(navigationHeight);
    return CGRectMake(leftMargin, navigationHeight, self.view.frame.size.width, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
