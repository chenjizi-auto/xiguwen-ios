//
//  MyOfferTableViewCell.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyOfferTableViewCell.h"

@implementation MyOfferTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(MyOfferModel *)model {
    _model = model;
    self.name.text = model.name;
    self.price.text = [NSString stringWithFormat:@"￥%ld",model.currentPrice];
    
    //不传值则查询全部 ；1：待审核 2： 已审核 3：已上架 4：已下架
    //status=-1 显示上架   status=1显示下架
//    switch (model.status) {
//        case 2: {
//            self.eventBtn.hidden = NO;
//            [self.eventBtn setTitle:@"上架" forState:UIControlStateNormal];
//        }
//            break;
//        case 3: {
//            self.eventBtn.hidden = NO;
//            [self.eventBtn setTitle:@"下架" forState:UIControlStateNormal];
//        }
//            break;
//        case 4: {
//            self.eventBtn.hidden = NO;
//            [self.eventBtn setTitle:@"上架" forState:UIControlStateNormal];
//        }
//            break;
//            
//        default:
//            self.eventBtn.hidden = YES;
//            break;
//    }
    
    if (model.status == -1) {
        self.eventBtn.hidden = NO;
        [self.eventBtn setTitle:@"上架" forState:UIControlStateNormal];
    } else if (model.status == 1) {
        self.eventBtn.hidden = NO;
        [self.eventBtn setTitle:@"下架" forState:UIControlStateNormal];
    } else {
        self.eventBtn.hidden = YES;
    }
}
@end
