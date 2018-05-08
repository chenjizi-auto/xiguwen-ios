//
//  deledetView.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface deledetView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (copy,nonatomic) void(^ block)(NSMutableDictionary *dic);

+ (deledetView *)showInView:(UIView *)view block:(void(^)(NSMutableDictionary *dic))block;
@end
