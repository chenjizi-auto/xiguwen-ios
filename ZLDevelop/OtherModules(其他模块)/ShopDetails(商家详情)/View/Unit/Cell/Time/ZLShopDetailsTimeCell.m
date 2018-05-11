//
//  ZLShopDetailsTimeCell.m
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsTimeCell.h"
#import "ZLShopDetailsTimeView.h"

@interface ZLShopDetailsTimeCell ()

///单元块
@property (nonatomic,weak) ZLShopDetailsTimeView *timeView;

@end

@implementation ZLShopDetailsTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    ///单元块
    [self timeView];
}

#pragma mark - Lazy
CGFloat const ZLShopDetailsTimeCellHeight = 50.0;
- (ZLShopDetailsTimeView *)timeView {
    if (!_timeView) {
        ZLShopDetailsTimeView *timeView = [[ZLShopDetailsTimeView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, ZLShopDetailsTimeCellHeight)];
        [self.contentView addSubview:timeView];
        _timeView = timeView;
    }
    return _timeView;
}

#pragma mark - Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Strategy:(ZLShopDetailsCellStrategyState)state {
    ZLShopDetailsTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLShopDetailsTimeCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLShopDetailsTimeCell class])];
    }
    return cell;
}

@end
