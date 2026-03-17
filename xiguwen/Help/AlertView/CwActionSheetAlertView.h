//
//  CwActionSheetAlertView.h
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/5/13.
//  Copyright © 2017年 fuyou. All rights reserved.
//
typedef void(^SelectBtnBlock)(NSInteger index);
#import <UIKit/UIKit.h>

@interface CwActionSheetAlertView : UIView
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *messageLable;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (copy, nonatomic) SelectBtnBlock block;

    
- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent right:(NSString *)rightContent;
+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectBtnBlock)block;
- (IBAction)LeftBtnAction:(UIButton *)sender;
- (IBAction)RightBtnAction:(UIButton *)sender;


@end
