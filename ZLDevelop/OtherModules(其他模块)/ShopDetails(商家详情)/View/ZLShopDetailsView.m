//
//  ZLShopDetailsView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsView.h"
#import "ZLShopDetailsNavBgView.h"
#import "ZLShopDetailsHeaderView.h"
#import "ZLShopDetailsStrategyCell.h"
#import "ZLShopDetailsAreaView.h"

@interface ZLShopDetailsView ()<UITableViewDataSource,UITableViewDelegate>

//滑动视图
@property (nonatomic,weak) UITableView *tableView;
//渐变导航背景
@property (nonatomic,weak) ZLShopDetailsNavBgView *shopDetailsNavBgView;
//滑动视图头部
@property (nonatomic,strong) ZLShopDetailsHeaderView *shopDetailsHeaderView;
//区头（复用）
@property (nonatomic,strong) NSMutableArray *sectionHeadersArrayM;
//区尾（复用）
@property (nonatomic,strong) NSMutableArray *sectionFootersArrayM;

@end

@implementation ZLShopDetailsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加子视图
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //滑动视图
    [self tableView];
    //注册事件
    [self registerActions];
    //渐变导航背景
    [self shopDetailsNavBgView];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStyleGrouped)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = NO;
        tableView.tableHeaderView = self.shopDetailsHeaderView;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (ZLShopDetailsHeaderView *)shopDetailsHeaderView {
    if (!_shopDetailsHeaderView) {
        ZLShopDetailsHeaderView *shopDetailsHeaderView = [[ZLShopDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 429.0)];
        _shopDetailsHeaderView = shopDetailsHeaderView;
    }
    return _shopDetailsHeaderView;
}
- (ZLShopDetailsNavBgView *)shopDetailsNavBgView {//处理导航栏的渐变
    if (!_shopDetailsNavBgView) {
        ZLShopDetailsNavBgView *shopDetailsNavBgView = [[ZLShopDetailsNavBgView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 64.0)];
        [self addSubview:shopDetailsNavBgView];
        _shopDetailsNavBgView = shopDetailsNavBgView;
    }
    return _shopDetailsNavBgView;
}
- (NSMutableArray *)sectionHeadersArrayM {
    if (!_sectionHeadersArrayM) {
        NSInteger count = self.shopDetailsHeaderView.titlesArray.count;
        if (count) {
            _sectionHeadersArrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < count; index++) {
                [_sectionHeadersArrayM addObject:[NSMutableArray new]];
            }
        }
    }
    return _sectionHeadersArrayM;
}
- (NSMutableArray *)sectionFootersArrayM {
    if (!_sectionFootersArrayM) {
        NSInteger count = self.shopDetailsHeaderView.titlesArray.count;
        if (count) {
            _sectionFootersArrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < count; index++) {
                [_sectionFootersArrayM addObject:[NSMutableArray new]];
            }
        }
    }
    return _sectionFootersArrayM;
}

#pragma mark - Set
- (void)setDataModel:(ZLShopDetailsModel *)dataModel {
    _dataModel = dataModel;
    //赋值
    [self giveValues];
    //刷新
    [self reloadData];
}

#pragma mark - Separate
- (void)registerActions {
    __weak typeof(self)weakSelf = self;
    self.shopDetailsHeaderView.itemsClick = ^(NSInteger index) {//动态悬浮条item点击事件
//        [weakSelf.tableView setContentOffset:CGPointMake(0,0) animated:YES];
        weakSelf.dataModel.moduleStrategy = index;
        if (weakSelf.loadData) {
            weakSelf.loadData();
        }
    };
}
- (void)giveValues {
    //避免重复赋值
    if (!self.shopDetailsHeaderView.title) {
        self.shopDetailsNavBgView.title = _dataModel.navTitle;
        self.shopDetailsHeaderView.title = _dataModel.title;
        self.shopDetailsHeaderView.honorsArray = _dataModel.honorsArray;
        self.shopDetailsHeaderView.position = _dataModel.position;
        self.shopDetailsHeaderView.gradesArray = _dataModel.gradesArray;
        self.shopDetailsHeaderView.listArray = _dataModel.listArray;
        self.shopDetailsHeaderView.address = _dataModel.address;
        self.shopDetailsHeaderView.phoneNumber = _dataModel.phoneNumber;
        self.shopDetailsHeaderView.titlesArray = _dataModel.titlesArray;
    }
}
- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ZLShopDetailsAreaView numberOfSectionsInModel:self.dataModel];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZLShopDetailsStrategyCell numberOfRowsInSection:section Model:self.dataModel];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLShopDetailsStrategyCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.dataModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLShopDetailsStrategyCell heightForRowAtIndexPath:indexPath Model:self.dataModel];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [ZLShopDetailsAreaView heightForFooterInSection:section Model:self.dataModel];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [ZLShopDetailsAreaView heightForHeaderInSection:section Model:self.dataModel];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [ZLShopDetailsAreaView viewForFooterInSection:section SectionFooters:self.sectionFootersArrayM Model:self.dataModel];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [ZLShopDetailsAreaView viewForHeaderInSection:section SectionHeaders:self.sectionHeadersArrayM Model:self.dataModel];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //在xx高度内发生渐变
    float alphaHeight = 64.0;
    //进行渐变
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat alpha = (offSetY <= 0) ? 0 : offSetY / alphaHeight;
    alpha = alpha > 1 ? 1 : alpha;
    self.shopDetailsNavBgView.alpha = alpha;
    //动态悬浮功能条
    [self.shopDetailsHeaderView functionBarDynamicSuspend];
    //图片缩放
    [self.shopDetailsHeaderView imageZoomWithOffsetY:offSetY];
}

@end
