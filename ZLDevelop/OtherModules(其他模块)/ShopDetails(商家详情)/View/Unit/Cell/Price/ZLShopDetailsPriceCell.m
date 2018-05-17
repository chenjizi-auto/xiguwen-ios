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
        ZLShopDetailsPriceView *leftBlockView = [[ZLShopDetailsPriceView alloc] initWithFrame:CGRectMake(0, 5.0, (UIScreen.mainScreen.bounds.size.width - 5.0) / 2, ZLShopDetailsPriceCellHeight)];
        [self.contentView addSubview:leftBlockView];
        _leftBlockView = leftBlockView;
    }
    return _leftBlockView;
}
- (ZLShopDetailsPriceView *)rightBlockView {
    if (!_rightBlockView) {
        ZLShopDetailsPriceView *rightBlockView = [[ZLShopDetailsPriceView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - 5.0) / 2 + 5.0, 5.0, (UIScreen.mainScreen.bounds.size.width - 5.0) / 2, ZLShopDetailsPriceCellHeight)];
        [self.contentView addSubview:rightBlockView];
        _rightBlockView = rightBlockView;
    }
    return _rightBlockView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Model:(ZLShopDetailsModel *)model {
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
    cell.leftBlockView.hidden = YES;
    cell.rightBlockView.hidden = YES;
    
    NSInteger leftNum = (indexPath.row * 2);
    if (leftNum < model.subModelsArrayM.count) {
        ZLShopDetailsModel *rowModel = model.subModelsArrayM[leftNum];
        cell.leftBlockView.hidden = NO;
        cell.leftBlockView.title = rowModel.title;
        cell.leftBlockView.price = rowModel.price;
        cell.leftBlockView.number = rowModel.number;
        cell.leftBlockView.imagePath = rowModel.headImageUrlPath;
    }
    
    NSInteger rightNum = (indexPath.row * 2 + 1);
    if (rightNum < model.subModelsArrayM.count) {
        ZLShopDetailsModel *rowModel = model.subModelsArrayM[rightNum];
        cell.rightBlockView.hidden = NO;
        cell.rightBlockView.title = rowModel.title;
        cell.rightBlockView.price = rowModel.price;
        cell.rightBlockView.number = rowModel.number;
        cell.rightBlockView.imagePath = rowModel.headImageUrlPath;
    }
    return cell;
}

@end
