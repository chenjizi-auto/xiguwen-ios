//
//  ZLSelectBankCardView.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/30.
//  Copyright © 2018年   . All rights reserved.
//

#import "ZLSelectBankCardView.h"
#import "ZLSelectBankCardCell.h"
#import <MJRefresh.h>
#import "ZLStaticPage.h"
#import <UIButton+AFNetworking.h>

@interface ZLSelectBankCardView ()<UITableViewDelegate,UITableViewDataSource>

///滑动视图
@property (nonatomic,weak) UITableView *tableView;
///静态页
@property (nonatomic,strong) ZLStaticPage *staticPage;
///工具条
@property (nonatomic,weak) UIView *functionBar;

@end

@implementation ZLSelectBankCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLSelectBankCardModel *)infoModel {
    _infoModel = infoModel;
    [self registerAction];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 75.0;
        tableView.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0];
        tableView.contentInset = UIEdgeInsetsMake(UIApplication.sharedApplication.statusBarFrame.size.height + 44.0, 0, 0, 0);
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = NO;
        
        __weak typeof(self)weakSelf = self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (weakSelf.infoModel.load) {
                weakSelf.infoModel.noMore = NO;
                weakSelf.infoModel.page = 1;
                weakSelf.infoModel.loadMore = NO;
                weakSelf.infoModel.load();
            }
        }];
        tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (weakSelf.infoModel.load) {
                weakSelf.infoModel.page += 1;
                weakSelf.infoModel.loadMore = YES;
                weakSelf.infoModel.load();
            }
        }];
        tableView.mj_footer.hidden = YES;
        
        //ios11 适配
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            tableView.scrollIndicatorInsets = tableView.contentInset;
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
        }
        
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (ZLStaticPage *)staticPage {
    if (!_staticPage) {
        _staticPage = [[ZLStaticPage alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - self.tableView.contentInset.top - self.functionBar.frame.size.height)];
        _staticPage.topInset = 100.0;
        _staticPage.iconName = @"暂无数据";
        _staticPage.title = [[NSMutableAttributedString alloc] initWithString:@"暂无相关数据哦~"];
    }
    return _staticPage;
}

#pragma mark - Action
- (void)registerAction {
    __weak typeof(self)weakSelf = self;
    self.infoModel.results = ^{//展示数据
        if (weakSelf.infoModel.unitModels.count) {
            weakSelf.tableView.tableFooterView = nil;
        }else {
            weakSelf.tableView.tableFooterView = weakSelf.staticPage;
        }
        [weakSelf.tableView reloadData];
        if (weakSelf.infoModel.unitModels.count && weakSelf.infoModel.unitModels.count >= weakSelf.infoModel.size) {
            weakSelf.tableView.mj_footer.hidden = NO;
        }else {
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        if (!weakSelf.infoModel.loadMore) {
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer resetNoMoreData];
        }else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        if (weakSelf.infoModel.noMore) {
            weakSelf.tableView.mj_footer.hidden = YES;
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    };
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoModel.unitModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLSelectBankCardCell *cell =  [ZLSelectBankCardCell reuseCell:tableView IndexPath:indexPath];
    ZLSelectBankCardModel *unitModel = self.infoModel.unitModels[indexPath.row];
    [cell.iconButton setImage:[UIImage imageNamed:@"支付宝支付"] forState:UIControlStateNormal];
    cell.titleLabel.text = unitModel.keyTitle;
    cell.subTitleLabel.text = unitModel.subTitle;
    if ([self.infoModel.keyId isEqualToString:unitModel.keyId]) {
        [cell.markButton setImage:[UIImage imageNamed:@"勾选地区"] forState:UIControlStateNormal];
    }
    if (indexPath.row != self.infoModel.unitModels.count) {
        cell.bottomLine.hidden = NO;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    ZLSelectBankCardModel *unitModel = self.infoModel.unitModels[indexPath.row];
    if (![self.infoModel.keyId isEqualToString:unitModel.keyId]) {
        if (self.infoModel.action) {
            self.infoModel.keyId = unitModel.keyId;
            self.infoModel.action(unitModel);
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self)weakSelf = self;
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPaths) {
        ZLSelectBankCardModel *unitModel = weakSelf.infoModel.unitModels[indexPaths.row];
        if (unitModel.deleteBankCard) {
            unitModel.deleteBankCardResults = ^{
                ZLSelectBankCardModel *currentModel = weakSelf.infoModel.unitModels[indexPaths.row];
                if ([weakSelf.infoModel.keyId isEqualToString:currentModel.keyId]) {
                    weakSelf.infoModel.keyId = nil;
                }
                [weakSelf.infoModel.unitModels removeObject:currentModel];
                [weakSelf.tableView reloadData];
            };
            unitModel.deleteBankCard();
        }
        tableView.editing = NO;
    }];
    action1.backgroundColor = [UIColor colorWithRed:1.0 green:55 / 255.0 blue:55 / 255.0 alpha:1.0];
    return @[action1];
}

@end
