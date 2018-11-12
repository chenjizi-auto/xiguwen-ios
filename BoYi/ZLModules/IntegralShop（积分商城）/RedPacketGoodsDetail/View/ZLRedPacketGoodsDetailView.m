//
//  ZLRedPacketGoodsDetailView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLRedPacketGoodsDetailView.h"
#import "ZLRedPacketGoodsDetailNavBgView.h"
#import "ZLRedPacketGoodsDetailCell.h"
#import "ZLRedPacketGoodsDetailGuessYouLikeCell.h"

@interface ZLRedPacketGoodsDetailView ()<UITableViewDelegate,UITableViewDataSource,ZLRedPacketGoodsDetailGuessYouLikeCellDelgate>

///
@property (nonatomic,weak) UITableView *tableView;
//渐变导航背景
@property (nonatomic,weak) ZLRedPacketGoodsDetailNavBgView *redPacketGoodsDetailNavBgView;
///功能条
@property (nonatomic,weak) UIButton *functionBar;
//区头（复用）
@property (nonatomic,strong) NSMutableArray *sectionHeadersArrayM;
///错误提示
@property (nonatomic,weak) UILabel *errorLabel;

@end

@implementation ZLRedPacketGoodsDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLRedPacketGoodsDetailModel *)infoModel {
    _infoModel = infoModel;
    [self.tableView reloadData];
}
- (void)setErrorMessage:(NSString *)errorMessage {
    _errorMessage = errorMessage;
    [self showErrorMessage];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [self addSubviews];
        [self functionBar];
    }
    return _tableView;
}
- (ZLRedPacketGoodsDetailNavBgView *)redPacketGoodsDetailNavBgView {//处理导航栏的渐变
    if (!_redPacketGoodsDetailNavBgView) {
        ZLRedPacketGoodsDetailNavBgView *redPacketGoodsDetailNavBgView = [[ZLRedPacketGoodsDetailNavBgView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 64.0)];
        redPacketGoodsDetailNavBgView.title = @"红包详情";
        [self addSubview:redPacketGoodsDetailNavBgView];
        _redPacketGoodsDetailNavBgView = redPacketGoodsDetailNavBgView;
    }
    return _redPacketGoodsDetailNavBgView;
}
- (UIButton *)functionBar {
    if (!_functionBar) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat safetyAreaHeight = statusBarHeight == 20.0 ? 0 : 24.0;
        //夹层，用来弥补iPhoneX的底部安全域
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 50.0 - safetyAreaHeight, UIScreen.mainScreen.bounds.size.width, 50.0 + safetyAreaHeight);
        [self addSubview:effectView];
        
        UIButton *functionBar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        functionBar.backgroundColor = [UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0];
        [functionBar setTitle:@"马上兑换" forState:UIControlStateNormal];
        [functionBar addTarget:self action:@selector(functionBarAction) forControlEvents:UIControlEventTouchUpInside];
        functionBar.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [effectView.contentView addSubview:functionBar];
        _functionBar = functionBar;
    }
    return _functionBar;
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

#pragma mark - Add
- (UITableView *)addSubviews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    //ios11 适配
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
    }
    tableView.showsVerticalScrollIndicator = NO;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat safetyAreaHeight = statusBarHeight == 20.0 ? 0 : 24.0;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, safetyAreaHeight + 50.0, 0);
    tableView.tableFooterView = [UIView new];
    [self addSubview:tableView];
    return tableView;
}

#pragma mark - Action
- (void)functionBarAction {
    if (self.clickFunctionBar) {
        self.clickFunctionBar();
    }
}

#pragma mark - Separate
- (void)showErrorMessage {
    CGSize size = [self.errorMessage boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 50.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    CGFloat width = size.width + 20;
    CGFloat height = size.height + 20;
    CGFloat x = (UIScreen.mainScreen.bounds.size.width - width) * 0.5;
    CGFloat y = UIScreen.mainScreen.bounds.size.height - CGRectGetHeight(self.functionBar.superview.frame) - height - 20.0;
    self.errorLabel.frame = CGRectMake(x, y, width, height);
    self.errorLabel.text = self.errorMessage;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.errorLabel removeFromSuperview];
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.infoModel.unitModels.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZLRedPacketGoodsDetailModel *model = self.infoModel.unitModels[section];
    if (model.cellType == ZLRedPacketGoodsDetailCellTypeGuessYouLike) {
        return ceil(model.unitModels.count / 2.0);
    }
    return model.unitModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLRedPacketGoodsDetailCell reuseCellWithTableView:tableView IndexPath:indexPath Delegate:self Model:self.infoModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLRedPacketGoodsDetailModel *model = self.infoModel.unitModels[indexPath.section];
    return model.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return 0;
    }
    return 45.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!section) {
        return [UIView new];
    }
    UILabel * headView = nil;
    if (section < self.sectionHeadersArrayM.count) {
        headView = self.sectionHeadersArrayM[section];
    }
    if (!headView) {
        headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 45.0)];
        headView.textColor = UIColor.lightGrayColor;
        headView.font = [UIFont systemFontOfSize:12.0];
        headView.textAlignment = NSTextAlignmentCenter;
        [self.sectionHeadersArrayM addObject:headView];
    }
    ZLRedPacketGoodsDetailModel *model = self.infoModel.unitModels[section];
    headView.text = model.title;
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
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
    self.redPacketGoodsDetailNavBgView.alpha = alpha;
}

#pragma mark - ZLRedPacketGoodsDetailGuessYouLikeCellDelgate
- (void)lookDetailWithModel:(ZLRedPacketGoodsDetailModel *)model {
    if (self.lookGuessYouLikeDetail) {
        self.lookGuessYouLikeDetail(model);
    }
}

@end
