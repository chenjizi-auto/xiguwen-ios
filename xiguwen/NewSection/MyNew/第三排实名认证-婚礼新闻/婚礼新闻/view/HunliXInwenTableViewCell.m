//
//  HunliXInwenTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunliXInwenTableViewCell.h"

@implementation HunliXInwenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(HunliXInwenModel *)model {
    _model = model;
	self.titleLabel.text = model.title;
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.createtime];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	self.timeLabel.text = [formatter stringFromDate:date];;
	[self.showImage sd_setImageWithUrl:model.img placeHolder:[UIImage imageNamed:@"占位图片"]];
}
@end
