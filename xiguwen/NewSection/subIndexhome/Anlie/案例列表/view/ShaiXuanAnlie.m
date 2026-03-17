//
//  ShaiXuanAnlie.m
//  BoYi
//
//  Created by heng on 2018/1/28.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShaiXuanAnlie.h"


@implementation ShaiXuanAnlie
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 35)];
    toolbar.tintColor = MAINCOLOR;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}
- (void)textFieldDone{
    [self endEditing:YES];
}
+ (ShaiXuanAnlie *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block{
    ShaiXuanAnlie *alert = [[[NSBundle mainBundle]loadNibNamed:@"ShaiXuanAnlie" owner:self options:nil]lastObject];
    alert.dicData = [[NSMutableDictionary alloc] init];
    //侧栏手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:alert action:@selector(hiddenView)];
    alert.tagView.userInteractionEnabled=YES;
    tap.delegate = alert;
    [alert.tagView addGestureRecognizer:tap];

    alert.zuidi.delegate = alert;
    alert.zuigao.delegate = alert;
    alert.zuidi.inputAccessoryView = [alert addToolbar];
    alert.zuigao.inputAccessoryView = [alert addToolbar];
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    return alert;
}
//确定
- (IBAction)sureAC:(UIButton *)sender {
    if (self.zuidi.text.length != 0 && self.zuigao.text.length != 0) {
        if ([self.zuidi.text integerValue] > [self.zuigao.text integerValue]) {
            [NavigateManager showMessage:@"最低价不能大于最高价"];
            return;
        }
    }
    
    [self.dicData setObject:self.zuidi.text forKey:@"zuidiAL"];
    [self.dicData setObject:self.zuigao.text forKey:@"zuigaoAL"];
    if (self.block) {
        
        self.block(self.dicData);
    }
    [self hiddenView];
}
- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
    //    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.alpha = 1;
        //        weakSelf.bgView.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}

- (void)hiddenView{
    
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        
        //        weakSelf.alpha = 0.01;
        //        weakSelf.bgView.alpha = 0.01;
        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self endEditing:YES];
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
    }
    return YES;
    
}
@end
