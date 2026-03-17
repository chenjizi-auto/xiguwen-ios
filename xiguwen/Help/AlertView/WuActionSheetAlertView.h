//
//  WuActionSheetAlertView.h
//  ZeroRead_OC
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBtnBlock)(NSInteger index);


@interface WuActionSheetAlertView : UIView

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *messageLable;
//@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (copy, nonatomic) SelectBtnBlock block;


- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent right:(NSString *)rightContent;
+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectBtnBlock)block;
//- (IBAction)LeftBtnAction:(UIButton *)sender;
- (IBAction)RightBtnAction:(UIButton *)sender;



@end
