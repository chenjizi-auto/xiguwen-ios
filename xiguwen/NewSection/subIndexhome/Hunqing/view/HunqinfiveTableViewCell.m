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

    [self resetHotActivityContent];
    
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

- (void)prepareForReuse {
    [super prepareForReuse];
    [self resetHotActivityContent];
    self.remenhuodong = nil;
}

- (void)setRemenhuodong:(Remenhuodong *)remenhuodong{
    _remenhuodong = remenhuodong;
    [self configureButton:self.btn1
                    titleLabel:self.lab1
             descriptionLabel:self.labb1
                        model:remenhuodong.rmhd1
                 defaultImage:@"活动1"];
    [self configureButton:self.btn2
                    titleLabel:self.lab2
             descriptionLabel:self.labb2
                        model:remenhuodong.rmhd2
                 defaultImage:@"活动2"];
    [self configureButton:self.btn3
                    titleLabel:self.lab3
             descriptionLabel:self.labb3
                        model:remenhuodong.rmhd3
                 defaultImage:@"活动3"];
    [self configureButton:self.btn4
                    titleLabel:self.lab4
             descriptionLabel:self.labb4
                        model:remenhuodong.rmhd4
                 defaultImage:@"活动4"];
    [self configureButton:self.btn5
                    titleLabel:self.lab5
             descriptionLabel:self.labb5
                        model:remenhuodong.rmhd5
                 defaultImage:@"活动5"];
}

- (void)resetHotActivityContent {
    [self resetButton:self.btn1 titleLabel:self.lab1 descriptionLabel:self.labb1 defaultImage:@"活动1"];
    [self resetButton:self.btn2 titleLabel:self.lab2 descriptionLabel:self.labb2 defaultImage:@"活动2"];
    [self resetButton:self.btn3 titleLabel:self.lab3 descriptionLabel:self.labb3 defaultImage:@"活动3"];
    [self resetButton:self.btn4 titleLabel:self.lab4 descriptionLabel:self.labb4 defaultImage:@"活动4"];
    [self resetButton:self.btn5 titleLabel:self.lab5 descriptionLabel:self.labb5 defaultImage:@"活动5"];
}

- (void)resetButton:(UIButton *)button
         titleLabel:(UILabel *)titleLabel
   descriptionLabel:(UILabel *)descriptionLabel
       defaultImage:(NSString *)defaultImageName {
    UIImage *defaultImage = [UIImage imageNamed:defaultImageName];
    [button sd_cancelImageLoadForState:UIControlStateNormal];
    [button sd_cancelBackgroundImageLoadForState:UIControlStateNormal];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:defaultImage forState:UIControlStateNormal];
    titleLabel.hidden = YES;
    descriptionLabel.hidden = YES;
    titleLabel.text = @"";
    descriptionLabel.text = @"";
}

- (void)configureButton:(UIButton *)button
             titleLabel:(UILabel *)titleLabel
       descriptionLabel:(UILabel *)descriptionLabel
                  model:(id)model
           defaultImage:(NSString *)defaultImageName {
    UIImage *defaultImage = [UIImage imageNamed:defaultImageName];
    NSString *title = [self safeStringFromValue:[model valueForKey:@"title"]];
    NSString *descriptionText = [self safeStringFromValue:[model valueForKey:@"miaoshu"]];
    NSString *imageURLString = [self safeStringFromValue:[model valueForKey:@"wapimg"]];
    
    titleLabel.text = title;
    descriptionLabel.text = descriptionText;
    titleLabel.hidden = title.length == 0;
    descriptionLabel.hidden = descriptionText.length == 0;
    
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setImage:nil forState:UIControlStateNormal];
    [button sd_setBackgroundImageWithURL:URL(imageURLString)
                                forState:UIControlStateNormal
                        placeholderImage:defaultImage];
}

- (NSString *)safeStringFromValue:(id)value {
    if (![value isKindOfClass:[NSString class]]) {
        return @"";
    }
    return [NSStringFormatter((NSString *)value) isBlankString] ? @"" : NSStringFormatter((NSString *)value);
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
