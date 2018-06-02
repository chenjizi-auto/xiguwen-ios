//
//  ZLIntegralShopHomeView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
// 

#import "ZLIntegralShopHomeView.h"
#import "ZLIntegralShopHomeNavBgView.h"
#import "ZLIntegralShopHomeTableHeaderView.h"
#import "ZLIntegralShopHomeAreaHeadView.h"
#import "ZLIntegralShopHomeGoodsCell.h"
#import "ZLIntegralShopHomeSignView.h"

@interface ZLIntegralShopHomeView ()<UITableViewDelegate,UITableViewDataSource,ZLIntegralShopHomeGoodsCellDelgate>

//滑动视图
@property (nonatomic,weak) UITableView *tableView;
//渐变导航背景
@property (nonatomic,weak) ZLIntegralShopHomeNavBgView *integralShopHomeNavBgView;
//滑动视图头部
@property (nonatomic,strong) ZLIntegralShopHomeTableHeaderView *integralShopHomeTableHeaderView;
//区头（复用）
@property (nonatomic,strong) NSMutableArray *sectionHeadersArrayM;
///签到层
@property (nonatomic,weak) ZLIntegralShopHomeSignView *signView;

@end

@implementation ZLIntegralShopHomeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - Set
- (void)setSignModel:(ZLIntegralShopHomeModel *)signModel {
    _signModel = signModel;
    if (signModel) {
        self.signView.signModel = signModel;
        [self updateInterface];
    }
}
- (void)setShopHomeModel:(ZLIntegralShopHomeModel *)shopHomeModel {
    _shopHomeModel = shopHomeModel;
    [self giveValues];
    [self.tableView reloadData];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [self addSubviews];
        [self integralShopHomeNavBgView];
    }
    return _tableView;
}
- (NSMutableArray *)sectionHeadersArrayM {
    if (!_sectionHeadersArrayM) {
        _sectionHeadersArrayM = [NSMutableArray new];
    }
    return _sectionHeadersArrayM;
}
- (ZLIntegralShopHomeNavBgView *)integralShopHomeNavBgView {//处理导航栏的渐变
    if (!_integralShopHomeNavBgView) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        ZLIntegralShopHomeNavBgView *integralShopHomeNavBgView = [[ZLIntegralShopHomeNavBgView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, statusBarHeight + 44.0)];
        integralShopHomeNavBgView.title = @"积分商城";
        [self addSubview:integralShopHomeNavBgView];
        _integralShopHomeNavBgView = integralShopHomeNavBgView;
    }
    return _integralShopHomeNavBgView;
}
- (ZLIntegralShopHomeTableHeaderView *)integralShopHomeTableHeaderView {
    if (!_integralShopHomeTableHeaderView) {
        ZLIntegralShopHomeTableHeaderView *integralShopHomeTableHeaderView = [[ZLIntegralShopHomeTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 436.0)];
        __weak typeof(self)weakSelf = self;
        integralShopHomeTableHeaderView.function = ^(BOOL isIntegral) {
            if (weakSelf.function) {
                weakSelf.function(isIntegral);
            }
        };
        integralShopHomeTableHeaderView.sign = ^{
            if (!weakSelf.signModel.signState) {
                if (weakSelf.sign) {
                    weakSelf.sign();
                }
            }
        };
        integralShopHomeTableHeaderView.bannerClick = ^(NSInteger index) {
            if (weakSelf.bannerClick) {
                ZLIntegralShopHomeModel *model = weakSelf.shopHomeModel.bannerModelsArray[index];
                weakSelf.bannerClick(model);
            }
        };
        _integralShopHomeTableHeaderView = integralShopHomeTableHeaderView;
    }
    return _integralShopHomeTableHeaderView;
}
- (ZLIntegralShopHomeSignView *)signView {
    if (!_signView) {
        ZLIntegralShopHomeSignView *signView = [[ZLIntegralShopHomeSignView alloc] initWithFrame:self.bounds];
        __weak typeof(self)weakSelf = self;
        signView.updateInterface = ^{
            //修改数据
            NSInteger currentTotalIntegral = [weakSelf.shopHomeModel.currentTotalIntegral integerValue] + [weakSelf.signModel.todayObtainIntegralNumber integerValue];
            weakSelf.shopHomeModel.currentTotalIntegral = [NSString stringWithFormat:@"%ld",currentTotalIntegral];
            //更新界面
            [weakSelf.integralShopHomeTableHeaderView showAnimationLabelWithTodayObtainIntegralNumber:weakSelf.signModel.todayObtainIntegralNumber];
        };
        [self addSubview:signView];
        _signView = signView;
    }
    return _signView;
}

#pragma mark - Add
- (UITableView *)addSubviews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    //ios11 适配
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
    }
    tableView.tableHeaderView = self.integralShopHomeTableHeaderView;
    tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:tableView];
    return tableView;
}

#pragma mark - Separate
- (void)changeTextColorWithAlpha:(CGFloat)alpha {
    static BOOL isDown;
    static BOOL isUp;
    if (!isDown) {
        if (alpha < 1.0) {
            isUp = NO;
            if (self.changeNavItemColor) {
                self.changeNavItemColor(alpha);
            }
            isDown = YES;
        }
    }
    if (!isUp) {
        if (alpha >= 1.0) {
            isDown = NO;
            if (self.changeNavItemColor) {
                self.changeNavItemColor(alpha);
            }
            isUp = YES;
        }
    }
}
- (void)giveValues {
    if (self.shopHomeModel.ongoingSignDayNumber) {//打开交互
        self.integralShopHomeTableHeaderView.allowInteraction = YES;
        self.integralShopHomeTableHeaderView.signState = self.shopHomeModel.signState;
        self.integralShopHomeTableHeaderView.title = self.shopHomeModel.ongoingSignDayNumber;
        self.integralShopHomeTableHeaderView.bannerUrlsArray = self.shopHomeModel.bannerUrlsArray;
        self.integralShopHomeTableHeaderView.numbersArray = @[self.shopHomeModel.currentTotalIntegral,self.shopHomeModel.currentConversionTotalNumber];
    }
}
- (void)updateInterface {
    self.integralShopHomeTableHeaderView.signState = YES;
    self.shopHomeModel.ongoingSignDayNumber = [NSString stringWithFormat:@"已连续签到%@天",self.signModel.ongoingSignDayNumber];
    self.integralShopHomeTableHeaderView.title = self.shopHomeModel.ongoingSignDayNumber;
}

#pragma mark - Public
- (void)removeTimer {
    [self.integralShopHomeTableHeaderView removeTimer];
}
- (void)startTimer {
    [self.integralShopHomeTableHeaderView startTimer];
}
- (void)stopTimer {
    [self.integralShopHomeTableHeaderView stopTimer];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shopHomeModel.unitModels.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZLIntegralShopHomeModel *model = self.shopHomeModel.unitModels[section];
    return ceil(model.unitModels.count / 2.0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLIntegralShopHomeGoodsCell reuseCellWithTableView:tableView IndexPath:indexPath Delegate:self Model:self.shopHomeModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 225.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZLIntegralShopHomeAreaHeadView * integralShopHomeAreaHeadView = nil;
    if (section < self.sectionHeadersArrayM.count) {
        integralShopHomeAreaHeadView = self.sectionHeadersArrayM[section];
    }
    if (!integralShopHomeAreaHeadView) {
        integralShopHomeAreaHeadView = [[ZLIntegralShopHomeAreaHeadView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 70.0)];
        integralShopHomeAreaHeadView.subTitle = @"查看全部 >";
        [self.sectionHeadersArrayM addObject:integralShopHomeAreaHeadView];
        //查看全部
        __weak typeof(self)weakSelf = self;
        integralShopHomeAreaHeadView.lookAll = ^() {
            if (weakSelf.lookAll) {
                weakSelf.lookAll(section);
            }
        };
    }
    ZLIntegralShopHomeModel *model = self.shopHomeModel.unitModels[section];
    integralShopHomeAreaHeadView.title = model.sectionTitle;
    return integralShopHomeAreaHeadView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //在xx高度内发生渐变
    float alphaHeight = 64.0;
    //进行渐变
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat alpha = (offSetY <= 0) ? 0 : offSetY / alphaHeight;
    alpha = alpha > 1.0 ? 1.0 : alpha;
    //改变字体颜色
    [self changeTextColorWithAlpha:alpha];
    self.integralShopHomeNavBgView.alpha = alpha;
    //图片缩放
    [self.integralShopHomeTableHeaderView imageZoomWithOffsetY:offSetY];
}

#pragma mark - ZLIntegralShopHomeGoodsCellDelgate
- (void)lookDetailWithModel:(ZLIntegralShopHomeModel *)model {
    if (self.lookDetail) {
        self.lookDetail(model);
    }
}

@end
