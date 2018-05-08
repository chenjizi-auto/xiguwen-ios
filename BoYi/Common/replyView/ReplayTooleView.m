
//
//  ReplayTooleView.m
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/5/8.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "ReplayTooleView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface ReplayTooleView() <UITextViewDelegate>


@end

@implementation ReplayTooleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [IQKeyboardManager sharedManager].enable = NO;
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
    
    
    
}





- (void)setup {
    
    self.textView.delegate = self;
    self.textView.placeholder = @"我也说一句...";
    [self keyBoard];
}

- (void)keyBoard {
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        
        //  Getting keyboard animation duration
        CGFloat duration = [[x userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
        //  Getting UIKeyboardSize.
        CGRect kbFrame = [[x userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        CGRect rect = self.frame;
        rect.origin.y = ScreenHeight - kbFrame.size.height - rect.size.height;
        
        [UIView animateWithDuration:duration animations:^{
            self.frame = rect;
        }];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        
        //  Getting keyboard animation duration
        CGFloat duration = [[x userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
        //  Getting UIKeyboardSize.
        //        CGRect kbFrame = [[x userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        CGRect rect = self.frame;
        rect.origin.y = ScreenHeight - rect.size.height;

        
        [UIView animateWithDuration:duration animations:^{
            self.frame = rect;
        }];
    }];
}






#pragma mark - uitextfield delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}








- (RACSubject *)HeightChangeSubject {
    if (!_HeightChangeSubject) {
        _HeightChangeSubject = [RACSubject subject];
    }
    return _HeightChangeSubject;
}
- (RACSubject *)sendSubject {
    if (!_sendSubject) {
        _sendSubject = [RACSubject subject];
    }
    return _sendSubject;
}





- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
