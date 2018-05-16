//
//  ZLShopDetailsDynamicCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsDynamicCell.h"
#import "ZLShopDetailsDynamicImagesView.h"
#import "ZLShopDetailsDynamicFunctionBar.h"

@interface ZLShopDetailsDynamicCell ()

///头像
@property (nonatomic,weak) UIButton *iconButton;
///姓名
@property (nonatomic,weak) UILabel *nameLabel;
///时间
@property (nonatomic,weak) UILabel *timeLabel;
///内容
@property (nonatomic,weak) UILabel *contentLabel;
///图片
@property (nonatomic,weak) ZLShopDetailsDynamicImagesView *imagesView;
///功能条
@property (nonatomic,weak) ZLShopDetailsDynamicFunctionBar *functionBar;

@end

@implementation ZLShopDetailsDynamicCell

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
    //内容
    [self contentLabel];
    ///图片
    [self imagesView];
    ///功能条
    [self functionBar];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsDynamicCellIconHeight = 40.0;
CGFloat const ZLShopDetailsDynamicCellNameWidth = 150.0;
CGFloat const ZLShopDetailsDynamicCellNameFont = 16.0;
CGFloat const ZLShopDetailsDynamicCellImagesHeight = 110.0;
- (UIButton *)iconButton {
    if (!_iconButton) {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 15.0, ZLShopDetailsDynamicCellIconHeight, ZLShopDetailsDynamicCellIconHeight)];
        iconButton.layer.cornerRadius = ZLShopDetailsDynamicCellIconHeight / 2;
        [iconButton setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
        iconButton.layer.masksToBounds = YES;
        [self.contentView addSubview:iconButton];
        _iconButton = iconButton;
    }
    return _iconButton;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconButton.frame) + 10.0, CGRectGetMinY(self.iconButton.frame), ZLShopDetailsDynamicCellNameWidth, ZLShopDetailsDynamicCellIconHeight / 8 * 5)];
        nameLabel.text = @"<暂无昵称>";
        nameLabel.font = [UIFont systemFontOfSize:ZLShopDetailsDynamicCellNameFont];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame), CGRectGetWidth(self.nameLabel.frame), ZLShopDetailsDynamicCellIconHeight / 8 * 3)];
        timeLabel.text = @"<暂无时间>";
        timeLabel.textColor = UIColor.lightGrayColor;
        timeLabel.font = [UIFont systemFontOfSize:ZLShopDetailsDynamicCellNameFont * 0.7];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
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
- (ZLShopDetailsDynamicImagesView *)imagesView {
    if (!_imagesView) {
        ZLShopDetailsDynamicImagesView *imagesView = [[ZLShopDetailsDynamicImagesView alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.contentLabel.frame) + 15.0, UIScreen.mainScreen.bounds.size.width - 30.0, ZLShopDetailsDynamicCellImagesHeight)];
        [self.contentView addSubview:imagesView];
        _imagesView = imagesView;
    }
    return _imagesView;
}
- (ZLShopDetailsDynamicFunctionBar *)functionBar {
    if (!_functionBar) {
        ZLShopDetailsDynamicFunctionBar *functionBar = [[ZLShopDetailsDynamicFunctionBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imagesView.frame) + 15.0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        [self.contentView addSubview:functionBar];
        _functionBar = functionBar;
    }
    return _functionBar;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model {
    ZLShopDetailsDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLShopDetailsDynamicCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLShopDetailsDynamicCell class])];
    }
    cell.contentLabel.text = model.content;
    cell.contentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, cell.contentLabel.frame.origin.y, cell.contentLabel.frame.size.width, model.contentHeight);
    cell.imagesView.frame = CGRectMake(cell.imagesView.frame.origin.x, CGRectGetMaxY(cell.contentLabel.frame) + 15.0, cell.imagesView.frame.size.width, cell.imagesView.frame.size.height);
    cell.functionBar.frame = CGRectMake(cell.functionBar.frame.origin.x, model.cellHeight - cell.functionBar.frame.size.height, cell.functionBar.frame.size.width, cell.functionBar.frame.size.height);
    return cell;
}

@end
