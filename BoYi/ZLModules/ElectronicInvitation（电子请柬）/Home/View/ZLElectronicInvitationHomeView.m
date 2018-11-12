//
//  ZLElectronicInvitationHomeView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/5.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationHomeView.h"
#import "ZLElectronicInvitationHomeCell.h"
#import <UIButton+AFNetworking.h>
#import <MJRefresh.h>
#import "ZLElectronicInvitationHomeStaticPage.h"

@interface ZLElectronicInvitationHomeView ()<UICollectionViewDataSource,UICollectionViewDelegate>

///滑动视图
@property (nonatomic,weak) UICollectionView *collectionView;
///创建我的请柬
@property (nonatomic,weak) UIButton *createMyInvitationButton;
///静态界面
@property (nonatomic,weak) ZLElectronicInvitationHomeStaticPage *staticPage;

@end

@implementation ZLElectronicInvitationHomeView

#pragma mark - Set
- (void)setInfoModel:(ZLElectronicInvitationHomeModel *)infoModel {
    _infoModel = infoModel;
    [self changeView];
    [self bringSubviewToFront:self.createMyInvitationButton];
}

#pragma mark - Lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat contentSpacing = 8.0;
        CGFloat edgeSpacing = 15.0;
        CGFloat width = (self.frame.size.width - edgeSpacing * 2 - contentSpacing) * 0.5;
        CGFloat height = width / (375 / 667.0);
        layout.itemSize = CGSizeMake(width, height);
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
            weakSelf.infoModel.showNoMore = NO;
            [weakSelf.collectionView.mj_footer resetNoMoreData];
            if (weakSelf.loadData) {
                weakSelf.infoModel.page = 1;
                weakSelf.infoModel.loadMore = NO;
                weakSelf.loadData();
            }
        }];
        collectionView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakSelf.loadData) {
                    weakSelf.infoModel.page += 1;
                    weakSelf.infoModel.loadMore = YES;
                    weakSelf.loadData();
                }
            });
        }];
        collectionView.mj_footer.hidden = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        collectionView.contentInset = UIEdgeInsetsMake(statusBarHeight + 44.0, 0, statusBarHeight == 20.0 ? 0 : 14.0, 0);
        [self addSubview:collectionView];
        [collectionView registerClass:[ZLElectronicInvitationHomeCell class] forCellWithReuseIdentifier:@"ZLElectronicInvitationHomeCell"];
        _collectionView = collectionView;
    }
    return _collectionView;
}
- (UIButton *)createMyInvitationButton {
    if (!_createMyInvitationButton) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat safetyAreaHeight = statusBarHeight == 20.0 ? 0 : 14.0;
        CGFloat width = 150.0;
        CGFloat height = 45.0;
        CGFloat bottomSpacing = 40.0;
        bottomSpacing = statusBarHeight == 20.0 ? height + bottomSpacing : height + bottomSpacing * 0.5 + safetyAreaHeight;
        CGFloat y = self.frame.size.height - bottomSpacing;
        UIButton *createMyInvitationButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - width) * 0.5, y, width, height)];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"create_my_invitation.png"];
        [createMyInvitationButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [createMyInvitationButton addTarget:self action:@selector(createMyInvitationButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:createMyInvitationButton];
        _createMyInvitationButton = createMyInvitationButton;
    }
    return _createMyInvitationButton;
}

#pragma mark - Separate
- (void)showStaticPage {
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    ZLElectronicInvitationHomeStaticPage *staticPage = [[ZLElectronicInvitationHomeStaticPage alloc] initWithFrame:CGRectMake(0, statusBarHeight + 44.0, self.frame.size.width, self.frame.size.height - statusBarHeight - 44.0)];
    [self addSubview:staticPage];
    self.staticPage = staticPage;
    self.createMyInvitationButton.hidden = NO;
}
- (void)changeView {
    //展示静态加载数据前的界面
    if (!self.infoModel.isDataDidArrive) {
        return;
    }
    //展示空数据界面
    if (!self.infoModel.unitModels.count) {
        if (!self.staticPage) {
            [self.collectionView removeFromSuperview];
            [self showStaticPage];
        }
        return;
    }
    //展示有数据界面
    [self changeState];
    if (self.staticPage) {
        [self.staticPage removeFromSuperview];
    }
}
- (void)changeState {
    self.collectionView.mj_footer.hidden = (self.infoModel.unitModels.count >= self.infoModel.count)
                                    ? NO
                                    : YES;
    if (self.infoModel.isAllowShowNoMore) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        if (!self.infoModel.isLoadMore) {
            [self.collectionView.mj_header endRefreshing];
        }
    }else {
        if (!self.infoModel.isLoadMore) {
            [self.collectionView.mj_header endRefreshing];
        }else {
            [self.collectionView.mj_footer endRefreshing];
        }
    }
    self.createMyInvitationButton.hidden = NO;
    [self.collectionView reloadData];
}

#pragma mark - Action
- (void)createMyInvitationButtonAction {
    if (self.createMyInvitation) {
        self.createMyInvitation();
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.infoModel.unitModels.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZLElectronicInvitationHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLElectronicInvitationHomeCell" forIndexPath:indexPath];
    ZLElectronicInvitationHomeModel *model = self.infoModel.unitModels[indexPath.row];
    [cell.iconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"rectangle_vertical_placeholder"]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.lookDetail) {
        self.lookDetail(self.infoModel.unitModels[indexPath.row]);
    }
}

@end
