//
//  BaseNavigationViewController.m
//  ZeroRead_OC
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.navigationBar.barTintColor = TEXT_COLOR;
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置显示的颜色
    
//    bar.barTintColor = [UIColor colorWithRed:62/255.0 green:173/255.0 blue:176/255.0 alpha:1.0];
    
    //设置字体颜色
    
//    bar.tintColor = TEXT_COLOR;
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : TEXT_COLOR}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(id)initWithRootViewController:(UIViewController *)rootViewController {
//    BaseNavigationViewController* nvc = [super initWithRootViewController:rootViewController];
//    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
//    nvc.delegate = self;
//    return nvc;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
