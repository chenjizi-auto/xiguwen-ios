//
//  CHadangsubViewController.m
//  BoYi
//
//  Created by heng on 2018/2/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CHadangsubViewController.h"
#import "ChaDangViewController.h"
#import "CDdatepicker.h"
@interface CHadangsubViewController ()
@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic, strong) NSArray *titleID;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *timeBTN;
@end

@implementation CHadangsubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.titleColorSelected = MAINCOLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 82;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"chadangtimeDay"];
    [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"chadangtimeshangxiawu"];
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (IBAction)pop:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sousuoac:(IB_DESIGN_Button *)sender {
    __weak typeof(self) weakSelf = self;
    CDdatepicker *piker = [CDdatepicker showInView:weakSelf.view issele:NO block:^(NSMutableDictionary *dic) {
        NSString *date = dic[@"date"];
        NSString *time = dic[@"time"];
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"chadangtimeDay"];
        NSString *timewu = @"5";
        if ([time isEqualToString:@"上午"]) {
            timewu = @"1";
        }if ([time isEqualToString:@"中午"]){
            timewu = @"2";
        }if ([time isEqualToString:@"下午"]){
            timewu = @"3";
        }if ([time isEqualToString:@"晚上"]){
            timewu = @"4";
        }
        [[NSUserDefaults standardUserDefaults] setObject:timewu forKey:@"chadangtimeshangxiawu"];
        
        [self.timeBTN setTitle:[NSString stringWithFormat:@"%@ %@",date,time] forState:UIControlStateNormal];
    }];
}

- (NSArray *)titleNames {
    if (_titleNames == nil) {
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"zhiweiname"]) {
            NSMutableArray *zhiweiname = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhiweiname"];
            NSMutableArray *zhiweiid = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhiweiid"];
            _titleNames = zhiweiname;
            _titleID = zhiweiid;
        }
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
    
    ChaDangViewController *Anlie = [[ChaDangViewController alloc] init];
    Anlie.id = [self.titleID[index] integerValue];
    return Anlie;
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
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY - 48);
}

@end
