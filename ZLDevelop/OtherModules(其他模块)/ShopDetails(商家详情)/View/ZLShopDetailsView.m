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
#import "ZLShopDetailsAreaHeaderView.h"
#import "ZLShopDetailsAreaFooterView.h"
#import "ZLShopDetailsPriceCell.h"
#import "ZLShopDetailsSampleCell.h"
#import "ZLShopDetailsCommentCell.h"
#import "ZLShopDetailsDynamicCell.h"
#import "ZLShopDetailsTimeCell.h"
#import "ZLShopDetailsInfoCell.h"

@interface ZLShopDetailsView ()<UITableViewDataSource,UITableViewDelegate>

//滑动视图
@property (nonatomic,weak) UITableView *tableView;
//渐变导航背景
@property (nonatomic,weak) ZLShopDetailsNavBgView *shopDetailsNavBgView;
//
@property (nonatomic,weak) ZLShopDetailsHeaderView *shopDetailsHeaderView;
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
        
        //配置头部
        ZLShopDetailsHeaderView *shopDetailsHeaderView = [[ZLShopDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 429.0)];
        tableView.tableHeaderView = shopDetailsHeaderView;
        self.shopDetailsHeaderView = shopDetailsHeaderView;
        
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (ZLShopDetailsNavBgView *)shopDetailsNavBgView {//处理导航栏的渐变
    if (!_shopDetailsNavBgView) {
        ZLShopDetailsNavBgView *shopDetailsNavBgView = [[ZLShopDetailsNavBgView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 64.0)];
        shopDetailsNavBgView.title = @"商家详情页";
        [self addSubview:shopDetailsNavBgView];
        _shopDetailsNavBgView = shopDetailsNavBgView;
    }
    return _shopDetailsNavBgView;
}
- (NSMutableArray *)sectionHeadersArrayM {
    if (!_sectionHeadersArrayM) {
        _sectionHeadersArrayM = [NSMutableArray new];
    }
    return _sectionHeadersArrayM;
}
- (NSMutableArray *)sectionFootersArrayM {
    if (!_sectionFootersArrayM) {
        _sectionFootersArrayM = [NSMutableArray new];
    }
    return _sectionFootersArrayM;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLShopDetailsInfoCell reuseCellWithTableView:tableView IndexPath:indexPath];
}

#pragma mark - UITableViewDelegate
CGFloat const ZLShopDetailsViewSectionHeight = 50.0;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //报价
//    return 185.0;
    //案例
//    return 215.0;
    //评论、动态
//    return 370.0;//动态
    //档期、资料
    return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return ZLShopDetailsViewSectionHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ZLShopDetailsViewSectionHeight + 5.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ZLShopDetailsAreaFooterView * shopDetailsAreaFooterView = nil;
    if (section < self.sectionFootersArrayM.count) {
        shopDetailsAreaFooterView = self.sectionFootersArrayM[section];
    }
    if (!shopDetailsAreaFooterView) {
        shopDetailsAreaFooterView = [[ZLShopDetailsAreaFooterView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, ZLShopDetailsViewSectionHeight)];
        [self.sectionFootersArrayM addObject:shopDetailsAreaFooterView];
        shopDetailsAreaFooterView.sectionFootersClick = ^{//区尾的点击
            NSLog(@"------clickSection:%ld-------",section);
        };
    }
    shopDetailsAreaFooterView.title = @"更多报价 >";
    return shopDetailsAreaFooterView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZLShopDetailsAreaHeaderView * shopDetailsAreaHeaderView = nil;
    if (section < self.sectionHeadersArrayM.count) {
        shopDetailsAreaHeaderView = self.sectionHeadersArrayM[section];
    }
    if (!shopDetailsAreaHeaderView) {
        shopDetailsAreaHeaderView = [[ZLShopDetailsAreaHeaderView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, ZLShopDetailsViewSectionHeight)];
        [self.sectionHeadersArrayM addObject:shopDetailsAreaHeaderView];
    }
    shopDetailsAreaHeaderView.title = @"区头（22222）";
    return shopDetailsAreaHeaderView;
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
