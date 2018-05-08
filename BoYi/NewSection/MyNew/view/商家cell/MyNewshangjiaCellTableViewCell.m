//
//  MyNewshangjiaCellTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewshangjiaCellTableViewCell.h"
@implementation MyNewshangjiaCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hunqinImage = @[@"婚庆接单 全部订单",@"婚庆接单 待付款",@"婚庆接单 待接单",@"婚庆接单 待服务",@"婚庆接单 待评价"];
    self.shangchengImage = @[@"商城接单 全部订单",@"商城接单 待付款",@"商城接单 待发货",@"商城接单 待收货",@"商城接单 待评价"];
}
- (IBAction)action:(UIButton *)sender {
    [self.gotoNextVc sendNext:@(sender.tag)];
//    
//    if (sender.tag == 1) {
//        self.hunqinDingLabel.textColor = MAINCOLOR;
//        self.hunqinDingView.hidden = NO;
//        self.shangChengDinglabel.textColor = RGBA(83, 83, 83, 1);
//        self.shangChengDingView.hidden = YES;
//        UIView *btnSubViewfather = [self viewWithTag:1000];
//        for (int i  = 0; i < 5; i++) {
//            
//            UIView *btnSubView = [btnSubViewfather viewWithTag:100 + i];
//            UIImageView *image = (UIImageView *)[btnSubView viewWithTag:0];
//            image.image = [UIImage imageNamed:self.hunqinImage[i]];
//            UILabel *label = (UILabel *)[btnSubView viewWithTag:201];
//            if (i == 2) {
//                label.text = @"待接单";
//            }if (i == 3) {
//                label.text = @"待服务";
//            }
//            
//        }
//    }
//    if (sender.tag == 2) {
//        self.hunqinDingLabel.textColor = RGBA(83, 83, 83, 1);
//        self.hunqinDingView.hidden = YES;
//        self.shangChengDinglabel.textColor = MAINCOLOR;
//        self.shangChengDingView.hidden = NO;
//        UIView *btnSubViewfather = [self viewWithTag:1000];
//        for (int i  = 0; i < 5; i++) {
//            
//            UIView *btnSubView = [btnSubViewfather viewWithTag:100 + i];
//            UIImageView *image = (UIImageView *)[btnSubView viewWithTag:0];
//            UILabel *label = (UILabel *)[btnSubView viewWithTag:201];
//            image.image = [UIImage imageNamed:self.shangchengImage[i]];
//            if (i == 2) {
//                label.text = @"待发货";
//            }if (i == 3) {
//                label.text = @"待收货";
//            }
//        }
//    }
    
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
