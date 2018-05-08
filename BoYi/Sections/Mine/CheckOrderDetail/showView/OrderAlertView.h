//
//  OrderAlertView.h
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBtnBlock)(NSInteger index);

@interface OrderAlertView : UIView


@property (weak, nonatomic) IBOutlet UILabel *content;

@property (copy, nonatomic) SelectBtnBlock block;

+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectBtnBlock)block;
//- (IBAction)LeftBtnAction:(UIButton *)sender;

@end
