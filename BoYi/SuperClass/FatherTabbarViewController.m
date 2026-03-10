//
//  FatherTabbarViewController.m
//  Base
//
//  Created by Chen on 2016/11/29.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "FatherTabbarViewController.h"
#import "BaseNavigationViewController.h"

@interface FatherTabbarViewController () <UITabBarControllerDelegate>

@end

@implementation FatherTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadViewController];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Ensure tab bar sticks to the bottom and spans full width.
    CGRect frame = self.tabBar.frame;
    frame.origin.x = 0.0;
    frame.size.width = self.view.bounds.size.width;
    frame.origin.y = self.view.bounds.size.height - frame.size.height;
    self.tabBar.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  标签栏控制器
 */

- (void)loadViewController {
    
//    self.view.backgroundColor          = [UIColor blackColor];
    
    NSArray *arr       = [NSArray arrayWithObjects:@"首页",@"案例-(1)hui",@"爱心",@"消息",@"联系人", nil];
    NSArray *arrSelect = [NSArray arrayWithObjects:@"首页_red",@"案例-(1)",@"爱心red",@"消息red",@"联系人red", nil];
    NSArray *nameArray = @[@"首页",@"案例",@"喜帖",@"消息",@"我的"];
    NSArray *vcArray = @[@"IndexViewController",@"FindViewController",@"WeddingCardViewController",@"MessageViewController",@"MineViewController"];
    
    NSMutableArray *NavArr = [[NSMutableArray alloc] initWithCapacity:vcArray.count];
    
    for (int i = 0; i < vcArray.count; i++) {
        id vc = [[NSClassFromString(vcArray[i]) alloc] init];
        
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:nameArray[i]
                                                      image:[[UIImage imageNamed:arr[i]]
                                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[[UIImage imageNamed:arrSelect[i]]
                                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [NavArr addObject:nav];
    }
    self.delegate = self;
    self.viewControllers = NavArr;
    //设定Tabbar的点击后的颜色
    
    [[UITabBar appearance] setTintColor:MAINCOLOR];
    
    //设定Tabbar的颜色
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    self.hidesBottomBarWhenPushed = YES;
    
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    for (int i = 0; i < self.viewControllers.count; i++) {
//        if ([viewController isEqual:self.viewControllers[i]]) {
//            if (i == 4 && !TOKEN) {
//                LoginViewController *vc = [[LoginViewController alloc] init];
//                [self presentViewController:[[BaseNavigationViewController alloc] initWithRootViewController:vc] animated:YES completion:^{
//                    
//                }];
//                return NO;
//            }
//            
//        }
        if ([viewController isEqual:self.viewControllers[i]] && i != self.selectedIndex) {
            UIView *view = self.tabBar.subviews[i + 1];
            [UIView transitionWithView:view duration:0.35 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                
            } completion:^(BOOL finished) {
                
            }];
            break;
        }
    }
    
    return YES;
}
@end
