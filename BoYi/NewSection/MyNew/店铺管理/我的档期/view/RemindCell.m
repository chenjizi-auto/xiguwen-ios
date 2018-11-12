//
//  RemindCell.m
//  BoYi
//
//  Created by Niklaus on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "RemindCell.h"

@interface RemindCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *timeImg;

@end

@implementation RemindCell

- (UILabel *)timeLabel {
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc] init];
		[_timeLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[_timeLabel setTextColor:UIColorFromRGB(0xFC7017)];
	}
	return _timeLabel;
}

- (UIImageView *)timeImg {
	if (!_timeImg) {
		_timeImg = [[UIImageView alloc] init];
		[_timeImg setImage:[UIImage imageNamed: @"档期 提醒"]];
	}
	return _timeImg;
}

- (UIButton *)deleteBtn {
	if (!_deleteBtn) {
		_deleteBtn = [[UIButton alloc] init];
		[_deleteBtn setImage:[UIImage imageNamed: @"删除图片"] forState:(UIControlStateNormal)];
		[_deleteBtn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _deleteBtn;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// 时间显示
		[self.contentView addSubview: self.timeLabel];
		self.timeLabel.sd_layout
		.topSpaceToView(self.contentView, 0.0f)
		.centerXEqualToView(self.contentView)
		.heightIs(40.0f);
		[self.timeLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
		
		// 图片显示
		[self.contentView addSubview: self.timeImg];
		self.timeImg.sd_layout
		.centerYEqualToView(self.timeLabel)
		.rightSpaceToView(self.timeLabel, 5.0f)
		.widthIs(20.0f)
		.heightIs(20.0f);
		
		
		[self.contentView addSubview: self.deleteBtn];
		self.deleteBtn.sd_layout
		.centerYEqualToView(self.timeLabel)
		.rightSpaceToView(self.contentView, 15.0f)
		.widthIs(30.0f)
		.heightEqualToWidth();
//		[self.deleteBtn setHidden: self.isDeleteHidden];
	}
	return self;
}

- (void)updateViewWithModel:(RemindDetailsModel *)model {
	[self.timeLabel setText:model.hunlishijian];
}

- (void)deleteButtonClick:(UIButton *)sender {
	// 删除提醒
	self.onDidSelected();
}

@end
