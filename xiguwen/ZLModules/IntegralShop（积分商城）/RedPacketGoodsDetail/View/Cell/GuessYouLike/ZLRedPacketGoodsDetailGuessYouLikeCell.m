//
//  ZLGuessYouLikeGoodsGuessYouLikeCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLRedPacketGoodsDetailGuessYouLikeCell.h"
#import "ZLRedPacketGoodsDetailGuessYouLikeUnitView.h"

@interface ZLRedPacketGoodsDetailGuessYouLikeCell ()

//左边块
@property (nonatomic,weak) ZLRedPacketGoodsDetailGuessYouLikeUnitView *leftBlockView;
//右边块
@property (nonatomic,weak) ZLRedPacketGoodsDetailGuessYouLikeUnitView *rightBlockView;
///
@property (nonatomic,weak) id <ZLRedPacketGoodsDetailGuessYouLikeCellDelgate>delegate;

@end

@implementation ZLRedPacketGoodsDetailGuessYouLikeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
- (ZLRedPacketGoodsDetailGuessYouLikeUnitView *)leftBlockView {
    if (!_leftBlockView) {
        CGFloat width = (UIScreen.mainScreen.bounds.size.width - 8.0) / 2;
        ZLRedPacketGoodsDetailGuessYouLikeUnitView *leftBlockView = [[ZLRedPacketGoodsDetailGuessYouLikeUnitView alloc] initWithFrame:CGRectMake(0, 0, width, width + 68.0)];
        [self.contentView addSubview:leftBlockView];
        _leftBlockView = leftBlockView;
    }
    return _leftBlockView;
}
- (ZLRedPacketGoodsDetailGuessYouLikeUnitView *)rightBlockView {
    if (!_rightBlockView) {
        ZLRedPacketGoodsDetailGuessYouLikeUnitView *rightBlockView = [[ZLRedPacketGoodsDetailGuessYouLikeUnitView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBlockView.frame) + 8.0, 0, CGRectGetWidth(self.leftBlockView.frame), CGRectGetHeight(self.leftBlockView.frame))];
        [self.contentView addSubview:rightBlockView];
        _rightBlockView = rightBlockView;
    }
    return _rightBlockView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Delegate:(id)delegate Model:(ZLRedPacketGoodsDetailModel *)model {
    ZLRedPacketGoodsDetailGuessYouLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLRedPacketGoodsDetailGuessYouLikeCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLRedPacketGoodsDetailGuessYouLikeCell class])];
        cell.delegate = delegate;
        __weak typeof(cell)weakCell = cell;
        __weak typeof(tableView)weakTableView = tableView;
        __weak typeof(model)weakModel = model;
        cell.leftBlockView.click = ^{
            if (weakCell.delegate && [(UIView *)weakCell.delegate respondsToSelector:@selector(lookDetailWithModel:)]) {
                NSIndexPath *currentIndexPath = [weakTableView indexPathForCell:weakCell];
                NSInteger leftNum = (currentIndexPath.row * 2);
                ZLRedPacketGoodsDetailModel *rowModel = weakModel.unitModels[currentIndexPath.section];
                [weakCell.delegate lookDetailWithModel:rowModel.unitModels[leftNum]];
            }
        };
        cell.rightBlockView.click = ^{
            if (weakCell.delegate && [(UIView *)weakCell.delegate respondsToSelector:@selector(lookDetailWithModel:)]) {
                NSIndexPath *currentIndexPath = [weakTableView indexPathForCell:weakCell];
                NSInteger rightNum = (currentIndexPath.row * 2 + 1);
                ZLRedPacketGoodsDetailModel *rowModel = weakModel.unitModels[currentIndexPath.section];
                [weakCell.delegate lookDetailWithModel:rowModel.unitModels[rightNum]];
            }
        };
    }
    cell.leftBlockView.hidden = YES;
    cell.rightBlockView.hidden = YES;
    
    ZLRedPacketGoodsDetailModel *infoModel = model;
    infoModel = infoModel.unitModels[indexPath.section];
    
    NSInteger leftNum = (indexPath.row * 2);
    if (leftNum < infoModel.unitModels.count) {
        ZLRedPacketGoodsDetailModel *rowModel = infoModel.unitModels[leftNum];
        cell.leftBlockView.hidden = NO;
        cell.leftBlockView.title = rowModel.title;
        cell.leftBlockView.imagePath = rowModel.imageUrl;
        cell.leftBlockView.price = rowModel.integral;
        cell.leftBlockView.number = rowModel.number;
    }
    
    NSInteger rightNum = (indexPath.row * 2 + 1);
    if (rightNum < infoModel.unitModels.count) {
        ZLRedPacketGoodsDetailModel *rowModel = infoModel.unitModels[rightNum];
        cell.rightBlockView.hidden = NO;
        cell.rightBlockView.title = rowModel.title;
        cell.rightBlockView.imagePath = rowModel.imageUrl;
        cell.rightBlockView.price = rowModel.integral;
        cell.rightBlockView.number = rowModel.number;
    }
    return cell;
}

@end
