//
//  ApayOrYL.h
//  BoYi
//
//  Created by apple on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApayOrYL : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (copy,nonatomic) void(^ block)(NSDictionary *dic);

@property (strong,nonatomic) NSString *type;

+ (ApayOrYL *)showInView:(UIView *)view  block:(void(^)(NSDictionary *dic))block;

@end
