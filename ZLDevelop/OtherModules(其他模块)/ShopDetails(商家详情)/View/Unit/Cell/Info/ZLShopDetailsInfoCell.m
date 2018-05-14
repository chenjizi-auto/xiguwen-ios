//
//  ZLShopDetailsInfoCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsInfoCell.h"

@interface ZLShopDetailsInfoCell ()

///标题
@property (nonatomic,weak) UILabel *titleLabel;
///内容
@property (nonatomic,weak) UILabel *contentLabel;
//分割线
@property (nonatomic,weak) CALayer *lineView;

@end

@implementation ZLShopDetailsInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///标题
    [self titleLabel];
    ///内容
    [self contentLabel];
    //分割线
    [self lineView];
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, 100.0, 50.0)];
        titleLabel.text = @"<暂无标题>";
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, UIScreen.mainScreen.bounds.size.width - 130.0, 50.0)];
        contentLabel.text = @"<暂无内容>";
        contentLabel.font = [UIFont systemFontOfSize:13.0];
        contentLabel.textAlignment = NSTextAlignmentRight;
        contentLabel.textColor = UIColor.lightGrayColor;
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}
- (CALayer *)lineView {
    if (!_lineView) {
        CALayer *lineView = [[CALayer alloc] init];
        lineView.frame = CGRectMake(0, 50.0 - 0.3, UIScreen.mainScreen.bounds.size.width, 0.3);
        lineView.backgroundColor = UIColor.lightGrayColor.CGColor;
        [self.contentView.layer addSublayer:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Strategy:(ZLShopDetailsCellStrategyState)state Model:(ZLShopDetailsModel *)model {
    ZLShopDetailsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLShopDetailsInfoCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLShopDetailsInfoCell class])];
    }
    return cell;
}

@end
