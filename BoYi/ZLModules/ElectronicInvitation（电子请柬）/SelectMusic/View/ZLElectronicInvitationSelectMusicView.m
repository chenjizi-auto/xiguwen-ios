//
//  ZLElectronicInvitationSelectMusicView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationSelectMusicView.h"
#import "ZLElectronicInvitationSelectMusicCell.h"
#import "ZLElectronicInvitationSelectMusicStaticCell.h"
#import <MJRefresh.h>

@import AVFoundation;
@interface ZLElectronicInvitationSelectMusicView ()<UITableViewDataSource,UITableViewDelegate>

///滑动视图
@property (nonatomic,weak) UITableView *tableView;
///功能条
@property (nonatomic,weak) UIView *functionBar;
///跟踪条
@property (nonatomic,weak) UIView *traceBar;
///记录被点击的按钮
@property (nonatomic,weak) UIButton *lastButton;
///单元模型的个数（避免交替时发生数据混淆，在交替时会先赋值0）
@property (nonatomic,unsafe_unretained) NSInteger unitModelCount;
///被点击的单元格索引
@property (nonatomic,strong) NSIndexPath *lastIndexPath;
///播放器
@property (nonatomic,strong) AVPlayer *palyer;
///删除时的蒙版
@property (nonatomic,weak) UIView *hudView;
///错误提示
@property (nonatomic,weak) UILabel *errorLabel;

@end

@implementation ZLElectronicInvitationSelectMusicView

#pragma mark - Set
- (void)setInfoModel:(ZLElectronicInvitationSelectMusicModel *)infoModel {
    _infoModel = infoModel;
    [self changeView];
}
- (void)setErrorMessage:(NSString *)errorMessage {
    _errorMessage = errorMessage;
    [self showErrorMessage];
}
- (void)setShowHud:(BOOL)showHud {
    if (_showHud != showHud) {
        _showHud = showHud;
        if (showHud) {
            [self showSaveDataHudView];
        }else {
            if (self.hudView) {
                [self.hudView removeFromSuperview];
            }
        }
    }
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStylePlain)];
        tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        tableView.dataSource = self;
        tableView.delegate = self;
        //ios11 适配
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            tableView.scrollIndicatorInsets = tableView.contentInset;
        }
        __weak typeof(self)weakSelf = self;
        tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (weakSelf.loadData) {
                [weakSelf resetMusicPlayerCell];
                weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].showNoMore = NO;
                weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].page = 1;
                weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].loadMore = NO;
                weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].showStaticPage = NO;
                [weakSelf.tableView.mj_footer resetNoMoreData];
                weakSelf.loadData();
            }
        }];
        tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakSelf.loadData) {
                    weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].page += 1;
                    weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].loadMore = YES;
                    weakSelf.loadData();
                }
            });
        }];
        tableView.mj_footer.hidden = YES;
        tableView.showsVerticalScrollIndicator = NO;
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        [self addSubview:tableView];
        tableView.contentInset = UIEdgeInsetsMake(statusBarHeight + 44.0 + CGRectGetHeight(self.functionBar.frame), 0, statusBarHeight == 20.0 ? 0 : 24.0, 0);
        [tableView registerClass:[ZLElectronicInvitationSelectMusicCell class] forCellReuseIdentifier:@"ZLElectronicInvitationSelectMusicCell"];
        [tableView registerClass:[ZLElectronicInvitationSelectMusicStaticCell class] forCellReuseIdentifier:@"ZLElectronicInvitationSelectMusicStaticCell"];
        _tableView = tableView;
    }
    return _tableView;
}
- (UIView *)functionBar {
    if (!_functionBar) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        //夹层，用来做穿透效果
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, statusBarHeight + 44.0, self.frame.size.width, 45.0);
        [self addSubview:effectView];
        
        //夹层底部线
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, CGRectGetHeight(effectView.frame) - 0.5, CGRectGetWidth(effectView.frame), 0.5);
        layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        [effectView.contentView.layer addSublayer:layer];
        
        //滑动视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:effectView.bounds];
        scrollView.showsHorizontalScrollIndicator = NO;
        [effectView.contentView addSubview:scrollView];
        
        //承载子控件
        UIView *functionBar = [[UIView alloc] initWithFrame:CGRectZero];
        [scrollView addSubview:functionBar];
        _functionBar = functionBar;
        
        //子控件
        CGFloat width = 80.0;
        CGFloat height = CGRectGetHeight(scrollView.frame);
        CGFloat edgeSpace = 15.0;
        CGFloat maxCount = self.infoModel.sectionModels.count > 4 ? 4 : self.infoModel.sectionModels.count;
        CGFloat space = (CGRectGetWidth(self.frame) - edgeSpace * 2 - width * maxCount) / (maxCount + 1);
        for (NSInteger index = 0; index < _infoModel.sectionModels.count; index++) {
            UIButton *item = [[UIButton alloc] initWithFrame:CGRectMake(edgeSpace + space + (width + space) * index, 0, width, height)];
            item.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [item setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
            [item setTitleColor:[UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateSelected];
            [item setTitle:self.infoModel.sectionModels[index].title forState:UIControlStateNormal];
            [item addTarget:self action:@selector(functionBarAction:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = index + 1;
            [functionBar addSubview:item];
            if (!index) {
                item.selected = YES;
                self.traceBar.frame = CGRectMake(CGRectGetMinX(item.frame) + 20.0, CGRectGetHeight(scrollView.frame) - 3.0, CGRectGetWidth(item.frame) - 40.0, 3.0);
                self.lastButton = item;
            }
        }
        functionBar.frame = CGRectMake(0, 0, CGRectGetMaxX(functionBar.subviews.lastObject.frame) + space + edgeSpace, CGRectGetHeight(scrollView.frame));
        scrollView.contentSize = CGSizeMake(CGRectGetMaxX(functionBar.frame), CGRectGetHeight(scrollView.frame));
    }
    return _functionBar;
}
- (UIView *)traceBar {
    if (!_traceBar) {
        UIView *traceBar = [[UIView alloc] initWithFrame:CGRectZero];
        traceBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        [_functionBar addSubview:traceBar];
        _traceBar = traceBar;
    }
    return _traceBar;
}
- (UILabel *)errorLabel {
    if (!_errorLabel) {
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        errorLabel.textColor = UIColor.whiteColor;
        errorLabel.backgroundColor = UIColor.blackColor;
        errorLabel.textAlignment = NSTextAlignmentCenter;
        errorLabel.layer.cornerRadius = 3.0;
        errorLabel.layer.masksToBounds = YES;
        errorLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:errorLabel];
        _errorLabel = errorLabel;
    }
    return _errorLabel;
}

#pragma mark - Separate
- (void)resetMusicPlayerCell {
    ZLElectronicInvitationSelectMusicCell *lastCell = [self.tableView cellForRowAtIndexPath:self.lastIndexPath];
    lastCell.didSelected = NO;
    self.lastIndexPath = nil;
}
- (void)changeView {
    //展示静态加载数据前的界面(首次是静态赋值，不需要走到下面去)
    if (!self.infoModel.isStaticGiveValue) {
        self.infoModel.staticGiveValue = YES;
        if (self.infoModel.currenMusicModel) {
            self.palyer = nil;
            self.palyer = [AVPlayer playerWithURL:[NSURL URLWithString:self.infoModel.currenMusicModel.musicUrl]];
            [self.palyer play];
        }
        return;
    }
    //展示有数据界面
    [self changeState];
}
- (void)changeState {
    self.unitModelCount = self.infoModel.sectionModels[self.infoModel.currentSection].unitModels.count;
    self.tableView.mj_footer.hidden = (self.unitModelCount >= self.infoModel.sectionModels[self.infoModel.currentSection].count)
                                         ? NO
                                         : YES;
    if (self.infoModel.sectionModels[self.infoModel.currentSection].isAllowShowNoMore) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        if (!self.infoModel.sectionModels[self.infoModel.currentSection].isLoadMore) {
            [self.tableView.mj_header endRefreshing];
        }
    }else {
        if (!self.infoModel.sectionModels[self.infoModel.currentSection].isLoadMore) {
            [self.tableView.mj_header endRefreshing];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
    //刷新数据
    [self.tableView reloadData];
}
- (void)resetData {
    //处于空白数据，请求加载
    if (!self.infoModel.sectionModels[self.infoModel.currentSection].isDataDidArrive) {
        if (self.loadData) {
            self.infoModel.sectionModels[self.infoModel.currentSection].page = 1;
            self.infoModel.sectionModels[self.infoModel.currentSection].loadMore = NO;
            self.infoModel.sectionModels[self.infoModel.currentSection].showNoMore = NO;
            [self.tableView.mj_footer resetNoMoreData];
            self.loadData();
            return;
        }
    }
    //还原显示
    self.unitModelCount = self.infoModel.sectionModels[self.infoModel.currentSection].unitModels.count;
    self.tableView.mj_footer.hidden = (self.unitModelCount >= self.infoModel.sectionModels[self.infoModel.currentSection].count)
                                        ? NO
                                        : YES;
    //还原加载状态
    self.infoModel.sectionModels[self.infoModel.currentSection].isAllowShowNoMore
        ? [self.tableView.mj_footer endRefreshingWithNoMoreData]
        : [self.tableView.mj_footer resetNoMoreData];
    //刷新数据
    [self.tableView reloadData];
}
- (void)showSaveDataHudView {
    UIView *hudView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:hudView];
    self.hudView = hudView;
    UIView *alphaView = [[UIView alloc] initWithFrame:self.frame];
    alphaView.alpha = 0.2;
    alphaView.backgroundColor = UIColor.blackColor;
    [hudView addSubview:alphaView];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80.0, 80.0)];
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityIndicatorView.color = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
    [hudView addSubview:activityIndicatorView];
    activityIndicatorView.layer.cornerRadius = 5.0;
    activityIndicatorView.layer.masksToBounds = YES;
    activityIndicatorView.backgroundColor = UIColor.whiteColor;
    activityIndicatorView.center = hudView.center;
    [activityIndicatorView startAnimating];
}
- (void)showErrorMessage {
    [self.hudView removeFromSuperview];
    CGSize size = [self.errorMessage boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 50.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    CGFloat width = size.width + 20;
    CGFloat height = size.height + 20;
    CGFloat x = (UIScreen.mainScreen.bounds.size.width - width) * 0.5;
    CGFloat y = UIScreen.mainScreen.bounds.size.height - height - 20.0;
    self.errorLabel.frame = CGRectMake(x, y, width, height);
    self.errorLabel.text = self.errorMessage;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.errorLabel removeFromSuperview];
    });
}

#pragma mark - Action
- (void)functionBarAction:(UIButton *)sender {
    if (sender != self.lastButton) {
        [self resetMusicPlayerCell];
        self.infoModel.currentSection = sender.tag - 1;
        
        sender.selected = !sender.selected;
        self.lastButton.selected = !self.lastButton.selected;
        
        //先置空上次的数据
        self.unitModelCount = 0;
        [self.tableView reloadData];
        self.tableView.mj_footer.hidden = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.traceBar.frame = CGRectMake(CGRectGetMinX(sender.frame) + 20.0, CGRectGetHeight(self.functionBar.frame) - 3.0, CGRectGetWidth(sender.frame) - 40.0, 3.0);
        } completion:^(BOOL finished) {
            //再执行重置数据
            [self resetData];
        }];
        self.lastButton = sender;
    }
}

#pragma mark - UItableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return !self.infoModel.sectionModels[self.infoModel.currentSection].showStaticPage
        ? self.unitModelCount
        : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.infoModel.sectionModels[self.infoModel.currentSection].showStaticPage) {
        ZLElectronicInvitationSelectMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLElectronicInvitationSelectMusicCell" forIndexPath:indexPath];
        ZLElectronicInvitationSelectMusicModel *model = self.infoModel.sectionModels[self.infoModel.currentSection].unitModels[indexPath.row];
        //恢复单元格的选中状态
        if ([model.keyId integerValue] == [self.infoModel.currenMusicModel.keyId integerValue]) {
            cell.didSelected = YES;
            self.lastIndexPath = indexPath;
        }else {
            cell.didSelected = NO;
        }
        [cell.titleButton setTitle:model.title forState:UIControlStateNormal];
        return cell;
    }
    //静态界面单元格
    ZLElectronicInvitationSelectMusicStaticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLElectronicInvitationSelectMusicStaticCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UItableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    return !self.infoModel.sectionModels[self.infoModel.currentSection].showStaticPage
        ? 50.0
        : CGRectGetHeight(self.frame) - statusBarHeight - 44.0 - CGRectGetHeight(self.functionBar.frame);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.infoModel.sectionModels[self.infoModel.currentSection].showStaticPage) {
        return;
    }
    if (indexPath != self.lastIndexPath) {
        ZLElectronicInvitationSelectMusicModel *model = self.infoModel.sectionModels[self.infoModel.currentSection].unitModels[indexPath.row];
        ZLElectronicInvitationSelectMusicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.palyer = nil;
        self.palyer = [AVPlayer playerWithURL:[NSURL URLWithString:model.musicUrl]];
        [self.palyer play];
        cell.didSelected = YES;
        self.infoModel.currenMusicModel = model;
        ZLElectronicInvitationSelectMusicCell *lastCell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
        lastCell.didSelected = NO;
        self.lastIndexPath = indexPath;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
