//
//  ZLIntegralGoodsDetailView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsDetailView.h"
#import "ZLIntegralGoodsDetailNavBgView.h"
#import "ZLIntegralGoodsDetailCell.h"
#import "ZLIntegralGoodsGuessYouLikeCell.h"
#import "ZLIntegralGoodsDetailLookImageView.h"
#import "ZLIntegralGoodsBasicDetailCell.h"
#import "ZLIntegralGoodsImageTextDetailCell.h"
#import "ZLIntegralGoodsDetailLookImageView.h"

@interface ZLIntegralGoodsDetailView ()<UITableViewDelegate,UITableViewDataSource,ZLIntegralGoodsGuessYouLikeCellDelgate,ZLIntegralGoodsBasicDetailCellDelgate>

///
@property (nonatomic,weak) UITableView *tableView;
//渐变导航背景
@property (nonatomic,weak) ZLIntegralGoodsDetailNavBgView *integralGoodsDetailNavBgView;
///功能条
@property (nonatomic,weak) UIButton *functionBar;
//区头（复用）
@property (nonatomic,strong) NSMutableArray *sectionHeadersArrayM;
///查看图片
@property (nonatomic,weak) ZLIntegralGoodsDetailLookImageView *lookImageView;

@end

@implementation ZLIntegralGoodsDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLIntegralGoodsDetailModel *)infoModel {
    _infoModel = infoModel;
    
    //配置功能条的显示状态
    if (infoModel.unitModels.count) {
        [self configFunctionBar];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [self addSubviews];
    }
    return _tableView;
}
- (ZLIntegralGoodsDetailNavBgView *)integralGoodsDetailNavBgView {//处理导航栏的渐变
    if (!_integralGoodsDetailNavBgView) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        ZLIntegralGoodsDetailNavBgView *integralGoodsDetailNavBgView = [[ZLIntegralGoodsDetailNavBgView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, statusBarHeight + 44.0)];
        integralGoodsDetailNavBgView.title = @"商品详情";
        [self addSubview:integralGoodsDetailNavBgView];
        _integralGoodsDetailNavBgView = integralGoodsDetailNavBgView;
    }
    return _integralGoodsDetailNavBgView;
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
        [functionBar addTarget:self action:@selector(functionBarAction) forControlEvents:UIControlEventTouchUpInside];
        functionBar.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [effectView.contentView addSubview:functionBar];
        _functionBar = functionBar;
    }
    return _functionBar;
}
- (ZLIntegralGoodsDetailLookImageView *)lookImageView {
    if (!_lookImageView) {
        ZLIntegralGoodsDetailLookImageView *lookImageView = [[ZLIntegralGoodsDetailLookImageView alloc] initWithFrame:self.bounds];
        __weak typeof(self)weakSelf = self;
        lookImageView.willDismiss = ^{
            if (weakSelf.hiddeStatusBar) {
                weakSelf.hiddeStatusBar(NO);
                [weakSelf.lookImageView removeFromSuperview];
                weakSelf.lookImageView = nil;
            }
        };
        [UIApplication.sharedApplication.delegate.window addSubview:lookImageView];
        _lookImageView = lookImageView;
    }
    return _lookImageView;
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

#pragma mark - Separate
- (void)configFunctionBar {
    self.functionBar.backgroundColor = (!self.infoModel.unitModels[0].unitModels[0].inventory)
                                               ? UIColor.lightGrayColor
                                               : [UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0];
    self.functionBar.enabled = (!self.infoModel.unitModels[0].unitModels[0].inventory)
                             ? NO
                             : YES;
    NSString *string = (!self.infoModel.unitModels[0].unitModels[0].inventory)
                     ? @"库存不足"
                     : @"马上兑换";
    [self.functionBar setTitle:string forState:UIControlStateNormal];
}

#pragma mark - Action
- (void)functionBarAction {
    if (self.clickFunctionBar) {
        self.clickFunctionBar();
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.infoModel.unitModels.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZLIntegralGoodsDetailModel *model = self.infoModel.unitModels[section];
    if (model.cellType == ZLIntegralGoodsDetailCellTypeGuessYouLike) {
        return ceil(model.unitModels.count / 2.0);
    }
    return model.unitModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLIntegralGoodsDetailCell reuseCellWithTableView:tableView IndexPath:indexPath Delegate:self Model:self.infoModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLIntegralGoodsDetailModel *model = self.infoModel.unitModels[indexPath.section];
    if (indexPath.section == 1) {
        model = model.unitModels[indexPath.row];
        return model.cellHeight;
    }
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
    UIButton * headView = nil;
    if (section < self.sectionHeadersArrayM.count) {
        headView = self.sectionHeadersArrayM[section];
    }
    if (!headView) {
        headView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 45.0)];
        [headView setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        headView.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.sectionHeadersArrayM addObject:headView];
    }
    ZLIntegralGoodsDetailModel *model = self.infoModel.unitModels[section];
    [headView setTitle:nil forState:UIControlStateNormal];
    [headView setImage:nil forState:UIControlStateNormal];
    if (model.cellType == ZLIntegralGoodsDetailCellTypeImageTextDetail) {
        [headView setTitle:[NSString stringWithFormat:@"  %@",model.title] forState:UIControlStateNormal];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"图文详情.png"];
        [headView setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    }else {
        [headView setTitle:model.title forState:UIControlStateNormal];
    }
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLIntegralGoodsDetailModel *model = self.infoModel.unitModels[indexPath.section];
    if (model.cellType == ZLIntegralGoodsDetailCellTypeImageTextDetail) {
        ZLIntegralGoodsImageTextDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGRect frame = [cell.iconButton.superview convertRect:cell.iconButton.frame toView:UIApplication.sharedApplication.delegate.window];
        [self.lookImageView showImagesWithFrame:frame Image:cell.iconButton.currentBackgroundImage ImageUrls:model.urlsArray CurrentIndex:indexPath.row];
        if (self.hiddeStatusBar) {
            self.hiddeStatusBar(YES);
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //在xx高度内发生渐变
    float alphaHeight = 64.0;
    //进行渐变
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat alpha = (offSetY <= 0) ? 0 : offSetY / alphaHeight;
    alpha = alpha > 1.0 ? 1.0 : alpha;
    self.integralGoodsDetailNavBgView.alpha = alpha;
}

#pragma mark - ZLIntegralGoodsGuessYouLikeCellDelgate
- (void)lookDetailWithModel:(ZLIntegralGoodsDetailModel *)model {
    if (self.lookGuessYouLikeDetail) {
        self.lookGuessYouLikeDetail(model);
    }
}

#pragma mark - ZLIntegralGoodsBasicDetailCellDelgate
- (void)clickBannerItem:(ZLIntegralGoodsBasicDetailCell *)cell ImageView:(UIImageView *)imageView Index:(NSInteger)index {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ZLIntegralGoodsDetailModel *model = self.infoModel.unitModels[indexPath.section];
    model = model.unitModels.firstObject;
    CGRect frame = [imageView.superview convertRect:imageView.frame toView:UIApplication.sharedApplication.delegate.window];
    [self.lookImageView showImagesWithFrame:frame Image:imageView.image ImageUrls:model.urlsArray CurrentIndex:index];
    if (self.hiddeStatusBar) {
        self.hiddeStatusBar(YES);
    }
}

@end
