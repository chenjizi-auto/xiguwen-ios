//
//  FindTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FindTableViewCell.h"

@implementation FindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    
}

- (void)setModel:(Rows *)model{
    
    _model = model;
    
    [self.cover sd_setImageWithUrl:String(ImageHomeURL,model.imgUrl) placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.name;
    [self.price setTitle:[[NSString stringWithFormat:@"%@",model.caseDetail] isBlankString] ? @"¥ 0" : [NSString stringWithFormat:@"¥%@",model.caseDetail] forState:UIControlStateNormal];
    if (model.follow) {
        [self.price setImage:[UIImage imageNamed:@"形状-522"] forState:UIControlStateNormal];
    }else {
        [self.price setImage:[UIImage imageNamed:@"ifashion喜欢"] forState:UIControlStateNormal];
    }
    
}

@end
