//
//  UItextViewWithPlaceHloder.m
//  Sahara
//
//  Created by bodecn on 15/10/28.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "UItextViewWithPlaceHloder.h"
IB_DESIGNABLE
@implementation UItextViewWithPlaceHloder {
    BOOL _shouldDrawPlaceholder;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor{
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}

#pragma mark - 重写父类方法
- (void)setText:(NSString *)text {
    [super setText:text];
    [self drawPlaceholder];
    return;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (![placeholder isEqual:_placeholder]) {
        _placeholder = placeholder;
        [self drawPlaceholder];
    }
    return;
}

#pragma mark - 父类方法
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureBase];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureBase];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_shouldDrawPlaceholder) {
        super.backgroundColor = [UIColor whiteColor];
//        [_placeholderTextColor set];
        [_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f,self.frame.size.height - 16.0f) withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:[UIColor colorWithWhite:0.702f alpha:1.0f]}];
        
//        [_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f,self.frame.size.height - 16.0f) withAttributes:[UItextViewWithPlaceHloder setAttributesWithFontSize:13 WithTextColor:[UIColor colorWithWhite:0.702f alpha:1.0f] WithAlignment:NSTextAlignmentLeft]];
    }
    return;
}

+(NSDictionary *)setAttributesWithFontSize:(NSInteger)size WithTextColor:(UIColor *)color WithAlignment:(NSTextAlignment)alignment
{
    
    NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    paragraphStyle.alignment = alignment;
    
    NSDictionary *attributes= [NSDictionary dictionaryWithObjectsAndKeys:
                               
                               [UIFont systemFontOfSize:size], NSFontAttributeName,
                               
                               paragraphStyle,NSParagraphStyleAttributeName,color,NSForegroundColorAttributeName,[UIColor blackColor],NSStrokeColorAttributeName,[NSNumber numberWithFloat:2.0],NSStrokeWidthAttributeName,nil];
    
    return attributes;
    
}
- (void)configureBase {
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(textChanged:)
                                name:UITextViewTextDidChangeNotification
                              object:self];
    
    self.placeholderTextColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    _shouldDrawPlaceholder = NO;
    return;
}

- (void)drawPlaceholder {
//    BOOL prev = _shouldDrawPlaceholder;
    
    _shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
    [self setNeedsDisplay];
    
//    if (prev != _shouldDrawPlaceholder) {
//        [self setNeedsDisplay];
//    }
    return;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    _shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.attributedText.length == 0;
    [self setNeedsDisplay];
}

- (void)textChanged:(NSNotification *)notification {
    [self drawPlaceholder];
    return;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    return;
}

@end
