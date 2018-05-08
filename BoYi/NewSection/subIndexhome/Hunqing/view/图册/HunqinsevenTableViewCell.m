//
//  HunqinsevenTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "HunqinsevenTableViewCell.h"
#import "SJAvatarBrowser.h"
@implementation HunqinsevenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bigImage.userInteractionEnabled = YES;
    self.bigImageTwo.userInteractionEnabled = YES;
    self.bigImagethree.userInteractionEnabled = YES;
    //添加手势  
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    [self.bigImage addGestureRecognizer:tap];
//    [self.bigImageTwo addGestureRecognizer:tap1];
//    [self.bigImagethree addGestureRecognizer:tap2];
    [self setupAutoHeightWithBottomView:self.btmView bottomMargin:10];
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [SJAvatarBrowser showImage:(UIImageView *)tap.view];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Youlike *)model{
    _model = model;
    
    [self.headrImage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    if (model.photourl.count == 0) {
        [self.bigImage sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
        self.bigImageTwo.hidden = YES;
        self.bigImagethree.hidden = YES;
    }else if (model.photourl.count == 1) {
        [self.bigImage sd_setImageWithUrl:model.photourl[0].photo placeHolder:[UIImage imageNamed:@"占位图片"]];
        
        self.bigImageTwo.hidden = YES;
        self.bigImagethree.hidden = YES;
    }else if (model.photourl.count == 2) {
        [self.bigImage sd_setImageWithUrl:model.photourl[0].photo placeHolder:[UIImage imageNamed:@"占位图片"]];
        [self.bigImageTwo sd_setImageWithUrl:model.photourl[1].photo placeHolder:[UIImage imageNamed:@"占位图片"]];
        self.bigImageTwo.hidden = NO;
        self.bigImagethree.hidden = YES;
    }else {
        [self.bigImage sd_setImageWithUrl:model.photourl[0].photo placeHolder:[UIImage imageNamed:@"占位图片"]];
        [self.bigImageTwo sd_setImageWithUrl:model.photourl[1].photo placeHolder:[UIImage imageNamed:@"占位图片"]];
        [self.bigImagethree sd_setImageWithUrl:model.photourl[2].photo placeHolder:[UIImage imageNamed:@"占位图片"]];
        self.bigImageTwo.hidden = NO;
        self.bigImagethree.hidden = NO;
    }
    self.name.text = model.nickname;
    if (model.follow == 1) {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
    }else {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];
        
    }
    self.qianming.text = model.title;
    self.jianjie.text = model.weddingdescribe;
    self.liulanNumber.text = [NSString stringWithFormat:@"%ld",model.followed];
    self.guanzhuNumber.text = [NSString stringWithFormat:@"%ld",model.clicked];
    self.occupationid.text = model.occupationid;
}

@end
