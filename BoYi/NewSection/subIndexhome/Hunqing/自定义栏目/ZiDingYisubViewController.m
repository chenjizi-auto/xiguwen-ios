//
//  ZiDingYisubViewController.m
//  BoYi
//
//  Created by heng on 2018/2/5.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZiDingYisubViewController.h"
#import "ZiDingYingLanMuViewController.h"
@interface ZiDingYisubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@end

@implementation ZiDingYisubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIColor *color = [UIColor whiteColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:color   forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    NSMutableArray *arr = [NSMutableArray array];
    arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"zidingyilianmu"];
    
    
    if (self.selectIndex == 0) {
        self.navigationItem.title = arr[0];
    }
    if (self.selectIndex == 1) {
        self.navigationItem.title = arr[1];
    }
    if (self.selectIndex == 2) {
        self.navigationItem.title = arr[2];
    }
    
    [self addPopBackBtn];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = RGBA(253, 71, 90, 1);
    self.titleColorSelected = [UIColor whiteColor];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 82;
    }
}
- (IBAction)popac:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        
        NSMutableArray *arr = [NSMutableArray array];
        arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"zidingyilianmu"];
        _titleNames = arr;
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
    
    ZiDingYingLanMuViewController *zidingyi = [[ZiDingYingLanMuViewController alloc] init];
    if (index == 0) {
        zidingyi.statusFlag = self.guanggaoID1;
    }else if (index == 1) {
        zidingyi.statusFlag = self.guanggaoID2;
    }else {
        zidingyi.statusFlag = self.guanggaoID3;
    }
    
//    @weakify(self);
//    [hunqin.seleUISubject subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        self.selectIndex = 4;
//    }];
    return zidingyi;
    
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    ZL_Discern_Bang_Device(isBangDevice);
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat height = isBangDevice ? 84 : 64;
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
