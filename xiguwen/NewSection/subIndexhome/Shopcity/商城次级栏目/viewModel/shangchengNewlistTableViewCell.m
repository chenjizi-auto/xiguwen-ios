//
//  shangchengNewlistTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "shangchengNewlistTableViewCell.h"

@implementation shangchengNewlistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Guanggaoarray *)model {
    _model = model;
    [self.imagew sd_setImageWithUrl:model.wapimg placeHolder:[UIImage imageNamed:@"占位图片"]];
    
    
    self.tiele.text = model.title;
    self.price.text = [NSString stringWithFormat:@"¥%@",model.price];
}
@end
