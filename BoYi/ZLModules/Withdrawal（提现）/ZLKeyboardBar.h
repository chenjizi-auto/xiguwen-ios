//
//  ZLKeyboardBar.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/7/11.
//  Copyright © 2018年   . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLKeyboardBar : UIView

///文字
@property (nonatomic,strong) NSString *title;

///实例
+ (instancetype)shared;
///展示在哪个视图上
- (void)showInView:(UIView *)view;

@end
