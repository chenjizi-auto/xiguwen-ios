//
//  ZLElectronicInvitationHomeStaticPage.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationHomeStaticPage.h"

@interface ZLElectronicInvitationHomeStaticPage ()

///图片
@property (nonatomic,weak) UIButton *iconButton;

@end

@implementation ZLElectronicInvitationHomeStaticPage

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self iconButton];
    }
    return self;
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        CGFloat size = 200.0;
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - size) * 0.5, 100.0, size, size)];
        iconButton.userInteractionEnabled = NO;
        iconButton.contentMode = UIViewContentModeScaleAspectFit;
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"未创建请柬.png"];
        [iconButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}

@end
