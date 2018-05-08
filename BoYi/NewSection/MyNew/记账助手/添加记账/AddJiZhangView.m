//
//  AddJiZhangView.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddJiZhangView.h"
#import "CwDatePiker.h"
@implementation AddJiZhangView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.chuBtn.selected = YES;
    self.markBtn = self.chuBtn;
	
	self.beizhu.inputAccessoryView = [self addToolbar];
}

+ (AddJiZhangView *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block{
    AddJiZhangView *alert = [[[NSBundle mainBundle]loadNibNamed:@"AddJiZhangView" owner:self options:nil]lastObject];
    alert.dicData = [[NSMutableDictionary alloc] init];
	
    //侧栏手势
    alert.frame = view.frame;
    alert.dicData = [[NSMutableDictionary alloc] init];
    [alert.dicData setObject:@(1) forKey:@"type"];
    
    alert.block = block;
    [alert showOnView:view];
    return alert;
    
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

- (IBAction)allACtion:(UIButton *)sender {
    
    NSInteger integer = sender.tag;
	
    if (integer >= 0 && integer <= 10) {//1 - 9 。
        if ([self.price.text isEqualToString:@"0"]) {
            if (integer == 10) {
                self.price.text = [NSString stringWithFormat:@"%@.",self.price.text ];
            }else {
                self.price.text = [NSString stringWithFormat:@"%ld",integer];
            }
        }else {
            if (integer == 10) {
                self.price.text = [NSString stringWithFormat:@"%@.",self.price.text ];
            }else {
                self.price.text = [NSString stringWithFormat:@"%@%ld",self.price.text,integer];
            }
            
        }
		
		if (self.price.text.length > 8.0) {
			[NavigateManager showMessage: @"输入达到上限"];
			self.price.text = [self.price.text substringToIndex:self.price.text.length - 1];
		}
    }else if (integer == 11) {//时间
        __weak typeof(self) weakSelf = self;
        [CwDatePiker showInView:weakSelf issele:NO block:^(NSDate *date) {
            
            
            NSString *dateString = [date fs_stringWithFormat:@"yy/MM/dd"];
            
            [weakSelf.timeBtn setTitle:dateString forState:UIControlStateNormal];
        }];
    }else if (integer == 12) {//删除一个
        if (self.price.text.length == 1) {
            self.price.text = @"0";
        }else if (self.price.text.length == 0) {
            
        }else {
            self.price.text = [self.price.text substringToIndex:self.price.text.length - 2];
        }
    }else if (integer == 13) {//完成
        if ([self.price.text isEqualToString:@"0"]) {
            [NavigateManager showMessage:@"请填写金额"];
            return;
        }
        if ([self.beizhu.text isEqualToString:@""]) {
            [NavigateManager showMessage:@"请填写备注"];
            return;
        }
		
		if (self.beizhu.text.length > 12) {
			[NavigateManager showMessage:@"请填写备注少于12个字"];
			return;
		}
		
        if ([self.timeBtn.titleLabel.text isEqualToString:@"今天"]) {
            self.time = [NSString getNowTimestamp];
        }else {
            self.time = [NSString timeSwitchTimestamp:self.timeBtn.titleLabel.text andFormatter:@"yy/MM/dd"];
        }
        [self.dicData setObject:self.beizhu.text forKey:@"remarks"];
        [self.dicData setObject:self.price.text forKey:@"aftermoney"];
        [self.dicData setObject:@(self.time) forKey:@"occurrence"];
        
        [self.dicData setObject:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [self.dicData setObject:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        
   
        [[RequestManager sharedManager] requestUrl:URL_New_addJIzhangzhushou
                                            method:POST
                                            loding:@""
                                               dic:self.dicData
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager showMessage:@"添加成功"];
//                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       if (self.block) {
                                                           
                                                           self.block(self.dicData);
                                                       }
                                                       [self hiddenView];
//                                                   });
													   
                                               }else{
                                                   
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                               [NavigateManager showMessage:@"添加失败"];
                                               
                                           }];
        
    }else {//取消
         [self hiddenView];
    }
}
- (IBAction)churu:(UIButton *)sender {
    self.markBtn.selected = NO;
    sender.selected = YES;
    self.markBtn = sender;
    if (sender.tag == 100) {//出
        [self.dicData setObject:@(1) forKey:@"type"];
    }else {//收
        [self.dicData setObject:@(2) forKey:@"type"];
    }
    
    
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

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//
//}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//	if (self.beizhu.text.length >= 12) {
//		self.beizhu.text = [self.beizhu.text substringToIndex:9];
//	}
//	return YES;
//}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self endEditing:YES];
}

@end
