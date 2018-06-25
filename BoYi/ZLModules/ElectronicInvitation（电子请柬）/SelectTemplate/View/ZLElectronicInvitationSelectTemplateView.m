//
//  ZLElectronicInvitationSelectTemplateView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationSelectTemplateView.h"
#import "ZLElectronicInvitationSelectTemplateCell.h"
#import "ZLElectronicInvitationEmptyTemplateStaticCell.h"
#import <UIButton+AFNetworking.h>
#import <MJRefresh.h>

@interface ZLElectronicInvitationSelectTemplateView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

///滑动视图
@property (nonatomic,weak) UICollectionView *collectionView;
///功能条
@property (nonatomic,weak) UIView *functionBar;
///跟踪条
@property (nonatomic,weak) UIView *traceBar;
///记录被点击的按钮
@property (nonatomic,weak) UIButton *lastButton;
///单元模型的个数（避免交替时发生数据混淆，在交替时会先赋值0）
@property (nonatomic,unsafe_unretained) NSInteger unitModelCount;

@end

@implementation ZLElectronicInvitationSelectTemplateView

#pragma mark - Set
- (void)setInfoModel:(ZLElectronicInvitationSelectTemplateModel *)infoModel {
    _infoModel = infoModel;
    [self changeView];
}

#pragma mark - Lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat contentSpacing = 7.0;
        CGFloat edgeSpacing = 8.0;
        layout.minimumInteritemSpacing = contentSpacing;
        layout.minimumLineSpacing = contentSpacing * 2;
        layout.sectionInset = UIEdgeInsetsMake(edgeSpacing, edgeSpacing, edgeSpacing, edgeSpacing);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        //ios11 适配
        if (@available(iOS 11.0, *)) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            collectionView.scrollIndicatorInsets = collectionView.contentInset;
        }
        __weak typeof(self)weakSelf = self;
        collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (weakSelf.loadData) {
                weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].showNoMore = NO;
                weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].page = 1;
                weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].loadMore = NO;
                weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].showStaticPage = NO;
                [weakSelf.collectionView.mj_footer resetNoMoreData];
                weakSelf.loadData();
            }
        }];
        collectionView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakSelf.loadData) {
                    weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].page += 1;
                    weakSelf.infoModel.sectionModels[weakSelf.infoModel.currentSection].loadMore = YES;
                    weakSelf.loadData();
                }
            });
        }];
        collectionView.mj_footer.hidden = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        [self addSubview:collectionView];
        collectionView.contentInset = UIEdgeInsetsMake(statusBarHeight + 44.0 + CGRectGetHeight(self.functionBar.frame), 0, statusBarHeight == 20.0 ? 0 : 14.0, 0);
        [collectionView registerClass:[ZLElectronicInvitationSelectTemplateCell class] forCellWithReuseIdentifier:@"ZLElectronicInvitationSelectTemplateCell"];
        [collectionView registerClass:[ZLElectronicInvitationEmptyTemplateStaticCell class] forCellWithReuseIdentifier:@"ZLElectronicInvitationEmptyTemplateStaticCell"];
        _collectionView = collectionView;
    }
    return _collectionView;
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

#pragma mark - Separate
- (void)changeView {
    //展示静态加载数据前的界面(首次是静态赋值，不需要走到下面去)
    if (!self.infoModel.isStaticGiveValue) {
        self.infoModel.staticGiveValue = YES;
        return;
    }
    //展示有数据界面
    [self changeState];
}
- (void)changeState {
    self.unitModelCount = self.infoModel.sectionModels[self.infoModel.currentSection].unitModels.count;
    self.collectionView.mj_footer.hidden = (self.unitModelCount >= self.infoModel.sectionModels[self.infoModel.currentSection].count)
                                         ? NO
                                         : YES;
    if (self.infoModel.sectionModels[self.infoModel.currentSection].isAllowShowNoMore) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        if (!self.infoModel.sectionModels[self.infoModel.currentSection].isLoadMore) {
            [self.collectionView.mj_header endRefreshing];
        }
    }else {
        if (!self.infoModel.sectionModels[self.infoModel.currentSection].isLoadMore) {
            [self.collectionView.mj_header endRefreshing];
        }else {
            [self.collectionView.mj_footer endRefreshing];
        }
    }
    //刷新数据
    [self.collectionView reloadData];
}
- (void)resetData {
    //处于空白数据，请求加载
    if (!self.infoModel.sectionModels[self.infoModel.currentSection].isDataDidArrive) {
        if (self.loadData) {
            self.infoModel.sectionModels[self.infoModel.currentSection].page = 1;
            self.infoModel.sectionModels[self.infoModel.currentSection].loadMore = NO;
            self.infoModel.sectionModels[self.infoModel.currentSection].showNoMore = NO;
            [self.collectionView.mj_footer resetNoMoreData];
            self.loadData();
            return;
        }
    }
    //还原显示
    self.unitModelCount = self.infoModel.sectionModels[self.infoModel.currentSection].unitModels.count;
    self.collectionView.mj_footer.hidden = (self.unitModelCount >= self.infoModel.sectionModels[self.infoModel.currentSection].count)
                                         ? NO
                                         : YES;
    //还原加载状态
    self.infoModel.sectionModels[self.infoModel.currentSection].isAllowShowNoMore
        ? [self.collectionView.mj_footer endRefreshingWithNoMoreData]
        : [self.collectionView.mj_footer resetNoMoreData];
    //刷新数据
    [self.collectionView reloadData];
}

#pragma mark - Action
- (void)functionBarAction:(UIButton *)sender {
    if (sender != self.lastButton) {
        
        self.infoModel.currentSection = sender.tag - 1;
        
        sender.selected = !sender.selected;
        self.lastButton.selected = !self.lastButton.selected;
        
        //先置空上次的数据
        self.unitModelCount = 0;
        [self.collectionView reloadData];
        self.collectionView.mj_footer.hidden = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.traceBar.frame = CGRectMake(CGRectGetMinX(sender.frame) + 20.0, CGRectGetHeight(self.functionBar.frame) - 3.0, CGRectGetWidth(sender.frame) - 40.0, 3.0);
        } completion:^(BOOL finished) {
            //再执行重置数据
            [self resetData];
        }];
        self.lastButton = sender;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return !self.infoModel.sectionModels[self.infoModel.currentSection].showStaticPage
            ? self.unitModelCount
            : 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.infoModel.sectionModels[self.infoModel.currentSection].showStaticPage) {
        ZLElectronicInvitationSelectTemplateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLElectronicInvitationSelectTemplateCell" forIndexPath:indexPath];
        ZLElectronicInvitationSelectTemplateModel *model = self.infoModel.sectionModels[self.infoModel.currentSection].unitModels[indexPath.row];
        [cell.iconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"rectangle_vertical_placeholder"]];
        cell.titleLabel.text = model.title;
        return cell;
    }
    //静态界面单元格
    ZLElectronicInvitationEmptyTemplateStaticCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLElectronicInvitationEmptyTemplateStaticCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat contentSpacing = 7.0;
    CGFloat edgeSpacing = 8.0;
    CGFloat width = (self.frame.size.width - edgeSpacing * 2 - contentSpacing * 2) / 3;
    CGFloat height = width / 0.63;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    return !self.infoModel.sectionModels[self.infoModel.currentSection].showStaticPage
        ? CGSizeMake(width, height)
        : CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - statusBarHeight - 44.0 - CGRectGetHeight(self.functionBar.frame));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.infoModel.sectionModels[self.infoModel.currentSection].showStaticPage) {
        return;
    }
    if (self.lookDetail) {
        self.lookDetail(self.infoModel.sectionModels[self.infoModel.currentSection].unitModels[indexPath.row]);
    }
}

@end
