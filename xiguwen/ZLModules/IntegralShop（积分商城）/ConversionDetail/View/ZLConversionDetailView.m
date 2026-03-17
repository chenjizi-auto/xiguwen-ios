//
//  ZLConversionDetailView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
// 

#import "ZLConversionDetailView.h"
#import "ZLConversionDetailCell.h"
#import "ZLConversionDetailFunctionBar.h"
#import <MJRefresh.h>

@interface ZLConversionDetailView ()<UITableViewDelegate,UITableViewDataSource>

///
@property (nonatomic,weak) UITableView *tableView;
///
@property (nonatomic,weak) ZLConversionDetailFunctionBar *functionBar;
///单元模型的个数（避免交替时发生数据混淆，在交替时会先赋值0）
@property (nonatomic,unsafe_unretained) NSInteger unitModelCount;

@end

@implementation ZLConversionDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        [self functionBar];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLConversionDetailModel *)infoModel {
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
- (ZLConversionDetailFunctionBar *)functionBar {
    if (!_functionBar) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        ZLConversionDetailFunctionBar *functionBar = [[ZLConversionDetailFunctionBar alloc] initWithFrame:CGRectMake(0, statusBarHeight + 44.0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        functionBar.titles = @[@"商品兑换",@"红包兑换"];
        __weak typeof(self)weakSelf = self;
        //功能条点击事件
        functionBar.clickItem = ^(NSInteger index) {
            //先置空上次的数据
            weakSelf.unitModelCount = 0;
            [weakSelf.tableView reloadData];
            weakSelf.tableView.mj_footer.hidden = YES;
            //再执行重置数据
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf resetDataWithIndex:index];
            });
        };
        [self addSubview:functionBar];
        _functionBar = functionBar;
    }
    return _functionBar;
}

#pragma mark - Add
- (UITableView *)addSubviews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    tableView.rowHeight = 115.0;
    //ios11 适配
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
    }
    __weak typeof(self)weakSelf = self;
    tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.loadData) {
            ZLConversionDetailModel *model = weakSelf.infoModel.conversionType == ZLConversionTypeGoods
            ? weakSelf.infoModel.goodsModel
            : weakSelf.infoModel.redPacketModel;
            model.showNoMore = NO;
            model.page = 1;
            model.more = NO;
            [weakSelf.tableView.mj_footer resetNoMoreData];
            weakSelf.loadData();
        }
    }];
    tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.loadData) {
                ZLConversionDetailModel *model = weakSelf.infoModel.conversionType == ZLConversionTypeGoods
                                                ? weakSelf.infoModel.goodsModel
                                                : weakSelf.infoModel.redPacketModel;
                model.page += 1;
                model.more = YES;
                weakSelf.loadData();
            }
        });
    }];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.mj_footer.hidden = YES;
    [self addSubview:tableView];
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    tableView.contentInset = UIEdgeInsetsMake(statusBarHeight + 50.0 + 44.0, 0, statusBarHeight == 20.0 ? 0 : 14.0, 0);
    return tableView;
}

#pragma mark - Separate
- (void)changeState {
    self.unitModelCount = self.infoModel.conversionType == ZLConversionTypeGoods
                        ? self.infoModel.goodsModel.goodsModelsArray.count
                        : self.infoModel.redPacketModel.redPacketModelsArray.count;
    self.tableView.mj_footer.hidden = (self.unitModelCount >= self.infoModel.count)
                                    ? NO
                                    : YES;
    ZLConversionDetailModel *model = self.infoModel.conversionType == ZLConversionTypeGoods
                                   ? self.infoModel.goodsModel
                                   : self.infoModel.redPacketModel;
    if (model.showNoMore) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        if (!self.infoModel.more) {
            [self.tableView.mj_header endRefreshing];
        }
    }else {
        if (!model.more) {
            [self.tableView.mj_header endRefreshing];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}
- (void)resetDataWithIndex:(NSInteger)index {
    self.infoModel.conversionType = index;
    ZLConversionDetailModel *model = self.infoModel.conversionType == ZLConversionTypeGoods
                                   ? self.infoModel.goodsModel
                                   : self.infoModel.redPacketModel;
    //处于空白数据，请求加载
    if (!self.infoModel.redPacketModel.redPacketModelsArray.count) {
        if (self.loadData) {
            model.page = 1;
            model.more = NO;
            model.showNoMore = NO;
            [self.tableView.mj_footer resetNoMoreData];
            self.loadData();
            return;
        }
    }
    //还原显示
    self.unitModelCount = self.infoModel.conversionType == ZLConversionTypeGoods
                        ? self.infoModel.goodsModel.goodsModelsArray.count
                        : self.infoModel.redPacketModel.redPacketModelsArray.count;
    self.tableView.mj_footer.hidden = (self.unitModelCount >= self.infoModel.count)
                                    ? NO
                                    : YES;
    //还原加载状态
    (model.showNoMore)
                ? [self.tableView.mj_footer endRefreshingWithNoMoreData]
                : [self.tableView.mj_footer resetNoMoreData];
    //刷新数据
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unitModelCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLConversionDetailCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.infoModel.conversionType == ZLConversionTypeGoods) {
        if (self.lookDetail) {
            self.lookDetail(self.infoModel.goodsModel.goodsModelsArray[indexPath.row]);
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end
