//
//  ZLIntegralDetailView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLIntegralDetailView.h"
#import "ZLIntegralDetailCell.h"
#import <MJRefresh.h>

@interface ZLIntegralDetailView ()<UITableViewDelegate,UITableViewDataSource>

///
@property (nonatomic,weak) UITableView *tableView;

@end

@implementation ZLIntegralDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLIntegralDetailModel *)infoModel {
    _infoModel = infoModel;
    [self changeState];
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
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    tableView.rowHeight = 70.0;
    //ios11 适配
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
    }
    __weak typeof(self)weakSelf = self;
    tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.infoModel.showNoMore = NO;
        [weakSelf.tableView.mj_footer resetNoMoreData];
        if (weakSelf.loadData) {
            weakSelf.infoModel.page = 1;
            weakSelf.infoModel.more = NO;
            weakSelf.loadData();
        }
    }];
    tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.loadData) {
                weakSelf.infoModel.page += 1;
                weakSelf.infoModel.more = YES;
                weakSelf.loadData();
            }
        });
    }];
    tableView.mj_footer.hidden = YES;
    tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:tableView];
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    tableView.contentInset = UIEdgeInsetsMake(statusBarHeight + 44.0, 0, statusBarHeight == 20.0 ? 0 : 14.0, 0);
    return tableView;
}

#pragma mark - Separate
- (void)changeState {
    self.tableView.mj_footer.hidden = (self.infoModel.unitModels.count >= self.infoModel.count)
                                    ? NO
                                    : YES;
    if (self.infoModel.showNoMore) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        if (!self.infoModel.more) {
            [self.tableView.mj_header endRefreshing];
        }
    }else {
        if (!self.infoModel.more) {
            [self.tableView.mj_header endRefreshing];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoModel.unitModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLIntegralDetailCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel.unitModels[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end
