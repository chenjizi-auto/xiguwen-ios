//
//  ZLShopDetailsSampleCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsSampleCell.h"
#import "ZLShopDetailsSampleView.h"

@interface ZLShopDetailsSampleCell ()

//左边块
@property (nonatomic,weak) ZLShopDetailsSampleView *leftBlockView;
//右边块
@property (nonatomic,weak) ZLShopDetailsSampleView *rightBlockView;

@end

@implementation ZLShopDetailsSampleCell

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
CGFloat const ZLShopDetailsSampleCellHeight = 220.0;
- (ZLShopDetailsSampleView *)leftBlockView {
    if (!_leftBlockView) {
        ZLShopDetailsSampleView *leftBlockView = [[ZLShopDetailsSampleView alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width - 5.0) / 2, ZLShopDetailsSampleCellHeight)];
        [self.contentView addSubview:leftBlockView];
        _leftBlockView = leftBlockView;
    }
    return _leftBlockView;
}
- (ZLShopDetailsSampleView *)rightBlockView {
    if (!_rightBlockView) {
        ZLShopDetailsSampleView *rightBlockView = [[ZLShopDetailsSampleView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - 5.0) / 2 + 5.0, 0, (UIScreen.mainScreen.bounds.size.width - 5.0) / 2, ZLShopDetailsSampleCellHeight)];
        [self.contentView addSubview:rightBlockView];
        _rightBlockView = rightBlockView;
    }
    return _rightBlockView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    ZLShopDetailsSampleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLShopDetailsSampleCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLShopDetailsSampleCell class])];
        cell.leftBlockView.click = ^{
            NSLog(@"左边的");
        };
        cell.rightBlockView.click = ^{
            NSLog(@"右边的");
        };
    }
    cell.leftBlockView.title = @"酒店婚礼主持";
    cell.leftBlockView.intro = @"介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍v";
    cell.leftBlockView.price = @"￥2220000起";
    cell.leftBlockView.browse = @"18883";
    return cell;
}

@end
