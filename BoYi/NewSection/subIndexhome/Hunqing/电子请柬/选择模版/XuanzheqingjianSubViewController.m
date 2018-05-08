//
//  XuanzheqingjianSubViewController.m
//  BoYi
//
//  Created by heng on 2017/12/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "XuanzheqingjianSubViewController.h"

@interface XuanzheqingjianSubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic, strong) NSArray *dataarray;
@end

@implementation XuanzheqingjianSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择模版";
    [self addPopBackBtn];
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
        self.dataarray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MobanType"];
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < self.dataarray.count; i ++) {
            [arr addObject:self.dataarray[i][@"title"]];
        }
       _titleNames = (NSArray *)arr;

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
    
    XuanzheMobanViewController *vc = [[XuanzheMobanViewController alloc] init];
    vc.statusFlag = [[NSString stringWithFormat:@"%@",self.dataarray[index][@"id"]] integerValue];
    return vc;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
