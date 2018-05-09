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

@interface ZLShopDetailsView ()<UITableViewDataSource,UITableViewDelegate>

//滑动视图
@property (nonatomic,weak) UITableView *tableView;
//渐变导航背景
@property (nonatomic,weak) ZLShopDetailsNavBgView *shopDetailsNavBgView;
//
@property (nonatomic,weak) ZLShopDetailsHeaderView *shopDetailsHeaderView;

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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
//    cell.contentView.backgroundColor = ZL_ARC4RANDOM_COLOR;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 40.0)];
    view.backgroundColor = UIColor.lightGrayColor;
    return view;
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
