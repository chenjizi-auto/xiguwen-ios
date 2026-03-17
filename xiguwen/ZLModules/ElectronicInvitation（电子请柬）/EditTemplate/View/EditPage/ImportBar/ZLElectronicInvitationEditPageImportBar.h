//
//  ZLElectronicInvitationEditPageImportBar.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLElectronicInvitationEditPageImportBarDelegate<NSObject>

///更改文字
- (void)saveTextWithCurrentTextView:(UITextView *)currentTextView LatestText:(NSString *)value;

@end

@interface ZLElectronicInvitationEditPageImportBar : UIView

///代理
@property (nonatomic,weak) id <ZLElectronicInvitationEditPageImportBarDelegate>delegate;

///键盘的弹出事件
- (void)keyboardDidChangeFrame:(NSNotification *)notification;
///关闭键盘
- (void)shutDownKeyboard;

@end
