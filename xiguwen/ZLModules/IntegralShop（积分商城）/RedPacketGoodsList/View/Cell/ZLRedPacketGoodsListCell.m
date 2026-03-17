//
//  ZLRedPacketGoodsListCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
// 

#import "ZLRedPacketGoodsListCell.h"
#import "ZLRedPacketGoodsListUnitView.h"

@interface ZLRedPacketGoodsListCell ()

//左边块
@property (nonatomic,weak) ZLRedPacketGoodsListUnitView *leftBlockView;
//右边块
@property (nonatomic,weak) ZLRedPacketGoodsListUnitView *rightBlockView;
///顶部的线
@property (nonatomic,weak) CALayer *topLine;
///底部的线
@property (nonatomic,weak) CALayer *bottomLine;
///
@property (nonatomic,weak) id <ZLRedPacketGoodsListCellDelgate>delegate;

@end

@implementation ZLRedPacketGoodsListCell

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
- (ZLRedPacketGoodsListUnitView *)leftBlockView {
    if (!_leftBlockView) {
        ZLRedPacketGoodsListUnitView *leftBlockView = [[ZLRedPacketGoodsListUnitView alloc] initWithFrame:CGRectMake(15.0, 15.0, (UIScreen.mainScreen.bounds.size.width - 60.0) / 2, 195.0)];
        [self.contentView addSubview:leftBlockView];
        _leftBlockView = leftBlockView;
    }
    return _leftBlockView;
}
- (ZLRedPacketGoodsListUnitView *)rightBlockView {
    if (!_rightBlockView) {
        ZLRedPacketGoodsListUnitView *rightBlockView = [[ZLRedPacketGoodsListUnitView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBlockView.frame) + 30.0, 15.0, CGRectGetWidth(self.leftBlockView.frame), CGRectGetHeight(self.leftBlockView.frame))];
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
    ZLRedPacketGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLRedPacketGoodsListCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLRedPacketGoodsListCell class])];
        cell.delegate = delegate;
        __weak typeof(cell)weakCell = cell;
        cell.leftBlockView.click = ^{
            if (weakCell.delegate && [(UIView *)weakCell.delegate respondsToSelector:@selector(lookDetailWithModel:)]) {
                NSIndexPath *currentIndexPath = [tableView indexPathForCell:weakCell];
                NSInteger leftNum = (currentIndexPath.row * 2);
                ZLRedPacketGoodsListModel *infoModel = model;
                [weakCell.delegate lookDetailWithModel:infoModel.unitModels[leftNum]];
            }
        };
        cell.rightBlockView.click = ^{
            if (weakCell.delegate && [(UIView *)weakCell.delegate respondsToSelector:@selector(lookDetailWithModel:)]) {
                NSIndexPath *currentIndexPath = [tableView indexPathForCell:weakCell];
                NSInteger rightNum = (currentIndexPath.row * 2 + 1);
                ZLRedPacketGoodsListModel *infoModel = model;
                [weakCell.delegate lookDetailWithModel:infoModel.unitModels[rightNum]];
            }
        };
    }
    cell.leftBlockView.hidden = YES;
    cell.rightBlockView.hidden = YES;
    
    ZLRedPacketGoodsListModel *infoModel = model;
    
    NSInteger leftNum = (indexPath.row * 2);
    if (leftNum < infoModel.unitModels.count) {
        ZLRedPacketGoodsListModel *rowModel = infoModel.unitModels[leftNum];
        cell.leftBlockView.hidden = NO;
        cell.leftBlockView.title = rowModel.title;
        cell.leftBlockView.imagePath = rowModel.imageUrl;
        cell.leftBlockView.price = rowModel.integral;
    }
    
    NSInteger rightNum = (indexPath.row * 2 + 1);
    if (rightNum < infoModel.unitModels.count) {
        ZLRedPacketGoodsListModel *rowModel = infoModel.unitModels[rightNum];
        cell.rightBlockView.hidden = NO;
        cell.rightBlockView.title = rowModel.title;
        cell.rightBlockView.imagePath = rowModel.imageUrl;
        cell.rightBlockView.price = rowModel.integral;
    }
    return cell;
}

@end
