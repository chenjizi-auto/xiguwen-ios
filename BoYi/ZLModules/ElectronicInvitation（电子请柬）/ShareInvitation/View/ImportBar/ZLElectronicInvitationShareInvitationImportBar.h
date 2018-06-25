//
//  ZLElectronicInvitationShareInvitationImportBar.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationShareInvitationImportBar : UIView

///键盘的弹出事件
- (void)keyboardDidChangeFrame:(NSNotification *)notification;
///关闭键盘
- (void)shutDownKeyboard;

@end
