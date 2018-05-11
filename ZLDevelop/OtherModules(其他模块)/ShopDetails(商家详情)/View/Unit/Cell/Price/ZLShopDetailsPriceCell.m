//
//  ZLShopDetailsPriceCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsPriceCell.h"
#import "ZLShopDetailsPriceView.h"

@interface ZLShopDetailsPriceCell ()

//左边块
@property (nonatomic,weak) ZLShopDetailsPriceView *leftBlockView;
//右边块
@property (nonatomic,weak) ZLShopDetailsPriceView *rightBlockView;

@end

@implementation ZLShopDetailsPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //左边块
    [self leftBlockView];
    //右边块
    [self rightBlockView];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsPriceCellHeight = 185.0;
- (ZLShopDetailsPriceView *)leftBlockView {
    if (!_leftBlockView) {
        ZLShopDetailsPriceView *leftBlockView = [[ZLShopDetailsPriceView alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width - 5.0) / 2, ZLShopDetailsPriceCellHeight)];
        [self.contentView addSubview:leftBlockView];
        _leftBlockView = leftBlockView;
    }
    return _leftBlockView;
}
- (ZLShopDetailsPriceView *)rightBlockView {
    if (!_rightBlockView) {
        ZLShopDetailsPriceView *rightBlockView = [[ZLShopDetailsPriceView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - 5.0) / 2 + 5.0, 0, (UIScreen.mainScreen.bounds.size.width - 5.0) / 2, ZLShopDetailsPriceCellHeight)];
        [self.contentView addSubview:rightBlockView];
        _rightBlockView = rightBlockView;
    }
    return _rightBlockView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    ZLShopDetailsPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLShopDetailsPriceCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLShopDetailsPriceCell class])];
        cell.leftBlockView.click = ^{
            NSLog(@"左边的");
        };
        cell.rightBlockView.click = ^{
            NSLog(@"右边的");
        };
    }
    cell.leftBlockView.title = @"酒店婚礼主持";
    cell.leftBlockView.price = @"￥2220000起";
    cell.leftBlockView.number = @"已售 18883";
    return cell;
}

@end
