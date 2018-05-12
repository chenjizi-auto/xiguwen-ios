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
#import "ZLShopDetailsDynamicSuspendBar.h"
#import "ZLShopDetailsStrategyCell.h"

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
//策略方案
@property (nonatomic,unsafe_unretained) ZLShopDetailsModuleStrategyState strategy;

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
    //渐变导航背景
    [self shopDetailsNavBgView];
    //注册文本
    [self registerValues];
    //注册事件
    [self registerActions];
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
        _sectionHeadersArrayM = [NSMutableArray new];
        NSInteger count = self.shopDetailsHeaderView.titlesArray.count;
        for (NSInteger index = 0; index < count; index++) {
            [_sectionHeadersArrayM addObject:[NSMutableArray new]];
        }
    }
    return _sectionHeadersArrayM;
}
- (NSMutableArray *)sectionFootersArrayM {
    if (!_sectionFootersArrayM) {
        _sectionFootersArrayM = [NSMutableArray new];
        NSInteger count = self.shopDetailsHeaderView.titlesArray.count;
        for (NSInteger index = 0; index < count; index++) {
            [_sectionFootersArrayM addObject:[NSMutableArray new]];
        }
    }
    return _sectionFootersArrayM;
}

#pragma mark - Separate
- (void)registerValues {
    self.shopDetailsNavBgView.title = @"商家详情页";
    self.shopDetailsHeaderView.title = @"标题标题标题标题标题标题标题标题";
    self.shopDetailsHeaderView.honorsArray = @[@"诚信认证1",@"平台认证1",@"实名认证1",@"平台认证1"];
    self.shopDetailsHeaderView.position = @"队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员";
    self.shopDetailsHeaderView.gradesArray = @[@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1"];
    self.shopDetailsHeaderView.listArray = @[@"浏览   221",@"浏览   221",@"浏览   221"];
    self.shopDetailsHeaderView.address = @"成都市高新区云华路西部信息安全产业园";
    self.shopDetailsHeaderView.phoneNumber = @"10086";
    self.shopDetailsHeaderView.titlesArray = @[@"首页",@"报价",@"作品",@"评价",@"动态",@"档期",@"资料"];
}
- (void)registerActions {
    ZL_WEAK_SELF(weakSelf);
    self.shopDetailsHeaderView.itemsClick = ^(NSInteger index) {//动态悬浮条item点击事件
        [weakSelf.tableView setContentOffset:CGPointMake(0,0) animated:YES];
        weakSelf.strategy = index;
#warning 数据回来后再进行刷新数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    };
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ZLShopDetailsStrategyCell numberOfSectionsInTableView:tableView Strategy:self.strategy];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZLShopDetailsStrategyCell tableView:tableView numberOfRowsInSection:section Strategy:self.strategy];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLShopDetailsStrategyCell reuseCellWithTableView:tableView IndexPath:indexPath Strategy:6];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLShopDetailsStrategyCell tableView:tableView heightForRowAtIndexPath:indexPath Strategy:self.strategy];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [ZLShopDetailsStrategyCell tableView:tableView heightForFooterInSection:section Strategy:self.strategy];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [ZLShopDetailsStrategyCell tableView:tableView heightForHeaderInSection:section Strategy:self.strategy];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [ZLShopDetailsStrategyCell tableView:tableView viewForFooterInSection:section Strategy:self.strategy SectionFooters:self.sectionFootersArrayM];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [ZLShopDetailsStrategyCell tableView:tableView viewForHeaderInSection:section Strategy:self.strategy SectionHeaders:self.sectionHeadersArrayM];
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
