//
//  baojiaShopCar_New.m
//  BoYi
//
//  Created by itzhaolei on 2021/11/27.
//  Copyright © 2021 hengwu. All rights reserved.
//

#import "baojiaShopCar_New.h"

@interface baojiaShopCar_New ()

/// 单元视图
@property (nonatomic, strong) UIView *unitView;
/// 封面图
@property (nonatomic, strong) UIImageView *iconImageView;
/// 标题
@property (nonatomic, strong) UILabel *nameLabel;
/// 价格
@property (nonatomic, strong) UILabel *priceLabel;
/// 提示文字
@property (nonatomic, strong) UILabel *markLabel;
/// 日期块
@property (nonatomic, strong) UIView *dateView;
/// 日期分割线
@property (nonatomic, strong) UIView *dateLine;
/// 日期标题
@property (nonatomic, strong) UILabel *dateTileLabel;
/// 日期
@property (nonatomic, strong) UILabel *dateLabel;
/// 右箭头
@property (nonatomic, strong) UIButton *arrowsButton;
/// 付款类型
@property (nonatomic, strong) UIView *payTypeView;
/// 付款类型分割线
@property (nonatomic, strong) UIView *payTypeLine;
/// 付款类型标题
@property (nonatomic, strong) UILabel *payTypeTileLabel;
/// 付款类型滚动选项
@property (nonatomic, strong) UIScrollView *payTypeScrollView;
/// 购买数量
@property (nonatomic, strong) UIView *buyNumberView;
/// 购买数量分割线
@property (nonatomic, strong) UIView *buyNumberLine;
/// 购买数量标题
@property (nonatomic, strong) UILabel *buyNumberTileLabel;
/// 数量
@property (nonatomic, strong) UIView *numberCountView;
/// 确定
@property (nonatomic, strong) UILabel *doneItem;

@end

@implementation baojiaShopCar_New

- (UIView *)unitView {
    if (!_unitView) {
        _unitView = [[UIView alloc] init];
        _unitView.backgroundColor = UIColor.whiteColor;
        _unitView.layer.cornerRadius = 10;
        _unitView.layer.masksToBounds = YES;
    }
    return _unitView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 10;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = MAINCOLOR;
    }
    return _priceLabel;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [[UILabel alloc] init];
        _markLabel.font = [UIFont systemFontOfSize:13];
        _markLabel.textColor = UIColor.lightGrayColor;
        _markLabel.text = @"请选择 购买参数";
    }
    return _markLabel;
}

- (UIView *)dateView {
    if (!_dateView) {
        _dateView = [[UIView alloc] init];
    }
    return _dateView;
}

- (UIView *)dateLine {
    if (!_dateLine) {
        _dateLine = [[UIView alloc] init];
        _dateLine.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.5];
    }
    return _dateLine;
}

- (UILabel *)dateTileLabel {
    if (!_dateTileLabel) {
        _dateTileLabel = [[UILabel alloc] init];
        _dateTileLabel.font = [UIFont systemFontOfSize:14];
        _dateTileLabel.textColor = UIColor.blackColor;
        _dateTileLabel.text = @"婚礼日期";
    }
    return _dateTileLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textColor = MAINCOLOR;
    }
    return _dateLabel;
}

- (UIButton *)arrowsButton {
    if (!_arrowsButton) {
        _arrowsButton = [[UIButton alloc] init];
        [_arrowsButton setImage:[UIImage imageNamed:@"点击进入"] forState: UIControlStateNormal];
    }
    return _arrowsButton;
}

- (UIView *)payTypeView {
    if (!_payTypeView) {
        _payTypeView = [[UIView alloc] init];
    }
    return _payTypeView;
}

- (UIView *)payTypeLine {
    if (!_payTypeLine) {
        _payTypeLine = [[UIView alloc] init];
        _payTypeLine.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.5];
    }
    return _payTypeLine;
}

- (UILabel *)payTypeTileLabel {
    if (!_payTypeTileLabel) {
        _payTypeTileLabel = [[UILabel alloc] init];
        _payTypeTileLabel.font = [UIFont systemFontOfSize:14];
        _payTypeTileLabel.textColor = UIColor.blackColor;
        _payTypeTileLabel.text = @"付款类型";
    }
    return _payTypeTileLabel;
}

- (UIScrollView *)payTypeScrollView {
    if (!_payTypeScrollView) {
        _payTypeScrollView = [[UIScrollView alloc] init];
        _payTypeScrollView.backgroundColor = UIColor.redColor;
    }
    return _payTypeScrollView;
}

- (UIView *)buyNumberView {
    if (!_buyNumberView) {
        _buyNumberView = [[UIView alloc] init];
    }
    return _buyNumberView;
}

- (UIView *)buyNumberLine {
    if (!_buyNumberLine) {
        _buyNumberLine = [[UIView alloc] init];
        _buyNumberLine.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.5];
    }
    return _buyNumberLine;
}

- (UILabel *)buyNumberTileLabel {
    if (!_buyNumberTileLabel) {
        _buyNumberTileLabel = [[UILabel alloc] init];
        _buyNumberTileLabel.font = [UIFont systemFontOfSize:14];
        _buyNumberTileLabel.textColor = UIColor.blackColor;
        _buyNumberTileLabel.text = @"购买数量";
    }
    return _buyNumberTileLabel;
}

- (UIView *)numberCountView {
    if (!_numberCountView) {
        _numberCountView = [[UIView alloc] init];
        _numberCountView.backgroundColor = UIColor.blueColor;
    }
    return _numberCountView;
}

- (UILabel *)doneItem {
    if (!_doneItem) {
        _doneItem = [[UILabel alloc] init];
        _doneItem.backgroundColor = MAINCOLOR;
        _doneItem.font = [UIFont boldSystemFontOfSize:17];
        _doneItem.textColor = UIColor.whiteColor;
        _doneItem.textAlignment = NSTextAlignmentCenter;
        _doneItem.text = @"确定";
    }
    return _doneItem;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BOOL isOn = [touches.allObjects.firstObject.view isDescendantOfView:self.unitView];
    if (isOn) {
        [super touchesBegan:touches withEvent:event];
        return;
    }
    [self dismiss];
}

- (void)addSubviews {
    [self addSubview:self.unitView];
    [self.unitView addSubview:self.iconImageView];
    [self.unitView addSubview:self.nameLabel];
    [self.unitView addSubview:self.priceLabel];
    [self.unitView addSubview:self.markLabel];
    [self.unitView addSubview:self.dateView];
    [self.dateView addSubview:self.dateLine];
    [self.dateView addSubview:self.dateTileLabel];
    [self.dateView addSubview:self.dateLabel];
    [self.dateView addSubview:self.arrowsButton];
    [self.unitView addSubview:self.payTypeView];
    [self.payTypeView addSubview:self.payTypeLine];
    [self.payTypeView addSubview:self.payTypeTileLabel];
    [self.payTypeView addSubview:self.payTypeScrollView];
    [self.unitView addSubview:self.buyNumberView];
    [self.buyNumberView addSubview:self.buyNumberLine];
    [self.buyNumberView addSubview:self.buyNumberTileLabel];
    [self.buyNumberView addSubview:self.numberCountView];
    [self.unitView addSubview:self.doneItem];
}

- (void)addConstraints {
    [self.unitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.unitView).offset(15);
        make.size.mas_equalTo(70);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImageView.mas_trailing).offset(15);
        make.top.mas_equalTo(self.unitView).offset(20);
        make.trailing.mas_equalTo(self.unitView).offset(-15);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImageView.mas_trailing).offset(15);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.trailing.mas_equalTo(self.unitView).offset(-15);
    }];
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImageView.mas_trailing).offset(15);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(5);
        make.trailing.mas_equalTo(self.unitView).offset(-15);
    }];
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(15);
        make.trailing.leading.mas_equalTo(self.unitView);
    }];
    [self.dateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateView);
        make.trailing.leading.mas_equalTo(self.dateView);
        make.height.mas_equalTo(0.5);
    }];
    [self.dateTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateView).offset(15);
        make.leading.mas_equalTo(self.dateView).offset(15);
        make.trailing.mas_equalTo(self.dateView).offset(-45);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateTileLabel.mas_bottom).offset(15);
        make.leading.mas_equalTo(self.dateView).offset(15);
        make.trailing.mas_equalTo(self.dateView).offset(-45);
        make.bottom.mas_equalTo(self.dateView).offset(-15);
    }];
    [self.arrowsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateView);
        make.trailing.mas_equalTo(self.dateView);
        make.bottom.mas_equalTo(self.dateView);
        make.width.mas_equalTo(45);
    }];
    [self.payTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateView.mas_bottom);
        make.trailing.leading.mas_equalTo(self.unitView);
    }];
    [self.payTypeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payTypeView);
        make.trailing.leading.mas_equalTo(self.payTypeView);
        make.height.mas_equalTo(0.5);
    }];
    [self.payTypeTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payTypeView).offset(15);
        make.leading.mas_equalTo(self.payTypeView).offset(15);
        make.trailing.mas_equalTo(self.payTypeView).offset(-15);
    }];
    [self.payTypeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payTypeTileLabel.mas_bottom).offset(15);
        make.leading.mas_equalTo(self.payTypeView).offset(15);
        make.trailing.mas_equalTo(self.payTypeView).offset(-15);
        make.bottom.mas_equalTo(self.payTypeView).offset(-15);
        make.height.mas_equalTo(30);
    }];
    [self.buyNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payTypeView.mas_bottom);
        make.trailing.leading.mas_equalTo(self.unitView);
    }];
    [self.buyNumberLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyNumberView);
        make.trailing.leading.mas_equalTo(self.buyNumberView);
        make.height.mas_equalTo(0.5);
    }];
    [self.buyNumberTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyNumberView).offset(15);
        make.leading.mas_equalTo(self.buyNumberView).offset(15);
        make.centerY.mas_equalTo(self.buyNumberView);
    }];
    [self.numberCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyNumberView).offset(15);
        make.trailing.mas_equalTo(self.buyNumberView).offset(-15);
        make.bottom.mas_equalTo(self.buyNumberView).offset(-15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);  // debug
    }];
    [self.doneItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyNumberView.mas_bottom).offset(40);
        make.leading.trailing.mas_equalTo(self.unitView);
        make.bottom.mas_equalTo(self.unitView.mas_bottom).offset(-30);
        make.height.mas_equalTo(50);
    }];
}

/// 展示下单选择
/// @param view 展示在哪个视图上
/// @param dic 外界带进来的参数
/// @param userid 用户标识
/// @param block 回执
+ (void)showInView:(UIView *)view dic:(NSMutableDictionary *)dic userid:(NSString *)userid block:(void(^)(NSDictionary *dic))block {
    baojiaShopCar_New *thisView = [[baojiaShopCar_New alloc] initWithFrame:UIScreen.mainScreen.bounds];
    thisView.unitView.transform = CGAffineTransformMakeTranslation(0, thisView.frame.size.height);
    [thisView.iconImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"header"]]];
    thisView.nameLabel.text = dic[@"name"];
    thisView.priceLabel.text = [NSString stringWithFormat:@"￥%@", dic[@"price"]];
    thisView.dateLabel.text = [thisView getTomorrowDate];
    [view addSubview:thisView];
    __weak typeof(thisView)weakSelf = thisView;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.unitView.transform = CGAffineTransformIdentity;
    }];
}

- (NSString *)getTomorrowDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] + 60 * 60 * 24;
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSince1970:time];
    return [NSString stringWithFormat: @"%@ 中午", [dateFormatter stringFromDate:tomorrowDate]];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.unitView.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
