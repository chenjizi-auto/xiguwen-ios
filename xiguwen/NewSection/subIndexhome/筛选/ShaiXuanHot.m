//
//  ShaiXuanHot.m
//  BoYi
//
//  Created by heng on 2017/12/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShaiXuanHot.h"

@implementation ShaiXuanHot
-(void)awakeFromNib{
    [super awakeFromNib];

}
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
+ (ShaiXuanHot *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block{
    ShaiXuanHot *alert = [[[NSBundle mainBundle]loadNibNamed:@"ShaiXuanHot" owner:self options:nil]lastObject];
    alert.dicData = [[NSMutableDictionary alloc] init];
    //侧栏手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:alert action:@selector(hiddenView)];
    alert.tagView.userInteractionEnabled=YES;
    tap.delegate = alert;
    [alert.tagView addGestureRecognizer:tap];
    
    alert.zuidi.delegate =  alert;
    alert.zuigao.delegate =  alert;
    alert.zuidi.inputAccessoryView = [alert addToolbar];
    alert.zuigao.inputAccessoryView = [alert addToolbar];
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    return alert;
}

- (IBAction)action:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 0) {
        if (sender.selected == YES) {
            [self.btn1 setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            self.btn1.backgroundColor = RGBA(255, 239, 243, 1);
            self.i1.hidden = NO;
            [self.dicData setObject:@"yes" forKey:@"chengxin"];
        }else {
            [self.btn1 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn1.backgroundColor = RGBA(240, 240, 240, 1);
            self.i1.hidden = YES;
            [self.dicData setObject:@"no" forKey:@"zizhi"];
        }
    }else if (sender.tag == 1) {
        if (sender.selected == YES) {
            [self.btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.btn2.backgroundColor = RGBA(255, 239, 243, 1);
            self.i2.hidden = NO;
            [self.dicData setObject:@"yes" forKey:@"pingtai"];
        }else {
            [self.btn2 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn2.backgroundColor = RGBA(240, 240, 240, 1);
            self.i2.hidden = YES;
            [self.dicData setObject:@"no" forKey:@"pingtai"];
        }
    }else {
        if (sender.selected == YES) {
            [self.btn3 setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            self.btn3.backgroundColor = RGBA(255, 239, 243, 1);
            self.i3.hidden = NO;
            [self.dicData setObject:@"yes" forKey:@"xueyuan"];
        }else {
            [self.btn3 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn3.backgroundColor = RGBA(240, 240, 240, 1);
            self.i3.hidden = YES;
            [self.dicData setObject:@"no" forKey:@"xueyuan"];
        }
    }
    
}
- (IBAction)typeAC:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 10) {
        
        if (sender.selected == YES) {
            [self.btn11 setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            self.btn11.backgroundColor = RGBA(255, 239, 243, 1);
            self.i11.hidden = NO;
            
            
            [self.btn12 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn12.backgroundColor = RGBA(240, 240, 240, 1);
            self.i12.hidden = YES;
            [self.dicData setObject:@"1" forKey:@"isgeren"];
        }else {
            [self.btn11 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn11.backgroundColor = RGBA(240, 240, 240, 1);
            self.i11.hidden = YES;

            [self.btn12 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn12.backgroundColor = RGBA(240, 240, 240, 1);
            self.i12.hidden = YES;
            
            [self.dicData setObject:@"0" forKey:@"isgeren"];
        }
        

    }else {
        if (sender.selected == YES) {
            
            [self.btn11 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn11.backgroundColor = RGBA(240, 240, 240, 1);
            self.i11.hidden = YES;
            
            
            [self.btn12 setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            self.btn12.backgroundColor = RGBA(255, 239, 243, 1);
            self.i12.hidden = NO;
            [self.dicData setObject:@"2" forKey:@"isgeren"];
        }else {
            [self.btn11 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn11.backgroundColor = RGBA(240, 240, 240, 1);
            self.i11.hidden = YES;
            
            [self.btn12 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn12.backgroundColor = RGBA(240, 240, 240, 1);
            self.i12.hidden = YES;
            
            [self.dicData setObject:@"0" forKey:@"isgeren"];
        }
    }
    
}
- (IBAction)isHuiyuan:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 100) {
        
        if (sender.selected == YES) {
            [self.btn111 setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            self.btn111.backgroundColor = RGBA(255, 239, 243, 1);
            self.i111.hidden = NO;
            
            [self.btn112 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn112.backgroundColor = RGBA(240, 240, 240, 1);
            self.i112.hidden = YES;
            [self.dicData setObject:@"1" forKey:@"ishuiyuan"];
        }else {
            [self.btn111 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn111.backgroundColor = RGBA(240, 240, 240, 1);
            self.i111.hidden = YES;
            [self.btn112 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn112.backgroundColor = RGBA(240, 240, 240, 1);
            self.i112.hidden = YES;
            [self.dicData setObject:@"0" forKey:@"ishuiyuan"];
        }
        
        
    }else {
        if (sender.selected == YES) {
            [self.btn112 setTitleColor:RGBA(252, 88, 135, 1) forState:UIControlStateNormal];
            self.btn112.backgroundColor = RGBA(255, 239, 243, 1);
            self.i112.hidden = NO;
            [self.btn111 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn111.backgroundColor = RGBA(240, 240, 240, 1);
            self.i111.hidden = YES;
            [self.dicData setObject:@"2" forKey:@"ishuiyuan"];
        }else {
            [self.btn111 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn111.backgroundColor = RGBA(240, 240, 240, 1);
            self.i111.hidden = YES;
            [self.btn112 setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
            self.btn112.backgroundColor = RGBA(240, 240, 240, 1);
            self.i112.hidden = YES;
            [self.dicData setObject:@"0" forKey:@"ishuiyuan"];
        }
        
        
        
    }
   
}
//确定
- (IBAction)sureAC:(UIButton *)sender {
    if (self.zuidi.text.length != 0 && self.zuigao.text.length != 0) {
        if ([self.zuidi.text integerValue] > [self.zuigao.text integerValue]) {
            [NavigateManager showMessage:@"最低价不能大于最高价"];
            return;
        }
    }
    [self.dicData setObject:self.zuidi.text forKey:@"zuidi"];
    [self.dicData setObject:self.zuigao.text forKey:@"zuigao"];
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
