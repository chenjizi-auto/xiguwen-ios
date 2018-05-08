//
//  IB_DESIGN_Button.h
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Canvas.h"

@interface IB_DESIGN_Button : UIButton
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat bwidth;
@property (nonatomic, assign)IBInspectable UIColor *bcolor;
@property (nonatomic, assign)IBInspectable CGFloat delay;
@property (nonatomic, assign)IBInspectable CGFloat duration;
@property (nonatomic, copy)IBInspectable NSString *type;

@end
