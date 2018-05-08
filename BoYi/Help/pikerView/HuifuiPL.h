//
//  HuifuiPL.h
//  BoYi
//
//  Created by heng on 2018/3/1.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UItextViewWithPlaceHloder.h"
@interface HuifuiPL : UIView
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (copy,nonatomic) void(^ block)(NSString *date);
@property (assign,nonatomic) NSInteger id;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *text;

+ (HuifuiPL *)showInView:(UIView *)view setid:(NSInteger)setid block:(void(^)(NSString *date))block;
@end
