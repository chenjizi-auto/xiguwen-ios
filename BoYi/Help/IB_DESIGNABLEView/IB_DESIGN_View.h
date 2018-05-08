//
//  IB_DESIGN_View.h
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IB_DESIGN_View : UIView
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat bwidth;
@property (nonatomic, assign)IBInspectable UIColor *bcolor;
@property (nonatomic, assign)IBInspectable UIColor *ShodowColor;
@property (nonatomic, assign)IBInspectable CGFloat shodowWidth;
@property (nonatomic, assign)IBInspectable CGFloat shodowOpacity;
@property (nonatomic, assign)IBInspectable CGSize shodowSize;

@end
