//
//  ZuoPinCollectionViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ZuoPinCollectionViewCell.h"

@implementation ZuoPinCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(Rows *)model{
    _model = model;

    [[NSString stringWithFormat:@"%@",model.imgUrl] isBlankString] ? @"" : [self.image sd_setImageWithUrl:String(ImageHomeURL,model.imgUrl) placeHolder:[UIImage imageNamed:@"占位图片"]];
}

@end
