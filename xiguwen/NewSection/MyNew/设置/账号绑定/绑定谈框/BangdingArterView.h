//
//  BangdingArterView.h
//  BoYi
//
//  Created by heng on 2018/1/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BangdingArterView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *message;

+ (BangdingArterView *)showInView:(UIView *)view title:(NSString *)title message:(NSString *)message;

@property (copy,nonatomic) void(^ block)(void);
@end
