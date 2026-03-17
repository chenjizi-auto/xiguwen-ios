//
//  ShangchengSubViewController.m
//  BoYi
//
//  Created by heng on 2018/2/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengSubViewController.h"
#import "shangchengNewlistViewController.h"
@interface ShangchengSubViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titelw;
@property (nonatomic, strong) NSArray *titleNames;
@end

@implementation ShangchengSubViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *titw = @"";
    if (self.statusFlag == 0) {
        titw = @"有好货";
        self.selectIndex = 0;
    }else if (self.statusFlag == 1) {
        titw = @"必买清单";
        self.selectIndex = 1;
    }else if (self.statusFlag == 2) {
        titw = @"爱逛街";
        self.selectIndex = 2;
    }else if (self.statusFlag == 3) {
        titw = @"限时抢购";
        self.selectIndex = 3;
    }else if (self.statusFlag == 4) {
        titw = @"抢爆款";
        self.selectIndex = 4;
    }else {
        titw = @"男士专区";
        self.selectIndex = 5;
    }
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = RGBA(253, 71, 90, 1);
    self.titleColorSelected = [UIColor whiteColor];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 82;
    }
    self.titelw.text = titw;
}
- (IBAction)pop:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"有好货",
                        @"必买清单",
                        @"爱逛街",
                        @"限时抢购",
                        @"抢爆款",
                        @"男士专区"];
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
    
    shangchengNewlistViewController *vc = [[shangchengNewlistViewController alloc] init];
    NSLog(@"%@",self.arrayid);
    vc.statusFlag = [self.arrayid[index] integerValue];
    NSString *titw = @"";
    if (index == 0) {
        titw = @"有好货";
    }else if (index == 1) {
        titw = @"必买清单";
    }else if (index == 2) {
        titw = @"爱逛街";
    }else if (index == 3) {
        titw = @"限时抢购";
    }else if (index == 4) {
        titw = @"抢爆款";
    }else {
        titw = @"男士专区";
    }
    self.titelw.text = titw;
    return vc;
    
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
