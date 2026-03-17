//
//  ZLIntegralGoodsSureOrderTableFooter.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralGoodsSureOrderTableFooter.h"

@interface ZLIntegralGoodsSureOrderTableFooter ()<UITextFieldDelegate>

///标题
@property (nonatomic,weak) UILabel *titleLabel;
///输入框
@property (nonatomic,weak) UITextField *textField;

@end

@implementation ZLIntegralGoodsSureOrderTableFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self titleLabel];
    [self textView];
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, 90.0, self.bounds.size.height)];
        titleLabel.text = @"给卖家留言：";
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UITextField *)textView {
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 10.0, UIScreen.mainScreen.bounds.size.width - CGRectGetMaxX(self.titleLabel.frame) - 15.0, self.bounds.size.height - 20.0)];
        textField.placeholder = @"如有特殊配送要求，请在此填写留言。";
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

#pragma mark - Readonly
- (NSString *)leaveMessage {
    return self.textField.text;
}

@end
