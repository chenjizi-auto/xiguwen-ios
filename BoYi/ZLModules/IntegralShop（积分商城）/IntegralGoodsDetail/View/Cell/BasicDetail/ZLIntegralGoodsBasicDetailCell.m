//
//  ZLIntegralGoodsBasicDetailCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLIntegralGoodsBasicDetailCell.h"
#import "ZLIntegralGoodsBasicDetailBanner.h"

@interface ZLIntegralGoodsBasicDetailCell ()

///轮播
@property (nonatomic,weak) ZLIntegralGoodsBasicDetailBanner *bannerView;
///标题
@property (nonatomic,weak) UILabel *titleLabel;
///价格
@property (nonatomic,weak) UILabel *priceLabel;
///数量
@property (nonatomic,weak) UILabel *numberLabel;
///
@property (nonatomic,weak) id <ZLIntegralGoodsBasicDetailCellDelgate>delegate;

@end

@implementation ZLIntegralGoodsBasicDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///轮播
    [self bannerView];
    ///标题
    [self titleLabel];
    ///价格
    [self priceLabel];
    ///数量
    [self numberLabel];
}

#pragma mark - Lazy
- (ZLIntegralGoodsBasicDetailBanner *)bannerView {
    if (!_bannerView) {
        ZLIntegralGoodsBasicDetailBanner *bannerView = [[ZLIntegralGoodsBasicDetailBanner alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width)];
        __weak typeof(self)weakSelf = self;
        bannerView.clickItem = ^(UIImageView *imageView, NSInteger index) {
            if (weakSelf.delegate && [((UIView *)weakSelf.delegate) respondsToSelector:@selector(clickBannerItem:ImageView:Index:)]) {
                [weakSelf.delegate clickBannerItem:self ImageView:imageView Index:index];
            }
        };
        [self.contentView addSubview:bannerView];
        _bannerView = bannerView;
    }
    return _bannerView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.bannerView.frame) + 10.0, UIScreen.mainScreen.bounds.size.width - 30.0, 20.0)];
        titleLabel.font = [UIFont systemFontOfSize:18.0];
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.titleLabel.frame) + 20.0, UIScreen.mainScreen.bounds.size.width - 130.0, 20.0)];
        priceLabel.font = [UIFont systemFontOfSize:18.0];
        priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 115.0, CGRectGetMaxY(self.titleLabel.frame) + 20.0, 100.0, 20.0)];
        numberLabel.textColor = UIColor.lightGrayColor;
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:numberLabel];
        _numberLabel = numberLabel;
    }
    return _numberLabel;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLIntegralGoodsDetailModel *)model {
    ZLIntegralGoodsBasicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsBasicDetailCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsBasicDetailCell class])];
        cell.delegate = delegate;
    }
    model = model.unitModels[0];
    model = model.unitModels[0];
    cell.bannerView.imageUrlsArray = model.urlsArray;
    cell.priceLabel.text = model.integral;
    cell.numberLabel.text = model.number;
    cell.titleLabel.text = model.title;
    cell.titleLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, model.titleHeight);
    cell.priceLabel.frame = CGRectMake(cell.priceLabel.frame.origin.x, CGRectGetMaxY(cell.titleLabel.frame) + 20.0, cell.priceLabel.frame.size.width, cell.priceLabel.frame.size.height);
    cell.numberLabel.frame = CGRectMake(cell.numberLabel.frame.origin.x, CGRectGetMaxY(cell.titleLabel.frame) + 20.0, cell.numberLabel.frame.size.width, cell.numberLabel.frame.size.height);
    return cell;
}

@end
