//
//  AppUpdate.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppUpdate : UIView
@property (copy,nonatomic) void(^ block)(NSDictionary *dic);
+ (AppUpdate *)showInView:(UIView *)view content:(NSString *)content block:(void(^)(NSDictionary *dic))block;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UITextView *cotent;
@end
