//
//  OrderEvaluateView.h
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UItextViewWithPlaceHloder.h"
#import <HCSStarRatingView.h>

typedef void(^SelectSureBlock)(NSString *content,NSInteger index);

@interface OrderEvaluateView : UIView
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *starValue;

@property (copy, nonatomic) SelectSureBlock block;

@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *textView;
+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectSureBlock)block;
@end
