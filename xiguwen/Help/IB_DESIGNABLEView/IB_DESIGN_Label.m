//
//  IB_DESIGN_Label.m
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "IB_DESIGN_Label.h"

IB_DESIGNABLE

@implementation IB_DESIGN_Label

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
-(void)awakeFromNib{
    [super awakeFromNib];

}
- (void)setAttrString:(NSString *)AttrString {
    
    _AttrString         = AttrString;
    self.attributedText = [self attString:AttrString];
}
- (NSAttributedString *)attString:(NSString *)string {
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange contentRange               = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    return content;
}
@end
