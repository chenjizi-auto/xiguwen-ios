//
//  ZLIntegralGoodsSureOrderView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsSureOrderView.h"
#import "ZLIntegralGoodsSureOrderCell.h"
#import "ZLIntegralGoodsSureOrderSectionHeader.h"
#import "ZLIntegralGoodsSureOrderTableHeader.h"
#import "ZLIntegralGoodsSureOrderTableFooter.h"

@interface ZLIntegralGoodsSureOrderView ()<UITableViewDelegate,UITableViewDataSource>

///
@property (nonatomic,weak) UITableView *tableView;
///功能条
@property (nonatomic,weak) UIButton *functionBar;
//区头（复用）
@property (nonatomic,strong) NSMutableArray *sectionHeadersArrayM;
///
@property (nonatomic,strong) ZLIntegralGoodsSureOrderTableHeader *tableHeader;
///
@property (nonatomic,strong) ZLIntegralGoodsSureOrderTableFooter *tableFooter;
///错误提示
@property (nonatomic,weak) UILabel *errorLabel;

@end

@implementation ZLIntegralGoodsSureOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLIntegralGoodsSureOrderModel *)infoModel {
    _infoModel = infoModel;
    self.tableHeader.name = infoModel.name;
    self.tableHeader.phone = infoModel.phone;
    self.tableHeader.address = infoModel.address;
    self.tableHeader.frame = CGRectMake(self.tableHeader.frame.origin.x, self.tableHeader.frame.origin.y, self.tableHeader.frame.size.width, infoModel.addressHeight + 60.0);
    self.tableHeader.addressHeight = infoModel.addressHeight;
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
- (ZLIntegralGoodsSureOrderTableHeader *)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[ZLIntegralGoodsSureOrderTableHeader alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 80.0)];
        __weak typeof(self)weakSelf = self;
        _tableHeader.clickAddress = ^{
            if (weakSelf.clickAddress) {
                weakSelf.clickAddress();
            }
        };
    }
    return _tableHeader;
}
- (ZLIntegralGoodsSureOrderTableFooter *)tableFooter {
    if (!_tableFooter) {
        _tableFooter = [[ZLIntegralGoodsSureOrderTableFooter alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50.0)];
    }
    return _tableFooter;
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
        [functionBar setTitle:@"确认兑换" forState:UIControlStateNormal];
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
    tableView.rowHeight = 100.0;
    tableView.tableHeaderView = self.tableHeader;
    tableView.tableFooterView = self.tableFooter;
    //ios11 适配
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
    }
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat safetyAreaHeight = statusBarHeight == 20.0 ? 0 : 24.0;
    tableView.contentInset = UIEdgeInsetsMake(statusBarHeight + 44.0, 0, safetyAreaHeight + 50.0, 0);
    [self addSubview:tableView];
    return tableView;
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

#pragma mark - Action
- (void)functionBarAction {
    if (!self.infoModel.addressId) {
        self.errorMessage = @"请先选择收货地址";
        return;
    }
    if (self.clickFunctionBar) {
        self.infoModel.LeaveMessage = self.tableFooter.leaveMessage;
        self.clickFunctionBar();
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLIntegralGoodsSureOrderCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZLIntegralGoodsSureOrderSectionHeader * headView = nil;
    if (section < self.sectionHeadersArrayM.count) {
        headView = self.sectionHeadersArrayM[section];
    }
    if (!headView) {
        headView = [[ZLIntegralGoodsSureOrderSectionHeader alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 45.0)];
        [self.sectionHeadersArrayM addObject:headView];
    }
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end
