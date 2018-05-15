//
//  ZLShopDetailsCommentCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsCommentCell.h"
#import "ZLShopDetailsCommentStarView.h"
#import "ZLShopDetailsCommentImagesView.h"
#import "ZLShopDetailsCommentReplyView.h"

@interface ZLShopDetailsCommentCell ()

///头像
@property (nonatomic,weak) UIButton *iconButton;
///姓名
@property (nonatomic,weak) UILabel *nameLabel;
///时间
@property (nonatomic,weak) UILabel *timeLabel;
///分数
@property (nonatomic,weak) ZLShopDetailsCommentStarView *scoreView;
///内容
@property (nonatomic,weak) UILabel *contentLabel;
///图片
@property (nonatomic,weak) ZLShopDetailsCommentImagesView *imagesView;
///回复
@property (nonatomic,weak) ZLShopDetailsCommentReplyView *replyView;
///分割线
@property (nonatomic,weak) UIView *lineView;

@end

@implementation ZLShopDetailsCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //头像
    [self iconButton];
    //姓名
    [self nameLabel];
    //时间
    [self timeLabel];
    //分数
    [self scoreView];
    //内容
    [self contentLabel];
    ///图片
    [self imagesView];
    ///回复
    [self replyView];
    //分割线
    [self lineView];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsCommentCellIconHeight = 40.0;
CGFloat const ZLShopDetailsCommentCellNameWidth = 150.0;
CGFloat const ZLShopDetailsCommentCellNameFont = 16.0;
CGFloat const ZLShopDetailsCommentCellImagesHeight = 110.0;
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 15.0, ZLShopDetailsCommentCellIconHeight, ZLShopDetailsCommentCellIconHeight)];
        iconButton.layer.cornerRadius = ZLShopDetailsCommentCellIconHeight / 2;
        [iconButton setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
        iconButton.layer.masksToBounds = YES;
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame) + 10.0, CGRectGetMinY(self.iconButton.frame), ZLShopDetailsCommentCellNameWidth, ZLShopDetailsCommentCellIconHeight / 8 * 5)];
        nameLabel.text = @"<暂无昵称>";
        nameLabel.font = [UIFont systemFontOfSize:ZLShopDetailsCommentCellNameFont];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame), CGRectGetWidth(self.nameLabel.frame), ZLShopDetailsCommentCellIconHeight / 8 * 3)];
        timeLabel.text = @"<暂无时间>";
        timeLabel.textColor = UIColor.lightGrayColor;
        timeLabel.font = [UIFont systemFontOfSize:ZLShopDetailsCommentCellNameFont * 0.7];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}
- (ZLShopDetailsCommentStarView *)scoreView {
    if (!_scoreView) {
        CGFloat height = ZLShopDetailsCommentCellIconHeight / 8 * 5;
        CGFloat width = height * 0.7 * 5 + height * 2;
        ZLShopDetailsCommentStarView *scoreView = [[ZLShopDetailsCommentStarView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - width, CGRectGetMinY(self.nameLabel.frame), width, height)];
        
        scoreView.score = @"5";
        
        [self.contentView addSubview:scoreView];
        _scoreView = scoreView;
    }
    return _scoreView;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.iconButton.frame) + 15.0, UIScreen.mainScreen.bounds.size.width - 30.0, 20.0)];
        contentLabel.text = @"<暂无内容>";
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}
- (ZLShopDetailsCommentImagesView *)imagesView {
    if (!_imagesView) {
        ZLShopDetailsCommentImagesView *imagesView = [[ZLShopDetailsCommentImagesView alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.contentLabel.frame) + 15.0, UIScreen.mainScreen.bounds.size.width - 30.0, 0)];
        imagesView.hidden = YES;
        [self.contentView addSubview:imagesView];
        _imagesView = imagesView;
    }
    return _imagesView;
}
- (ZLShopDetailsCommentReplyView *)replyView {
    if (!_replyView) {
        ZLShopDetailsCommentReplyView *replyView = [[ZLShopDetailsCommentReplyView alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.imagesView.frame) + 5.0, UIScreen.mainScreen.bounds.size.width - 30.0, 90.0)];
        replyView.hidden = YES;
        [self.contentView addSubview:replyView];
        _replyView = replyView;
    }
    return _replyView;
}
- (UIView *)lineView {
    if (!_lineView) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0.3)];
        lineView.backgroundColor = UIColor.lightGrayColor;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model {
    ZLShopDetailsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLShopDetailsCommentCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLShopDetailsCommentCell class])];
    }
    cell.contentLabel.text = model.content;
    cell.contentLabel.height = model.contentHeight;
    cell.imagesView.hidden = NO;
    
    return cell;
}

@end
