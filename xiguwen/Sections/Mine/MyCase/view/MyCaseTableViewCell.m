//
//  MyCaseTableViewCell.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyCaseTableViewCell.h"

@implementation MyCaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MyCaseModel *)model {
    _model = model;
    
    [self.cover sd_setImageWithUrl:ImageAppendURL(model.imgUrl)];
    self.name.text = model.name;
    if (!model.caseDetail || model.caseDetail.length == 0) {
        self.price.text = @"￥0";
    } else {
        
        self.price.text = [NSString stringWithFormat:@"￥%@",model.caseDetail];
    }
    
    
    if (model.status == 3 || model.status == 2 || model.status == 1 || model.status == 0) {
        self.eventBtn.hidden = NO;
    } else {
        self.eventBtn.hidden = YES;
    }
    
    switch (model.status) {
            case 0:
        {
            [self.eventBtn setTitle:@"提交" forState:UIControlStateNormal];
        }
            break;
            case 1:
        {
            [self.eventBtn setTitle:@"上架" forState:UIControlStateNormal];
        }
            break;
            case 2:
        {
            [self.eventBtn setTitle:@"下架" forState:UIControlStateNormal];
        }
            break;
            case 3:
        {
            [self.eventBtn setTitle:@"上架" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
}

@end
