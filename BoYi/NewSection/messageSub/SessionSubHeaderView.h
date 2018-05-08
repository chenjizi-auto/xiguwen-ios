//
//  SessionSubHeaderView.h
//  BoYi
//
//  Created by 陈伟 on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionSubHeaderView : UIView

@property (copy,nonatomic) void(^ block)(NSInteger tag);
- (IBAction)selectBtn:(UIButton *)sender;
+ (SessionSubHeaderView *)showInView:(UIView *)view;
@end
