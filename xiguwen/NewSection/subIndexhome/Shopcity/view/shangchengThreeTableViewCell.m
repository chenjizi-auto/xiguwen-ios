//
//  shangchengThreeTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "shangchengThreeTableViewCell.h"

@implementation shangchengThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(Remenshangpinsc *)model {
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];

    [self.guanzhuBTN setImage:[UIImage imageNamed:model.afollow == 1 ? @"取消关注":@"加关注"] forState:UIControlStateNormal];
    
 
    self.title.text = model.shopname;
    self.price.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.name.text = model.nickname;
    self.name.text = model.nickname;
    self.like.text = [NSString stringWithFormat:@"%ld人喜欢",model.follows];
    if (model.shopimg.count == 0) {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
    }else if (model.shopimg.count == 1) {
        [self.image1 sd_setImageWithUrl:model.shopimg[0] placeHolder:[UIImage imageNamed:@"头像"]];
        self.image2.hidden = YES;
        self.image3.hidden = YES;
    }else if (model.shopimg.count == 2) {
        [self.image1 sd_setImageWithUrl:model.shopimg[0] placeHolder:[UIImage imageNamed:@"头像"]];
        [self.image2 sd_setImageWithUrl:model.shopimg[1] placeHolder:[UIImage imageNamed:@"头像"]];
        self.image3.hidden = YES;
    }else {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        [self.image1 sd_setImageWithUrl:model.shopimg[0] placeHolder:[UIImage imageNamed:@"头像"]];
        [self.image2 sd_setImageWithUrl:model.shopimg[1] placeHolder:[UIImage imageNamed:@"头像"]];
        [self.image3 sd_setImageWithUrl:model.shopimg[2] placeHolder:[UIImage imageNamed:@"头像"]];
    }
}

@end
