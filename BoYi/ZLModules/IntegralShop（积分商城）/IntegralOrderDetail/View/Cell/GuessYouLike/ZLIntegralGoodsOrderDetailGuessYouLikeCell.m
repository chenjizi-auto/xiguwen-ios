//
//  ZLIntegralGoodsOrderDetailGuessYouLikeCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailGuessYouLikeCell.h"
#import "ZLIntegralGoodsOrderDetailGuessYouLikeUnitView.h"

@interface ZLIntegralGoodsOrderDetailGuessYouLikeCell ()

//左边块
@property (nonatomic,weak) ZLIntegralGoodsOrderDetailGuessYouLikeUnitView *leftBlockView;
//右边块
@property (nonatomic,weak) ZLIntegralGoodsOrderDetailGuessYouLikeUnitView *rightBlockView;
///
@property (nonatomic,weak) id <ZLIntegralGoodsOrderDetailGuessYouLikeCellDelgate>delegate;

@end

@implementation ZLIntegralGoodsOrderDetailGuessYouLikeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
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
- (ZLIntegralGoodsOrderDetailGuessYouLikeUnitView *)leftBlockView {
    if (!_leftBlockView) {
        CGFloat width = (UIScreen.mainScreen.bounds.size.width - 8.0) / 2;
        ZLIntegralGoodsOrderDetailGuessYouLikeUnitView *leftBlockView = [[ZLIntegralGoodsOrderDetailGuessYouLikeUnitView alloc] initWithFrame:CGRectMake(0, 0, width, width + 68.0)];
        [self.contentView addSubview:leftBlockView];
        _leftBlockView = leftBlockView;
    }
    return _leftBlockView;
}
- (ZLIntegralGoodsOrderDetailGuessYouLikeUnitView *)rightBlockView {
    if (!_rightBlockView) {
        ZLIntegralGoodsOrderDetailGuessYouLikeUnitView *rightBlockView = [[ZLIntegralGoodsOrderDetailGuessYouLikeUnitView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBlockView.frame) + 8.0, 0, CGRectGetWidth(self.leftBlockView.frame), CGRectGetHeight(self.leftBlockView.frame))];
        [self.contentView addSubview:rightBlockView];
        _rightBlockView = rightBlockView;
    }
    return _rightBlockView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLIntegralGoodsOrderDetailModel *)model {
    ZLIntegralGoodsOrderDetailGuessYouLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailGuessYouLikeCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralGoodsOrderDetailGuessYouLikeCell class])];
        cell.delegate = delegate;
        __weak typeof(cell)weakCell = cell;
        __weak typeof(tableView)weakTableView = tableView;
        __weak typeof(model)weakModel = model;
        cell.leftBlockView.click = ^{
            if (weakCell.delegate && [(UIView *)weakCell.delegate respondsToSelector:@selector(lookDetailWithModel:)]) {
                NSIndexPath *currentIndexPath = [weakTableView indexPathForCell:weakCell];
                NSInteger leftNum = (currentIndexPath.row * 2);
                [weakCell.delegate lookDetailWithModel:weakModel.unitModels[leftNum]];
            }
        };
        cell.rightBlockView.click = ^{
            if (weakCell.delegate && [(UIView *)weakCell.delegate respondsToSelector:@selector(lookDetailWithModel:)]) {
                NSIndexPath *currentIndexPath = [weakTableView indexPathForCell:weakCell];
                NSInteger rightNum = (currentIndexPath.row * 2 + 1);
                [weakCell.delegate lookDetailWithModel:weakModel.unitModels[rightNum]];
            }
        };
    }
    cell.leftBlockView.hidden = YES;
    cell.rightBlockView.hidden = YES;
    
    ZLIntegralGoodsOrderDetailModel *infoModel = model;
    
    NSInteger leftNum = (indexPath.row * 2);
    if (leftNum < infoModel.unitModels.count) {
        ZLIntegralGoodsOrderDetailModel *rowModel = infoModel.unitModels[leftNum];
        cell.leftBlockView.hidden = NO;
        cell.leftBlockView.title = rowModel.goodsName;
        cell.leftBlockView.imagePath = rowModel.goodsUrl;
        cell.leftBlockView.price = rowModel.goodsPrice;
        cell.leftBlockView.number = rowModel.number;
    }
    
    NSInteger rightNum = (indexPath.row * 2 + 1);
    if (rightNum < infoModel.unitModels.count) {
        ZLIntegralGoodsOrderDetailModel *rowModel = infoModel.unitModels[rightNum];
        cell.rightBlockView.hidden = NO;
        cell.rightBlockView.title = rowModel.goodsName;
        cell.rightBlockView.imagePath = rowModel.goodsUrl;
        cell.rightBlockView.price = rowModel.goodsPrice;
        cell.rightBlockView.number = rowModel.number;
    }
    return cell;
}

@end
