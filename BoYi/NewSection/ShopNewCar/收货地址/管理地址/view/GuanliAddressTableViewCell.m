//
//  GuanliAddressTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanliAddressTableViewCell.h"

@implementation GuanliAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Addressarray *)model {
    _model = model;
    if (model.hot) {
        NSAttributedString *str = [self showHot:[NSString stringWithFormat:@"[默认地址]%@",model.site]];
        self.address.attributedText = str;
    }else {
        self.address.text = model.site;
    }
    
    self.name.text = model.username;
    self.iphone.text = model.mobile;
}

- (NSAttributedString *)showHot:(NSString *)string {
    
    NSString *str = string;
    
    // 创建 NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    // 添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:MAINCOLOR
                    range:NSMakeRange(0, 6)];
    return attrStr;
    
}
@end
