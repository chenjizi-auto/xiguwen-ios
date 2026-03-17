//
//  MyOrderTableViewCell.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(MyOrderModel *)model {
    _model = model;
    
//    [self.Cover sd_setImageWithUrl:ImageAppendURL(model.detailInfoBvoList.firstObject.bizUser.avatar)];
    self.name.text = model.detailInfoBvoList.firstObject.byUserBizProduct.name;
    self.allPrice.text = [NSString stringWithFormat:@"%.1f",model.bizUser.bizPrice];
    self.offerPrice.text = [NSString stringWithFormat:@"%.1f",model.detailInfoBvoList.firstObject.deposit];
    self.countLabel.text = S_Integer(model.detailInfoBvoList.firstObject.amount);
}

@end
