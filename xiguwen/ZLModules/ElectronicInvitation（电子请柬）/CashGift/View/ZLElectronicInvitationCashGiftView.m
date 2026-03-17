//
//  ZLElectronicInvitationCashGiftView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/12.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationCashGiftView.h"
#import "ZLElectronicInvitationCashGiftCell.h"
#import "ZLElectronicInvitationCashGiftStaticCell.h"
#import "ZLElectronicInvitationCashGiftSectionHeader.h"
#import "ZLElectronicInvitationCashGiftTableHeader.h"
#import <MJRefresh.h>

@interface ZLElectronicInvitationCashGiftView ()<UITableViewDataSource,UITableViewDelegate>

///滑动视图
@property (nonatomic,weak) UITableView *tableView;
///区头
@property (nonatomic,strong) ZLElectronicInvitationCashGiftTableHeader *tableHeader;
///区头复用
@property (nonatomic,strong) NSMutableArray *sectionHeadersM;
///展示加载动画
@property (nonatomic,unsafe_unretained) BOOL showAnimation;

@end

@implementation ZLElectronicInvitationCashGiftView

#pragma mark - Set
- (void)setInfoModel:(ZLElectronicInvitationCashGiftModel *)infoModel {
    _infoModel = infoModel;
    [self changeState];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStyleGrouped)];
        tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableHeaderView = self.tableHeader;
        //ios11 适配
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            tableView.scrollIndicatorInsets = tableView.contentInset;
        }
        __weak typeof(self)weakSelf = self;
        tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (weakSelf.loadData) {
                weakSelf.infoModel.showNoMore = NO;
                weakSelf.infoModel.page = 1;
                weakSelf.infoModel.loadMore = NO;
                if (weakSelf.sectionHeadersM.count) {
                    ((ZLElectronicInvitationCashGiftSectionHeader *)weakSelf.sectionHeadersM[0]).showAnimation = YES;
                }
                [weakSelf.tableView.mj_footer resetNoMoreData];
                weakSelf.loadData();
            }
        }];
        tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakSelf.loadData) {
                    weakSelf.infoModel.page += 1;
                    weakSelf.infoModel.loadMore = YES;
                    weakSelf.loadData();
                }
            });
        }];
        tableView.mj_footer.hidden = YES;
        tableView.showsVerticalScrollIndicator = NO;
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, statusBarHeight == 20.0 ? 0 : 24.0, 0);
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (ZLElectronicInvitationCashGiftTableHeader *)tableHeader {
    if (!_tableHeader) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        ZLElectronicInvitationCashGiftTableHeader *tableHeader = [[ZLElectronicInvitationCashGiftTableHeader alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 165.0 + statusBarHeight)];
        _tableHeader = tableHeader;
        [tableHeader amountLabel];
    }
    return _tableHeader;
}
- (NSMutableArray *)sectionHeadersM {
    if (!_sectionHeadersM) {
        _sectionHeadersM = [NSMutableArray new];
    }
    return _sectionHeadersM;
}

#pragma mark - Separate
- (void)changeState {
    self.tableHeader.amountLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.amount];
    self.tableView.mj_footer.hidden = (self.infoModel.unitModels.count >= self.infoModel.count)
                                    ? NO
                                    : YES;
    if (self.infoModel.isAllowShowNoMore) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        if (!self.infoModel.isLoadMore) {
            [self.tableView.mj_header endRefreshing];
            if (self.sectionHeadersM.count) {
                ((ZLElectronicInvitationCashGiftSectionHeader *)self.sectionHeadersM[0]).showAnimation = NO;
            }
        }
    }else {
        if (!self.infoModel.isLoadMore) {
            [self.tableView.mj_header endRefreshing];
            if (self.sectionHeadersM.count) {
                ((ZLElectronicInvitationCashGiftSectionHeader *)self.sectionHeadersM[0]).showAnimation = NO;
            }
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - UItableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoModel.isAllowShowStaticPage ? 1 : self.infoModel.unitModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.infoModel.isAllowShowStaticPage) {
        ZLElectronicInvitationCashGiftStaticCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLElectronicInvitationCashGiftStaticCell class])];
        if (!cell) {
            cell = [[ZLElectronicInvitationCashGiftStaticCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLElectronicInvitationCashGiftStaticCell class])];
            cell.selectionStyle = NO;
        }
        return cell;
    }
    ZLElectronicInvitationCashGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLElectronicInvitationCashGiftCell class])];
    if (!cell) {
        cell = [[ZLElectronicInvitationCashGiftCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLElectronicInvitationCashGiftCell class])];
        cell.selectionStyle = NO;
    }
    ZLElectronicInvitationCashGiftModel *model = self.infoModel.unitModels[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.timeLabel.text = model.time;
    cell.amountLabel.text = [NSString stringWithFormat:@"+%@",model.amount];
    return cell;
}

#pragma mark - UItableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = UIScreen.mainScreen.bounds.size.height - CGRectGetHeight(self.tableHeader.frame) - 58.0;
    return self.infoModel.isAllowShowStaticPage ? height : 70.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZLElectronicInvitationCashGiftSectionHeader *sectionHeader = nil;
    if (section < self.sectionHeadersM.count) {
        sectionHeader = self.sectionHeadersM[section];
    }
    if (!sectionHeader) {
        sectionHeader = [[ZLElectronicInvitationCashGiftSectionHeader alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 58.0)];
        [self.sectionHeadersM addObject:sectionHeader];
    }
    sectionHeader.title = @"礼金流水";
    return sectionHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 58.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //在xx高度内发生渐变
    float alphaHeight = 64.0;
    //进行渐变
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat alpha = (offSetY <= 0) ? 0 : offSetY / alphaHeight;
    alpha = alpha > 1.0 ? 1.0 : alpha;
    //图片缩放
    [self.tableHeader imageZoomWithOffsetY:offSetY];
}

@end
