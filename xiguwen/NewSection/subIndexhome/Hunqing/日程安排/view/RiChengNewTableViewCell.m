//
//  RiChengNewTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "RiChengNewTableViewCell.h"

@implementation RiChengNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAutoHeightWithBottomView:self.btmView bottomMargin:0];
}
- (void)setModel:(Newrichengarray *)model {
	
	// 给图片添加点击事件
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eidtStatus)];
	[self.imagew addGestureRecognizer:tap];
	
    _model = model;
    if (model.isend == 2) {
        self.imagew.image = [UIImage imageNamed:@"选择框"];
        self.content.textColor = RGBA(83, 83, 83, 1);
        self.time.textColor = RGBA(252, 88, 135, 1);
    }else {
        self.imagew.image = [UIImage imageNamed:@"已完成"];
        self.content.textColor = RGBA(137, 137, 137, 1);
        self.time.textColor = RGBA(179, 179, 179, 1);
    }
    self.content.text = model.conn;
    self.time.text = [NSString stringWithFormat:@"%@-%@",model.statime,model.endtime];
}

- (void)eidtStatus {
	self.onSendModel(self.model);
}

@end
