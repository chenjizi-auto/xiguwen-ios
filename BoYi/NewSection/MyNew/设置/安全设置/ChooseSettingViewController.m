//
//  ChooseSettingViewController.m
//  BoYi
//
//  Created by Chen on 2018/4/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ChooseSettingViewController.h"
#import "ChangepassWordNewViewController.h"

@interface ChooseSettingViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation ChooseSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addPopBackBtn];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickBtn:(UIButton *)sender {
    
    ChangepassWordNewViewController *vc = [[ChangepassWordNewViewController alloc] init];
    vc.isPayPw = sender.tag == 101;
    [self pushToNextVCWithNextVC:vc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
