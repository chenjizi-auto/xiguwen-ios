//
//  ZLIntegralGoodsOrderDetailView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsOrderDetailView.h"
#import "ZLIntegralGoodsOrderDetailOrderStateCell.h"
#import "ZLIntegralGoodsOrderDetailAddressCell.h"
#import "ZLIntegralGoodsOrderDetailGoodsCell.h"
#import "ZLIntegralGoodsOrderDetailPriceCell.h"
#import "ZLIntegralGoodsOrderDetailOrderInfoCell.h"
#import "ZLIntegralGoodsOrderDetailTitleCell.h"
#import "ZLIntegralGoodsOrderDetailGuessYouLikeCell.h"

@interface ZLIntegralGoodsOrderDetailView ()<UITableViewDelegate,UITableViewDataSource,ZLIntegralGoodsOrderDetailGuessYouLikeCellDelgate>

///
@property (nonatomic,weak) UITableView *tableView;
///待付款倒计时
@property (nonatomic,strong) NSTimer *timer;
///功能条
@property (nonatomic,weak) UIView *functionBar;
///左边
@property (nonatomic,weak) UIButton *functionLeftItem;
///右边
@property (nonatomic,weak) UIButton *functionRightItem;
///错误提示
@property (nonatomic,weak) UILabel *errorLabel;

@end

@implementation ZLIntegralGoodsOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLIntegralGoodsOrderDetailModel *)infoModel {
    _infoModel = infoModel;
    [self updateState];
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
    }
    return _tableView;
}
- (UIView *)functionBar {
    if (!_functionBar) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat safetyAreaHeight = statusBarHeight == 20.0 ? 0 : 24.0;
        UIView *functionBar = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 50.0 - safetyAreaHeight, UIScreen.mainScreen.bounds.size.width, 50.0 + safetyAreaHeight)];
        
        //夹层，用来弥补iPhoneX的底部安全域
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = functionBar.bounds;
        [functionBar addSubview:effectView];
        
        //分割线
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, CGRectGetWidth(functionBar.frame), 0.5);
        layer.backgroundColor = UIColor.lightGrayColor.CGColor;
        [effectView.contentView.layer addSublayer:layer];
        
        [self addSubview:functionBar];
        _functionBar = functionBar;
    }
    return _functionBar;
}
- (UIButton *)functionLeftItem {
    if (!_functionLeftItem) {
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_functionBar.frame) - 180.0, 10.0, 80.0, 30.0)];
        [sender setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        sender.titleLabel.font = [UIFont systemFontOfSize:14.0];
        sender.layer.cornerRadius = 3.0;
        sender.layer.masksToBounds = YES;
        sender.layer.borderWidth = 1.0;
        sender.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [sender addTarget:self action:@selector(functionLeftItemAction) forControlEvents:UIControlEventTouchUpInside];
        [_functionBar addSubview:sender];
        _functionLeftItem = sender;
    }
    return _functionLeftItem;
}
- (UIButton *)functionRightItem {
    if (!_functionRightItem) {
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_functionBar.frame) - 90.0, 10.0, 80.0, 30.0)];
        [sender setTitleColor:[UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0] forState:UIControlStateNormal];
        sender.titleLabel.font = [UIFont systemFontOfSize:14.0];
        sender.layer.cornerRadius = 3.0;
        sender.layer.masksToBounds = YES;
        sender.layer.borderWidth = 1.0;
        sender.layer.borderColor = [UIColor colorWithRed:237/255.0 green:68/255.0 blue:74/255.0 alpha:1.0].CGColor;
        [sender addTarget:self action:@selector(functionRightItemAction) forControlEvents:UIControlEventTouchUpInside];
        [_functionBar addSubview:sender];
        _functionRightItem = sender;
    }
    return _functionRightItem;
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    //ios11 适配
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
    }
    [self addSubview:tableView];
    return tableView;
}

#pragma mark - Separate
- (void)startTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:(NSRunLoopCommonModes)];
    self.timer = timer;
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)updateState {
    if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingPay) {
        if (!self.timer) {
            [self startTimer];
        }
    }else {
        [self stopTimer];
    }
    self.functionBar.hidden = (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingPay
                               || self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingReceive
                               || self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeDealSuccessful)
                            ? NO
                            : YES;
    if (!self.functionBar.hidden) {
        if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingPay) {
            self.functionLeftItem.hidden = NO;
            [self.functionLeftItem setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.functionRightItem setTitle:@"去支付" forState:UIControlStateNormal];
        }else if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingReceive) {
            self.functionLeftItem.hidden = NO;
            [self.functionLeftItem setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.functionRightItem setTitle:@"确认收货" forState:UIControlStateNormal];
        }else if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeDealSuccessful) {
            self.functionLeftItem.hidden = YES;
            [self.functionRightItem setTitle:@"查看物流" forState:UIControlStateNormal];
        }
    }
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat height = self.functionBar.hidden
                   ? 0
                   : CGRectGetHeight(self.functionBar.frame);
    self.tableView.contentInset = UIEdgeInsetsMake(statusBarHeight + 44.0, 0, height, 0);
}
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
- (void)timerAction {
    self.infoModel.orderCountdown -= 1;
    ZLIntegralGoodsOrderDetailOrderStateCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.currentCountdown = self.infoModel.orderCountdown;
    if (!self.infoModel.orderCountdown) {
        [self stopTimer];
    }
}
- (void)functionLeftItemAction {
    ZLIntegralGoodsOrderDetailViewInteractionType interactionType = (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingPay)
    ? ZLIntegralGoodsOrderDetailViewInteractionTypeCancelOrder
    : ZLIntegralGoodsOrderDetailViewInteractionTypeLookLogistics;
    if (self.operationOrder) {
        self.operationOrder(interactionType);
    }
}
- (void)functionRightItemAction {
    ZLIntegralGoodsOrderDetailViewInteractionType interactionType = 0;
    if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingPay) {
        interactionType = ZLIntegralGoodsOrderDetailViewInteractionTypeGoToPay;
    }else if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingReceive) {
        interactionType = ZLIntegralGoodsOrderDetailViewInteractionTypeSureReceive;
    }else if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeDealSuccessful) {
        interactionType = ZLIntegralGoodsOrderDetailViewInteractionTypeLookLogistics;
    }
    if (self.operationOrder) {
        self.operationOrder(interactionType);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? ceil(self.infoModel.unitModels.count / 2.0) : 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        if (!indexPath.row) {
            return [ZLIntegralGoodsOrderDetailOrderStateCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else if (indexPath.row == 1) {
            return [ZLIntegralGoodsOrderDetailAddressCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else if (indexPath.row == 2) {
            return [ZLIntegralGoodsOrderDetailGoodsCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else if (indexPath.row == 3) {
            return [ZLIntegralGoodsOrderDetailPriceCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else if (indexPath.row == 4) {
            return [ZLIntegralGoodsOrderDetailOrderInfoCell reuseCellWithTableView:tableView IndexPath:indexPath Model:self.infoModel];
        }else {
            return [ZLIntegralGoodsOrderDetailTitleCell reuseCellWithTableView:tableView IndexPath:indexPath];
        }
    }
    return [ZLIntegralGoodsOrderDetailGuessYouLikeCell reuseCellWithTableView:tableView IndexPath:indexPath Delegate:self Model:self.infoModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        if (!indexPath.row) {
            return 90.0;
        }else if (indexPath.row == 1) {
            return self.infoModel.addressHeight + 130.0;
        }else if (indexPath.row == 2) {
            return 100.0;
        }else if (indexPath.row == 3) {
            return 60.0;
        }else if (indexPath.row == 4) {
            CGFloat rowHeight = 60.0;
            if (self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingSend
                || self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeWaitingReceive
                || self.infoModel.orderState == ZLIntegralGoodsOrderDetailTypeDealSuccessful) {
                rowHeight += 20.0;
            }
            return rowHeight;
        }else {
            return 50.0;
        }
    }
    return (UIScreen.mainScreen.bounds.size.width - 5.0) / 2 + 76.0;
}

#pragma mark - ZLIntegralGoodsOrderDetailGuessYouLikeCellDelgate
- (void)lookDetailWithModel:(ZLIntegralGoodsOrderDetailModel *)model {
    if (self.lookGuessYouLikeDetail) {
        self.lookGuessYouLikeDetail(model);
    }
}

@end
