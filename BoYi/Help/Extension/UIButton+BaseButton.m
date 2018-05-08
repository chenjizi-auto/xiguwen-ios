//
//  UIButton+BaseButton.m
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "UIButton+BaseButton.h"

@implementation UIButton (BaseButton)
+(UIButton*)buttonType:(CGRect)frame{
    UIButton * button = [[UIButton alloc]initWithFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.layer.cornerRadius = frame.size.height/2.0;
    button.layer.masksToBounds = YES;
    button.backgroundColor = RGBA(255, 244, 247, 1);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}
@end
