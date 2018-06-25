//
//  ZLElectronicInvitationSelectMusicStaticCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationSelectMusicStaticCell.h"

@interface ZLElectronicInvitationSelectMusicStaticCell ()

///图片
@property (nonatomic,weak) UIButton *iconButton;
///标题
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation ZLElectronicInvitationSelectMusicStaticCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self titleLabel];
    }
    return self;
}

#pragma mark - Lazy
- (UIButton *)iconButton {
    if (!_iconButton) {
        CGFloat size = 200.0;
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - size) * 0.5, 100.0, size, size)];
        iconButton.userInteractionEnabled = NO;
        iconButton.contentMode = UIViewContentModeScaleAspectFit;
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"没有请柬模板.png"];
        [iconButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.iconButton.frame), CGRectGetMaxY(self.iconButton.frame) - 10.0, CGRectGetWidth(self.iconButton.frame), 20.0)];
        titleLabel.text = @"暂时没有相关音乐";
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

@end
