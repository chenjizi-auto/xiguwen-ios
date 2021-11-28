//
//  baojiaShopCar_New.m
//  BoYi
//
//  Created by itzhaolei on 2021/11/27.
//  Copyright © 2021 hengwu. All rights reserved.
//

#import "baojiaShopCar_New.h"

@interface Button : UIButton

@end

@implementation Button

- (void)setSelected:(BOOL)selected {
    super.selected = selected;
    self.backgroundColor = selected ? MAINCOLOR : RGBA(240, 240, 240, 1);
}

@end

@interface baojiaShopCar_New ()<UITextFieldDelegate>

/// 传递进来的原始数据
@property (nonatomic, strong) NSDictionary *originData;

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
/// 选项父视图
@property (nonatomic, strong) UIStackView *vStackView;
/// 付款类型滚动选项
@property (nonatomic, strong) UIScrollView *payTypeScrollView;
/// 第一个
@property (nonatomic, strong) UIButton *oneButton;
/// 第二个
@property (nonatomic, strong) UIButton *twoButton;
/// 第三个
@property (nonatomic, strong) UIButton *threeButton;
/// 第四个
@property (nonatomic, strong) UIButton *fourButton;
/// 价格输入栏
@property (nonatomic, strong) UITextField *priceImportView;
/// 购买数量
@property (nonatomic, strong) UIView *buyNumberView;
/// 添加
@property (nonatomic, strong) UILabel *addItemLabel;
/// 添加
@property (nonatomic, strong) UIView *addItemLine;
/// 减小
@property (nonatomic, strong) UILabel *lessenItemLabel;
/// 减小
@property (nonatomic, strong) UIView *lessenItemLine;
/// 数量
@property (nonatomic, strong) UILabel *numberLabel;
/// 购买数量分割线
@property (nonatomic, strong) UIView *buyNumberLine;
/// 购买数量标题
@property (nonatomic, strong) UILabel *buyNumberTileLabel;
/// 数量
@property (nonatomic, strong) UIView *numberCountView;
/// 确定
@property (nonatomic, strong) UILabel *doneItem;
/// 上次选中的选项
@property (nonatomic, strong) UIButton *lastItem;

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

- (UIStackView *)vStackView {
    if (!_vStackView) {
        _vStackView = [[UIStackView alloc] init];
        _vStackView.axis = UILayoutConstraintAxisVertical;
        _vStackView.spacing = 10;
    }
    return _vStackView;
}

- (UIScrollView *)payTypeScrollView {
    if (!_payTypeScrollView) {
        _payTypeScrollView = [[UIScrollView alloc] init];
        _payTypeScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _payTypeScrollView;
}

- (UIButton *)oneButton {
    if (!_oneButton) {
        _oneButton = [[Button alloc] init];
        [_oneButton setTitle:@"全款支付" forState:UIControlStateNormal];
        _oneButton.selected = YES;
        [_oneButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [_oneButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _oneButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_oneButton addTarget:self action:@selector(optionItemsAction:) forControlEvents:UIControlEventTouchUpInside];
        _oneButton.layer.cornerRadius = 15;
        _oneButton.layer.masksToBounds = YES;
        _oneButton.tag = 1;
        self.lastItem = _oneButton;
    }
    return _oneButton;
}

- (UIButton *)twoButton {
    if (!_twoButton) {
        _twoButton = [[Button alloc] init];
        [_twoButton setTitle:@"全款定金" forState:UIControlStateNormal];
        _twoButton.selected = NO;
        [_twoButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [_twoButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _twoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_twoButton addTarget:self action:@selector(optionItemsAction:) forControlEvents:UIControlEventTouchUpInside];
        _twoButton.layer.cornerRadius = 15;
        _twoButton.layer.masksToBounds = YES;
        _twoButton.tag = 2;
    }
    return _twoButton;
}

- (UIButton *)threeButton {
    if (!_threeButton) {
        _threeButton = [[Button alloc] init];
        [_threeButton setTitle:@"约定价格" forState:UIControlStateNormal];
        _threeButton.selected = NO;
        [_threeButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [_threeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _threeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_threeButton addTarget:self action:@selector(optionItemsAction:) forControlEvents:UIControlEventTouchUpInside];
        _threeButton.layer.cornerRadius = 15;
        _threeButton.layer.masksToBounds = YES;
        _threeButton.tag = 3;
    }
    return _threeButton;
}

- (UIButton *)fourButton {
    if (!_fourButton) {
        _fourButton = [[Button alloc] init];
        [_fourButton setTitle:@"约定定金" forState:UIControlStateNormal];
        _fourButton.selected = NO;
        [_fourButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [_fourButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _fourButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_fourButton addTarget:self action:@selector(optionItemsAction:) forControlEvents:UIControlEventTouchUpInside];
        _fourButton.layer.cornerRadius = 15;
        _fourButton.layer.masksToBounds = YES;
        _fourButton.tag = 4;
    }
    return _fourButton;
}

- (UITextField *)priceImportView {
    if (!_priceImportView) {
        _priceImportView = [[UITextField alloc] init];
        _priceImportView.placeholder = @"请输入约定价格";
        _priceImportView.font = [UIFont systemFontOfSize:15];
        _priceImportView.returnKeyType = UIReturnKeyDone;
        _priceImportView.delegate = self;
        _priceImportView.hidden = YES;
        [_priceImportView addTarget:self action:@selector(priceImportViewValueChangedAction) forControlEvents:UIControlEventEditingChanged];
    }
    return _priceImportView;
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
        _numberCountView.layer.borderWidth = 0.5;
        _numberCountView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _numberCountView;
}

- (UILabel *)addItemLabel {
    if (!_addItemLabel) {
        _addItemLabel = [[UILabel alloc] init];
        _addItemLabel.font = [UIFont systemFontOfSize:17];
        _addItemLabel.textColor = UIColor.blackColor;
        _addItemLabel.textAlignment = NSTextAlignmentCenter;
        _addItemLabel.text = @"+";
        _addItemLabel.userInteractionEnabled = YES;
        [_addItemLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(numberChangeAction:)]];
    }
    return _addItemLabel;
}

- (UIView *)addItemLine {
    if (!_addItemLine) {
        _addItemLine = [[UIView alloc] init];
        _addItemLine.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.5];
    }
    return _addItemLine;
}

- (UILabel *)lessenItemLabel {
    if (!_lessenItemLabel) {
        _lessenItemLabel = [[UILabel alloc] init];
        _lessenItemLabel.font = [UIFont systemFontOfSize:19];
        _lessenItemLabel.textColor = UIColor.blackColor;
        _lessenItemLabel.textAlignment = NSTextAlignmentCenter;
        _lessenItemLabel.text = @"-";
        _lessenItemLabel.userInteractionEnabled = YES;
        [_lessenItemLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(numberChangeAction:)]];
    }
    return _lessenItemLabel;
}

- (UIView *)lessenItemLine {
    if (!_lessenItemLine) {
        _lessenItemLine = [[UIView alloc] init];
        _lessenItemLine.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.5];
    }
    return _lessenItemLine;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:14];
        _numberLabel.textColor = UIColor.blackColor;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.text = @"1";
    }
    return _numberLabel;
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
    [self.payTypeView addSubview:self.vStackView];
    [self.vStackView addArrangedSubview:self.payTypeScrollView];
    [self.payTypeScrollView addSubview:self.oneButton];
    [self.payTypeScrollView addSubview:self.twoButton];
    [self.payTypeScrollView addSubview:self.threeButton];
    [self.payTypeScrollView addSubview:self.fourButton];
    [self.vStackView addArrangedSubview:self.priceImportView];
    [self.unitView addSubview:self.buyNumberView];
    [self.buyNumberView addSubview:self.buyNumberLine];
    [self.buyNumberView addSubview:self.buyNumberTileLabel];
    [self.buyNumberView addSubview:self.numberCountView];
    [self.numberCountView addSubview:self.addItemLabel];
    [self.addItemLabel addSubview:self.addItemLine];
    [self.numberCountView addSubview:self.lessenItemLabel];
    [self.lessenItemLabel addSubview:self.lessenItemLine];
    [self.numberCountView addSubview:self.numberLabel];
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
        make.leading.mas_equalTo(self.dateView).offset(15);
        make.trailing.mas_equalTo(self.dateView).offset(-15);
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
        make.leading.mas_equalTo(self.payTypeView).offset(15);
        make.trailing.mas_equalTo(self.payTypeView).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    [self.payTypeTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payTypeView).offset(15);
        make.leading.mas_equalTo(self.payTypeView).offset(15);
        make.trailing.mas_equalTo(self.payTypeView).offset(-15);
    }];
    [self.vStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payTypeTileLabel.mas_bottom).offset(15);
        make.leading.mas_equalTo(self.payTypeView).offset(15);
        make.trailing.mas_equalTo(self.payTypeView).offset(-15);
        make.bottom.mas_equalTo(self.payTypeView).offset(-15);
    }];
    [self.payTypeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
    }];
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.top.mas_equalTo(self.payTypeScrollView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.oneButton);
        make.size.mas_equalTo(self.oneButton);
        make.leading.mas_equalTo(self.oneButton.mas_trailing).offset(15);
    }];
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.oneButton);
        make.size.mas_equalTo(self.oneButton);
        make.leading.mas_equalTo(self.twoButton.mas_trailing).offset(15);
    }];
    [self.fourButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.oneButton);
        make.size.mas_equalTo(self.oneButton);
        make.leading.mas_equalTo(self.threeButton.mas_trailing).offset(15);
        make.trailing.mas_equalTo(self.payTypeScrollView);
    }];
    [self.priceImportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
    }];
    [self.buyNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payTypeView.mas_bottom);
        make.trailing.leading.mas_equalTo(self.unitView);
    }];
    [self.buyNumberLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyNumberView);
        make.leading.mas_equalTo(self.buyNumberView).offset(15);
        make.trailing.mas_equalTo(self.buyNumberView).offset(-15);
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
    }];
    [self.lessenItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberCountView);
        make.leading.mas_equalTo(self.numberCountView);
        make.bottom.mas_equalTo(self.numberCountView);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(30);
    }];
    [self.lessenItemLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lessenItemLabel).offset(0.5);
        make.bottom.mas_equalTo(self.lessenItemLabel).offset(-0.5);
        make.trailing.mas_equalTo(self.lessenItemLabel);
        make.width.mas_equalTo(0.5);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.lessenItemLabel.mas_trailing).offset(15);
        make.centerY.mas_equalTo(self.numberCountView);
    }];
    [self.addItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberCountView);
        make.leading.mas_equalTo(self.numberLabel.mas_trailing).offset(15);
        make.trailing.mas_equalTo(self.numberCountView);
        make.bottom.mas_equalTo(self.numberCountView);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(30);
    }];
    [self.addItemLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addItemLabel).offset(0.5);
        make.bottom.mas_equalTo(self.addItemLabel).offset(-0.5);
        make.leading.mas_equalTo(self.addItemLabel.mas_leading);
        make.width.mas_equalTo(0.5);
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
    thisView.originData = dic;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:NO];
    return YES;
}

- (void)optionItemsAction:(UIButton *)sender {
    self.priceImportView.hidden = sender.tag < 3;
    self.lastItem.selected = false;
    sender.selected = true;
    self.lastItem = sender;
    if (sender.tag == 1) {
        self.priceLabel.text = self.originData[@"price"];
    }else if (sender.tag == 2) {
        self.priceLabel.text = self.originData[@"temporarypay"];
    }else if (sender.tag == 3) {
        self.priceLabel.text = @"请输入[约定价格]";
    }else if (sender.tag == 4) {
        self.priceLabel.text = @"请输入[约定价格]";
    }
}

- (void)numberChangeAction:(UITapGestureRecognizer *)tap {
    if (tap.view == self.lessenItemLabel) {
        if ([self.numberLabel.text intValue] < 2) {
            return;
        }
        int number = [self.numberLabel.text intValue] - 1;
        self.numberLabel.text = [NSString stringWithFormat:@"%d", number];
        return;
    }
    int number = [self.numberLabel.text intValue] + 1;
    self.numberLabel.text = [NSString stringWithFormat:@"%d", number];
}

- (void)priceImportViewValueChangedAction {
    if ([self.priceImportView.text floatValue] <= 0) {
        self.priceLabel.text = @"请输入[约定价格]";
        return;
    }
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.priceImportView.text];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([@"1234567890." rangeOfString:string].location != NSNotFound
        || [string isEqualToString:@""]) {
        if (([textField.text rangeOfString:@"."].location != NSNotFound
            && [string isEqualToString:@"."])) {
            return false;
        }
        if ((![string isEqualToString:@""] && [textField.text rangeOfString:@"."].location != NSNotFound)) {
            if ([textField.text componentsSeparatedByString:@"."].lastObject.length > 1) {
                return false;
            }
        }
        return true;
    }
    return false;
}

@end
