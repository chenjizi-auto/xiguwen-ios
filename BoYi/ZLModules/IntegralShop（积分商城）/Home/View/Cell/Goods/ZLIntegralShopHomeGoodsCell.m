//
//  ZLIntegralShopHomeGoodsCell.m
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLIntegralShopHomeGoodsCell.h"
#import "ZLIntegralShopHomeGoodsView.h"

@interface ZLIntegralShopHomeGoodsCell ()

//左边块
@property (nonatomic,weak) ZLIntegralShopHomeGoodsView *leftBlockView;
//右边块
@property (nonatomic,weak) ZLIntegralShopHomeGoodsView *rightBlockView;
///顶部的线
@property (nonatomic,weak) CALayer *topLine;
///底部的线
@property (nonatomic,weak) CALayer *bottomLine;
///
@property (nonatomic,weak) id <ZLIntegralShopHomeGoodsCellDelgate>delegate;

@end

@implementation ZLIntegralShopHomeGoodsCell

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
    //顶部的线
    [self topLine];
    //底部的线
    [self bottomLine];
}

#pragma mark - Lazy
- (ZLIntegralShopHomeGoodsView *)leftBlockView {
    if (!_leftBlockView) {
        ZLIntegralShopHomeGoodsView *leftBlockView = [[ZLIntegralShopHomeGoodsView alloc] initWithFrame:CGRectMake(15.0, 15.0, (UIScreen.mainScreen.bounds.size.width - 60.0) / 2, 195.0)];
        [self.contentView addSubview:leftBlockView];
        _leftBlockView = leftBlockView;
    }
    return _leftBlockView;
}
- (ZLIntegralShopHomeGoodsView *)rightBlockView {
    if (!_rightBlockView) {
        ZLIntegralShopHomeGoodsView *rightBlockView = [[ZLIntegralShopHomeGoodsView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBlockView.frame) + 30.0, 15.0, CGRectGetWidth(self.leftBlockView.frame), CGRectGetHeight(self.leftBlockView.frame))];
        [self.contentView addSubview:rightBlockView];
        _rightBlockView = rightBlockView;
    }
    return _rightBlockView;
}
- (CALayer *)topLine {
    if (!_topLine) {
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 1.0);
        layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        [self.contentView.layer addSublayer:layer];
        _topLine = layer;
    }
    return _topLine;
}
- (CALayer *)bottomLine {
    if (!_bottomLine) {
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width * 0.5, 0, 1.0, 225.0);
        layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        [self.contentView.layer addSublayer:layer];
        _topLine = layer;
    }
    return _bottomLine;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(id)model {
    ZLIntegralShopHomeGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralShopHomeGoodsCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralShopHomeGoodsCell class])];
        cell.delegate = delegate;
        __weak typeof(cell)weakCell = cell;
        __weak typeof(tableView)weakTableView = tableView;
        cell.leftBlockView.click = ^{
            if (weakCell.delegate && [(UIView *)weakCell.delegate respondsToSelector:@selector(lookDetailWithModel:)]) {
                NSIndexPath *currentIndexPath = [weakTableView indexPathForCell:weakCell];
                NSInteger leftNum = (currentIndexPath.row * 2);
                ZLIntegralShopHomeModel *infoModel = model;
                ZLIntegralShopHomeModel *model = infoModel.unitModels[currentIndexPath.section];
                [weakCell.delegate lookDetailWithModel:model.unitModels[leftNum]];
            }
        };
        cell.rightBlockView.click = ^{
            if (weakCell.delegate && [(UIView *)weakCell.delegate respondsToSelector:@selector(lookDetailWithModel:)]) {
                NSIndexPath *currentIndexPath = [weakTableView indexPathForCell:weakCell];
                NSInteger rightNum = (currentIndexPath.row * 2 + 1);
                ZLIntegralShopHomeModel *infoModel = model;
                ZLIntegralShopHomeModel *model = infoModel.unitModels[currentIndexPath.section];
                [weakCell.delegate lookDetailWithModel:model.unitModels[rightNum]];
            }
        };
    }
    cell.leftBlockView.hidden = YES;
    cell.rightBlockView.hidden = YES;
    
    ZLIntegralShopHomeModel *infoModel = model;
    ZLIntegralShopHomeModel *sectionModel = infoModel.unitModels[indexPath.section];
    
    NSInteger leftNum = (indexPath.row * 2);
    if (leftNum < sectionModel.unitModels.count) {
        ZLIntegralShopHomeModel *rowModel = sectionModel.unitModels[leftNum];
        cell.leftBlockView.hidden = NO;
        cell.leftBlockView.title = rowModel.goodsName;
        cell.leftBlockView.imagePath = rowModel.goodsUrl;
        cell.leftBlockView.price = rowModel.goodsPrice;
    }
    
    NSInteger rightNum = (indexPath.row * 2 + 1);
    if (rightNum < sectionModel.unitModels.count) {
        ZLIntegralShopHomeModel *rowModel = sectionModel.unitModels[rightNum];
        cell.rightBlockView.hidden = NO;
        cell.rightBlockView.title = rowModel.goodsName;
        cell.rightBlockView.imagePath = rowModel.goodsUrl;
        cell.rightBlockView.price = rowModel.goodsPrice;
    }
    return cell;
}

@end
