//
//  ZLIntegralGoodsOrderDetailView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailView.h"
#import "ZLIntegralGoodsOrderDetailOrderStateCell.h"
#import "ZLIntegralGoodsOrderDetailAddressCell.h"
#import "ZLIntegralGoodsOrderDetailGoodsCell.h"
#import "ZLIntegralGoodsOrderDetailPriceCell.h"
#import "ZLIntegralGoodsOrderDetailOrderInfoCell.h"
#import "ZLIntegralGoodsOrderDetailTitleCell.h"
#import "ZLIntegralGoodsOrderDetailGuessYouLikeCell.h"

@interface ZLIntegralGoodsOrderDetailView ()<UITableViewDelegate,UITableViewDataSource,ZLIntegralGoodsOrderDetailGuessYouLikeCellDelgate>

///
@property (nonatomic,weak) UITableView *tableView;
///待付款倒计时
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ZLIntegralGoodsOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel {
    _infoModel = infoModel;
    if (infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingPay) {
        if (!self.timer) {
            [self startTimer];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [self addSubviews];
    }
    return _tableView;
}

#pragma mark - Add
- (UITableView *)addSubviews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    //ios11 适配
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
    }
    tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self addSubview:tableView];
    return tableView;
}

#pragma mark - Separate
- (void)startTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:(NSRunLoopCommonModes)];
    self.timer = timer;
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Action
- (void)timerAction {
    self.infoModel.orderCountdown -= 1;
    ZLIntegralGoodsOrderDetailOrderStateCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.currentCountdown = self.infoModel.orderCountdown;
    if (!self.infoModel.orderCountdown) {
        [self stopTimer];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? ceil(self.infoModel.unitModels.count / 2.0) : 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        if (!indexPath.row) {
            return [ZLIntegralGoodsOrderDetailOrderStateCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else if (indexPath.row == 1) {
            return [ZLIntegralGoodsOrderDetailAddressCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else if (indexPath.row == 2) {
            return [ZLIntegralGoodsOrderDetailGoodsCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else if (indexPath.row == 3) {
            return [ZLIntegralGoodsOrderDetailPriceCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else if (indexPath.row == 4) {
            return [ZLIntegralGoodsOrderDetailOrderInfoCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else {
            return [ZLIntegralGoodsOrderDetailTitleCell reuseCellWithTableView:tableView IndexPath:indexPath];
        }
    }
    return [ZLIntegralGoodsOrderDetailGuessYouLikeCell reuseCellWithTableView:tableView IndexPath:indexPath Delegate:self Model:self.infoModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        if (!indexPath.row) {
            return 90.0;
        }else if (indexPath.row == 1) {
            return self.infoModel.addressHeight + 130.0;
        }else if (indexPath.row == 2) {
            return 100.0;
        }else if (indexPath.row == 3) {
            return 60.0;
        }else if (indexPath.row == 4) {
            CGFloat rowHeight = 60.0;
            if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingSend
                || self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingReceive
                || self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeDealSuccessful) {
                rowHeight += 20.0;
            }
            return rowHeight;
        }else {
            return 50.0;
        }
    }
    return (UIScreen.mainScreen.bounds.size.width - 5.0) / 2 + 76.0;
}

#pragma mark - ZLIntegralGoodsOrderDetailGuessYouLikeCellDelgate
- (void)lookDetailWithModel:(ZLIntegralGoodsOrderDetailModel *)model {
    if (self.lookGuessYouLikeDetail) {
        self.lookGuessYouLikeDetail(model);
    }
}

@end
