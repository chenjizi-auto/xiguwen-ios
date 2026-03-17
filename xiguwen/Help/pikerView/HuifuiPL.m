//
//  HuifuiPL.m
//  BoYi
//
//  Created by heng on 2018/3/1.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HuifuiPL.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface HuifuiPL ()

@property (assign, nonatomic) BOOL iqWasEnabled;
@property (assign, nonatomic) BOOL iqWasAutoToolbarEnabled;

@end

@implementation HuifuiPL

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.sendButton) {
        [self.sendButton removeTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
        [self.sendButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    }
}

+ (HuifuiPL *)showInView:(UIView *)view setid:(NSInteger)setid block:(void(^)(NSString *date))block{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    HuifuiPL *alert = [[[NSBundle mainBundle]loadNibNamed:@"HuifuiPL" owner:self options:nil]lastObject];
    alert.iqWasEnabled = keyboardManager.enable;
    alert.iqWasAutoToolbarEnabled = keyboardManager.enableAutoToolbar;
    keyboardManager.enable = NO;
    keyboardManager.enableAutoToolbar = NO;
    alert.frame = view.bounds;
    alert.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    alert.text.placeholder = @"写评论/回复…";
    alert.text.inputAccessoryView = [[UIView alloc] initWithFrame:CGRectZero];
    if (@available(iOS 9.0, *)) {
        alert.text.inputAssistantItem.leadingBarButtonGroups = @[];
        alert.text.inputAssistantItem.trailingBarButtonGroups = @[];
    }
    alert.block = block;
    alert.id = setid;
    [alert startKeyboardObserver];
    [alert showOnView:view];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert.text becomeFirstResponder];
    });
    return alert;
}
- (IBAction)cancle:(id)sender {
    [self hidden];
}
- (IBAction)sure:(id)sender {
    NSLog(@"HuifuiPL send tapped, id=%ld, text=%@", (long)self.id, self.text.text);
    if (self.text.markedTextRange) {
        [self.text unmarkText];
    }
    NSString *content = [self.text.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (content.length == 0) {
        [NavigateManager showMessage:@"请输入评论内容"];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [dic setValue:@(self.id) forKey:@"id"];
    [dic setValue:content forKey:@"comm"];
    
    [[RequestManager sharedManager] requestUrl:URL_New_dongtaipinglun
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               if (self.block) {
                                                   self.block(content);
                                               }
                                               [NavigateManager showMessage:@"评论成功"];
                                               
                                           }else{
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                           [self hidden];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"评论失败，请重试"];
                                           [self hidden];
                                       }];
    
    
}

- (void)showOnView:(UIView *)view {
    [view addSubview:self];
    [self layoutIfNeeded];
    self.alpha = 0.0;
    self.bgview.alpha = 0.0;
    self.bgview.transform = CGAffineTransformMakeTranslation(0, 24.0);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         weakSelf.alpha = 1.0;
                         weakSelf.bgview.alpha = 1.0;
                         weakSelf.bgview.transform = CGAffineTransformIdentity;
                     } completion:nil];
}

- (void)startKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboard:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)handleKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = ([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16);
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect endFrameInView = [self convertRect:endFrame fromView:nil];
    CGFloat overlap = MAX(0.0, CGRectGetMaxY(self.bounds) - CGRectGetMinY(endFrameInView));
    CGFloat safeAreaBottomInset = 0.0;
    if (@available(iOS 11.0, *)) {
        safeAreaBottomInset = self.safeAreaInsets.bottom;
    }
    CGFloat bottomOffset = MAX(overlap - safeAreaBottomInset, 0.0);
    [UIView animateWithDuration:duration delay:0 options:options | UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (self.bgBottomConstraint) {
            self.bgBottomConstraint.constant = bottomOffset;
            [self layoutIfNeeded];
        } else {
            self.bgview.transform = CGAffineTransformMakeTranslation(0, -bottomOffset);
        }
    } completion:nil];
}

- (void) hidden{
    [self.text resignFirstResponder];
    if (self.bgBottomConstraint) {
        self.bgBottomConstraint.constant = 0.0;
    }
    self.bgview.transform = CGAffineTransformIdentity;
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = self.iqWasEnabled;
    keyboardManager.enableAutoToolbar = self.iqWasAutoToolbarEnabled;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        [weakSelf layoutIfNeeded];
        weakSelf.alpha = 0.0;
        weakSelf.bgview.alpha = 0.0;
        weakSelf.bgview.transform = CGAffineTransformMakeTranslation(0, 18.0);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
