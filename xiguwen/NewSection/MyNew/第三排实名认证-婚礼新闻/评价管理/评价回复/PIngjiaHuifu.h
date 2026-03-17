//
//  PIngjiaHuifu.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIngjiaHuifu : UIView

@property (strong, nonatomic) NSMutableDictionary *dicData;
@property (copy,nonatomic) void(^ block)(NSMutableDictionary *dic);
+ (PIngjiaHuifu *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block;


@end
