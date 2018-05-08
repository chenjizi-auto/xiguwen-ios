//
//  MJChiBaoZiFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJChiBaoZiFooter.h"

@implementation MJChiBaoZiFooter
#pragma mark - 重写方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.refreshingTitleHidden = YES;
        self.stateLabel.hidden = YES;
    }
    return self;
}

#pragma mark 基本设置
//- (void)prepare
//{
//    [super prepare];
//    
//    self.refreshingTitleHidden = YES;
//    
//    // 设置正在刷新状态的动画图片
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshUp%zd", i]];
//        if (!image) break;
//        [refreshingImages addObject:image];
//    }
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
//}

- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshLow%zd", i]];
        if (!image) break;
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshLow%zd", i]];
        if (!image) break;
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
@end
