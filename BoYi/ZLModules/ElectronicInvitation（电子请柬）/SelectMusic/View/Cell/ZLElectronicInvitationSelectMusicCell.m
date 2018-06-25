//
//  ZLElectronicInvitationSelectMusicCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationSelectMusicCell.h"

@interface ZLElectronicInvitationSelectMusicCell ()

///图片
@property (nonatomic,weak) UIImageView *iconImageView;

@end

@implementation ZLElectronicInvitationSelectMusicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self iconImageView];
    }
    return self;
}

#pragma mark - Lazy
- (UIButton *)titleButton {
    if (!_titleButton) {
        UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 80.0, 50.0)];
        titleButton.userInteractionEnabled = NO;
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [titleButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateSelected];
        [self.contentView addSubview:titleButton];
        _titleButton = titleButton;
    }
    return _titleButton;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 65.0, 0, 50.0, 50.0)];
        [self.contentView addSubview:iconImageView];
        _iconImageView = iconImageView;
    }
    return _iconImageView;
}

#pragma mark - Set
- (void)setDidSelected:(BOOL)didSelected {
    _didSelected = didSelected;
    self.titleButton.selected = didSelected;
    self.iconImageView.hidden = !didSelected;
    if (!self.iconImageView.hidden) {
        NSMutableArray *arrayM = [NSMutableArray new];
        for (NSInteger index = 0; index < 9; index++) {
            NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.png",index + 1]];
            [arrayM addObject:[UIImage imageWithContentsOfFile:path]];
        }
        self.iconImageView.animationImages = arrayM;
        self.iconImageView.animationDuration = 0.3;
        [self.iconImageView startAnimating];
    }else {
        [self.iconImageView.layer removeAllAnimations];
    }
}

@end
