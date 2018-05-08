//
//  YJCardView.m
//  YSLDraggableCardContainerDemo
//
//  Created by junzong on 16/8/23.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

#import "YJCardView.h"

@implementation YJCardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (void)setupCardView {
    
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 0.4f;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.layer.cornerRadius = 7.0;
}

@end
