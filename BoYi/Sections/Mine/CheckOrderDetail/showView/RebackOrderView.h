//
//  RebackOrderView.h
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UItextViewWithPlaceHloder.h"

typedef void(^SelectBlock)(NSString *string);

@interface RebackOrderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (copy, nonatomic) SelectBlock block;

@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *textView;
+ (void)showInView:(UIView *)view top:(NSString *)topContent bottom:(NSString *)bottomContent block:(SelectBlock)block;
@end
