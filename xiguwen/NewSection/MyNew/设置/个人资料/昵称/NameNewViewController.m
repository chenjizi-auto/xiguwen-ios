//
//  NameNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NameNewViewController.h"

@interface NameNewViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation NameNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置昵称";
    if (self.placeHolder) {
        self.textField.placeholder = self.placeHolder;
        self.navigationItem.title = self.placeHolder;
    }
    if (self.textValue) {
        self.textField.text = self.textValue;
    }
    [self addPopBackBtn];
    self.textField.delegate = self;
    self.textField.inputAccessoryView = [self addToolbar];
}
- (void)popViewConDelay
{
    if (self.block && self.textField.text.length > 0) {
        self.block(self.textField.text);
    }
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
