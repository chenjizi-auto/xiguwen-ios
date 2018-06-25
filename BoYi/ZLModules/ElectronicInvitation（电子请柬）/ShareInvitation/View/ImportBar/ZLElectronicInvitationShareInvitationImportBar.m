//
//  ZLElectronicInvitationShareInvitationImportBar.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationShareInvitationImportBar.h"
#import "ZLElectronicInvitationEditTemplateTextView.h"
#import <objc/runtime.h>

@interface UIResponder (FirstResponder)

+ (id)currentFirstResponder;

@end

static __weak id currentFirstResponder;

@implementation UIResponder (FirstResponder)

+ (id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end

@import UIKit;

FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];

@interface UITextView (ElectronicInvitationTextViewPlaceholder)

@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end

@implementation UITextView (ElectronicInvitationTextViewPlaceholder)

#pragma mark - Swizzle Dealloc

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self.class, @selector(swizzledDealloc)));
}
- (void)swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UILabel *label = objc_getAssociatedObject(self, @selector(placeholderLabel));
    if (label) {
        for (NSString *key in self.class.observingKeys) {
            @try {
                [self removeObserver:self forKeyPath:key];
            }
            @catch (NSException *exception) {
                // Do nothing
            }
        }
    }
    [self swizzledDealloc];
}

#pragma mark - Class Methods
#pragma mark `defaultPlaceholderColor`

+ (UIColor *)defaultPlaceholderColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @" ";
        color = [textField valueForKeyPath:@"_placeholderLabel.textColor"];
    });
    return color;
}

#pragma mark - `observingKeys`

+ (NSArray *)observingKeys {
    return @[@"attributedText",
             @"bounds",
             @"font",
             @"frame",
             @"text",
             @"textAlignment",
             @"textContainerInset"];
}

- (UILabel *)placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, @selector(placeholderLabel));
    if (!label) {
        NSAttributedString *originalText = self.attributedText;
        self.text = @" "; // lazily set font of `UITextView`.
        self.attributedText = originalText;
        
        label = [[UILabel alloc] init];
        label.textColor = [self.class defaultPlaceholderColor];
        label.numberOfLines = 0;
        label.userInteractionEnabled = NO;
        objc_setAssociatedObject(self, @selector(placeholderLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        self.needsUpdateFont = YES;
        [self updatePlaceholderLabel];
        self.needsUpdateFont = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePlaceholderLabel)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
        
        for (NSString *key in self.class.observingKeys) {
            [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return label;
}
#pragma mark `placeholder`

- (NSString *)placeholder {
    return self.placeholderLabel.text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.placeholderLabel.text = placeholder;
    [self updatePlaceholderLabel];
}

- (NSAttributedString *)attributedPlaceholder {
    return self.placeholderLabel.attributedText;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    self.placeholderLabel.attributedText = attributedPlaceholder;
    [self updatePlaceholderLabel];
}

#pragma mark `placeholderColor`

- (UIColor *)placeholderColor {
    return self.placeholderLabel.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    self.placeholderLabel.textColor = placeholderColor;
}


#pragma mark `needsUpdateFont`

- (BOOL)needsUpdateFont {
    return [objc_getAssociatedObject(self, @selector(needsUpdateFont)) boolValue];
}

- (void)setNeedsUpdateFont:(BOOL)needsUpdate {
    objc_setAssociatedObject(self, @selector(needsUpdateFont), @(needsUpdate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"font"]) {
        self.needsUpdateFont = (change[NSKeyValueChangeNewKey] != nil);
    }
    [self updatePlaceholderLabel];
}


#pragma mark - Update

- (void)updatePlaceholderLabel {
    if (self.text.length) {
        [self.placeholderLabel removeFromSuperview];
        return;
    }
    
    [self insertSubview:self.placeholderLabel atIndex:0];
    
    if (self.needsUpdateFont) {
        self.placeholderLabel.font = self.font;
        self.needsUpdateFont = NO;
    }
    self.placeholderLabel.textAlignment = self.textAlignment;
    
    // `NSTextContainer` is available since iOS 7
    CGFloat lineFragmentPadding;
    UIEdgeInsets textContainerInset;
    
#pragma deploymate push "ignored-api-availability"
    // iOS 7+
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        lineFragmentPadding = self.textContainer.lineFragmentPadding;
        textContainerInset = self.textContainerInset;
    }
#pragma deploymate pop
    
    // iOS 6
    else {
        lineFragmentPadding = 5;
        textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
    }
    
    CGFloat x = lineFragmentPadding + textContainerInset.left;
    CGFloat y = textContainerInset.top;
    CGFloat width = CGRectGetWidth(self.bounds) - x - lineFragmentPadding - textContainerInset.right;
    CGFloat height = [self.placeholderLabel sizeThatFits:CGSizeMake(width, 0)].height;
    self.placeholderLabel.frame = CGRectMake(x, y, width, height);
}

@end

@interface ZLElectronicInvitationShareInvitationImportBar ()<UITextViewDelegate>

///输入框
@property (nonatomic,weak) UITextView *textView;
///键盘高度
@property (nonatomic,unsafe_unretained) CGFloat keyboardHeight;
///确认按钮
@property (nonatomic,weak) UIButton *sureButton;
///当前输入框
@property (nonatomic,weak) UITextView *currentTextView;

@end

@implementation ZLElectronicInvitationShareInvitationImportBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0.5);
        layer.backgroundColor = UIColor.lightGrayColor.CGColor;
        [self.layer addSublayer:layer];
        self.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, 40.0);
        [self textView];
        [self sureButton];
    }
    return self;
}

#pragma mark - Lazy
- (UITextView *)textView {
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 5.0, UIScreen.mainScreen.bounds.size.width - 80.0, self.frame.size.height - 10.0)];
        textView.layer.borderColor = UIColor.lightGrayColor.CGColor;
        textView.layer.borderWidth = 0.5;
        textView.layer.cornerRadius = 5.0;
        textView.font = [UIFont systemFontOfSize:15.0];
        textView.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        textView.delegate = self;
        textView.placeholder = @"<请输入内容>";
        [self addSubview:textView];
        _textView = textView;
    }
    return _textView;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        CGFloat width = 50.0;
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - width - 10.0, 5.0, width, CGRectGetHeight(self.textView.frame))];
        [sureButton setTitle:@"保存" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureButton];
        _sureButton = sureButton;
    }
    return _sureButton;
}

#pragma mark - Action
- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    CGFloat height = self.frame.size.height;
    CGSize size = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGPoint point = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin;
    CGFloat y = (point.y != UIScreen.mainScreen.bounds.size.height) ? UIScreen.mainScreen.bounds.size.height - size.height - height : UIScreen.mainScreen.bounds.size.height;
    self.frame = CGRectMake(0, y, self.frame.size.width, height);
    self.keyboardHeight = size.height;
    if (!self.currentTextView) {
        self.currentTextView = [UIResponder currentFirstResponder];
        self.textView.text = self.currentTextView.text;
        [self textView:self.textView shouldChangeTextInRange:NSMakeRange(self.textView.text.length, 0) replacementText:@""];
    }
    
    [self.textView becomeFirstResponder];
}
- (void)sureButtonAction {
    self.currentTextView.text = self.textView.text;
    [self shutDownKeyboard];
}
- (void)shutDownKeyboard {
    [self.textView resignFirstResponder];
    self.currentTextView = nil;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    CGFloat maxHeight = 80.0;
    NSString *value = [textView.text stringByAppendingString:text];
    CGFloat height = [value boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 80.0 , MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size.height;
    height =  height > maxHeight ? maxHeight : height;
    if (height <= maxHeight) {
        textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, height + 15.0);
        self.sureButton.frame = CGRectMake(self.sureButton.frame.origin.x, self.sureButton.frame.origin.y, self.sureButton.frame.size.width, CGRectGetHeight(textView.frame));
        self.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - self.keyboardHeight - CGRectGetHeight(self.textView.frame) - 10.0, UIScreen.mainScreen.bounds.size.width, CGRectGetHeight(self.textView.frame) + 10.0);
    }
    return YES;
}

@end
