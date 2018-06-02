//
//  ZLIntegralShopH5PageView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/28.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopH5PageView.h"
#import <MJRefresh.h>
#import "ZLIntegralShopH5PageCell.h"

@interface ZLIntegralShopH5PageView ()<UITableViewDataSource,UITableViewDelegate>

///
@property (nonatomic,weak) UITableView *tableView;
///加载视图
@property (nonatomic,weak) UIView *hudView;

@end

@implementation ZLIntegralShopH5PageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        self.cellHeight = UIScreen.mainScreen.bounds.size.height - statusBarHeight - 44.0;
    }
    return self;
}

#pragma mark - Set
- (void)setSrcPath:(NSString *)srcPath {
    _srcPath = srcPath;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.hudView.hidden = !self.hudView.hidden;
    [self.tableView.mj_header endRefreshing];
    ZLIntegralShopH5PageCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.srcPath = _srcPath;
}
- (void)setCellHeight:(CGFloat)cellHeight {
    _cellHeight = cellHeight;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.hudView.hidden = !self.hudView.hidden;
    [self.tableView reloadData];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [self addSubviews];
    }
    return _tableView;
}
- (UIView *)hudView {
    if (!_hudView) {
        UIView *hudView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:hudView];
        UIView *blackView = [[UIView alloc] initWithFrame:self.bounds];
        blackView.backgroundColor = UIColor.blackColor;
        blackView.alpha = 0.2;
        [hudView addSubview:blackView];
        
        //指示器
        UILabel *hudLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(hudView.frame) - 160.0) / 2, (CGRectGetHeight(hudView.frame) - 50.0) / 2, 160.0, 50.0)];
        hudLabel.text = @"正在加载中……";
        hudLabel.font = [UIFont boldSystemFontOfSize:17.0];
        hudLabel.textAlignment = NSTextAlignmentCenter;
        hudLabel.backgroundColor = [UIColor blackColor];
        hudLabel.textColor = UIColor.whiteColor;
        hudLabel.layer.cornerRadius = 3.0;
        hudLabel.layer.masksToBounds = YES;
        [hudView addSubview:hudLabel];
        _hudView = hudView;
    }
    return _hudView;
}

#pragma mark - Add
- (UITableView *)addSubviews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //ios11 适配
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
    }
    __weak typeof(self)weakSelf = self;
    tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.srcPath = weakSelf.srcPath;
    }];
    tableView.contentInset = UIEdgeInsetsMake(statusBarHeight + 44.0, 0, 0, 0);
    tableView.tableFooterView = [UIView new];
    [self addSubview:tableView];
    return tableView;
}

#pragma mark - Public
- (BOOL)canGoBack {
    ZLIntegralShopH5PageCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return [cell canGoBack];
}
- (void)goBack {
    ZLIntegralShopH5PageCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell goBack];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLIntegralShopH5PageCell reuseCellWithTableView:tableView IndexPath:indexPath];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}


@end
