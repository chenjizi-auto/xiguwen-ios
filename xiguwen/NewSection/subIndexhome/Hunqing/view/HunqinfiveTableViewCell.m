//
//  HunqinfiveTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/7.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "HunqinfiveTableViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>
@implementation HunqinfiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (int i  = 0; i < 6; i++) {
        
        UIButton *btn = (UIButton *)[self viewWithTag:100 + i];
        @weakify(self);
        //点击
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            
            [self.gotoNextVc sendNext:@(i)];
            
        }];
    }
}
- (void)setRemenhuodong:(Remenhuodong *)remenhuodong{
    _remenhuodong = remenhuodong;
//    self.lab1.text = remenhuodong.rmhd1.title;
//    self.lab2.text = remenhuodong.rmhd2.title;
//    self.lab3.text = remenhuodong.rmhd3.title;
//    self.lab4.text = remenhuodong.rmhd4.title;
//    self.lab5.text = remenhuodong.rmhd5.title;
//    
//    self.labb1.text = remenhuodong.rmhd1.miaoshu;
//    self.labb2.text = remenhuodong.rmhd2.miaoshu;
//    self.labb3.text = remenhuodong.rmhd3.miaoshu;
//    self.labb4.text = remenhuodong.rmhd4.miaoshu;
//    self.labb5.text = remenhuodong.rmhd5.miaoshu;
    
    [self.btn1 sd_setImageWithURL:URL(remenhuodong.rmhd1.wapimg) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.btn2 sd_setImageWithURL:URL(remenhuodong.rmhd2.wapimg) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.btn3 sd_setImageWithURL:URL(remenhuodong.rmhd3.wapimg) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.btn4 sd_setImageWithURL:URL(remenhuodong.rmhd4.wapimg) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.btn5 sd_setImageWithURL:URL(remenhuodong.rmhd5.wapimg) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"占位图片"]];
}
//- (void)setXiaoguanggaoyi:(Xiaoguanggaoyi *)xiaoguanggaoyi{
//    _xiaoguanggaoyi = xiaoguanggaoyi;
//    [self.guanggaoImage sd_setImageWithURL:URL(xiaoguanggaoyi.wapimg) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"占位图片"]];
//}
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
