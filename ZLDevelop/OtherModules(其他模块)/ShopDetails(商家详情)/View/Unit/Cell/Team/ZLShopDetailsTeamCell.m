//
//  ZLShopDetailsTeamCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsTeamCell.h"
#import "ZLShopDetailsTeamView.h"

@interface ZLShopDetailsTeamCell ()

//左边块
@property (nonatomic,weak) ZLShopDetailsTeamView *leftBlockView;
//中间块
@property (nonatomic,weak) ZLShopDetailsTeamView *centerBlockView;
//右边块
@property (nonatomic,weak) ZLShopDetailsTeamView *rightBlockView;

@end

@implementation ZLShopDetailsTeamCell

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
    //中间块
    [self centerBlockView];
    //右边块
    [self rightBlockView];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsTeamCellHeight = 150.0;
- (ZLShopDetailsTeamView *)leftBlockView {
    if (!_leftBlockView) {
        ZLShopDetailsTeamView *leftBlockView = [[ZLShopDetailsTeamView alloc] initWithFrame:CGRectMake(15.0, 0, (UIScreen.mainScreen.bounds.size.width - 40.0) / 3, ZLShopDetailsTeamCellHeight)];
        [self.contentView addSubview:leftBlockView];
        _leftBlockView = leftBlockView;
    }
    return _leftBlockView;
}
- (ZLShopDetailsTeamView *)centerBlockView {
    if (!_centerBlockView) {
        ZLShopDetailsTeamView *centerBlockView = [[ZLShopDetailsTeamView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBlockView.frame) + 5.0, 0, (UIScreen.mainScreen.bounds.size.width - 40.0) / 3, ZLShopDetailsTeamCellHeight)];
        [self.contentView addSubview:centerBlockView];
        _centerBlockView = centerBlockView;
    }
    return _centerBlockView;
}
- (ZLShopDetailsTeamView *)rightBlockView {
    if (!_rightBlockView) {
        ZLShopDetailsTeamView *rightBlockView = [[ZLShopDetailsTeamView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.centerBlockView.frame) + 5.0, 0, (UIScreen.mainScreen.bounds.size.width - 40.0) / 3, ZLShopDetailsTeamCellHeight)];
        [self.contentView addSubview:rightBlockView];
        _rightBlockView = rightBlockView;
    }
    return _rightBlockView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Strategy:(ZLShopDetailsCellStrategyState)state {
    ZLShopDetailsTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLShopDetailsTeamCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLShopDetailsTeamCell class])];
        cell.leftBlockView.click = ^{
            NSLog(@"左边的");
        };
        cell.centerBlockView.click = ^{
            NSLog(@"中间的");
        };
        cell.rightBlockView.click = ^{
            NSLog(@"右边的");
        };
    }
    cell.leftBlockView.title = @"酒店婚礼主持";
    cell.leftBlockView.price = @"￥222000起";
    cell.leftBlockView.profession = @"策划师";
    return cell;
}

@end
