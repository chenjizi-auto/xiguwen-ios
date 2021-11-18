//
//  InstituteAuthCell.m
//  BoYi
//
//  Created by Niklaus on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "InstituteAuthCell.h"

@interface InstituteAuthCell ()


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation InstituteAuthCell

#pragma mark - Setters and getters
- (UIImageView *)levelImage {
	if (!_levelImage) {
		_levelImage = [[UIImageView alloc] init];
	}
	return _levelImage;
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
	}
	return _titleLabel;
}

- (UILabel *)markLabel {
	if (!_markLabel) {
		_markLabel = [[UILabel alloc] init];
		[_markLabel setFont: [UIFont systemFontOfSize:14.0f]];
		[_markLabel setTextColor:UIColorFromRGB(0x898989)];
	}
	return _markLabel;
}

- (UIButton *)submitBtn {
	if (!_submitBtn) {
		_submitBtn = [[UIButton alloc] init];
		[_submitBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
		[_submitBtn setTitleColor:UIColorFromRGB(0xFC5887) forState:(UIControlStateNormal)];
		[_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _submitBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		[self.contentView addSubview: self.levelImage];
		self.levelImage.sd_layout
		.topSpaceToView(self.contentView, 15.0f)
		.leftSpaceToView(self.contentView, 15.0f)
		.widthIs(30.0f)
		.heightIs(20.0f);
		
		[self.contentView addSubview: self.titleLabel];
		self.titleLabel.sd_layout
		.centerYEqualToView(self.levelImage)
		.leftSpaceToView(self.levelImage, 10.0f)
		.heightIs(20.0f);
		[self.titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth/2];
		
		[self.contentView addSubview: self.submitBtn];
		self.submitBtn.sd_layout
		.centerYEqualToView(self.levelImage)
		.rightSpaceToView(self.contentView, 15.0f)
		.widthIs(80.0f)
		.heightIs(30.0f);
		
		
		[self.contentView addSubview: self.markLabel];
		self.markLabel.sd_layout
		.centerYEqualToView(self.titleLabel)
		.leftSpaceToView(self.titleLabel, 5.0f)
		.rightSpaceToView(self.submitBtn, 10.0f)
		.heightIs(20.0f);
		
		[self setupAutoHeightWithBottomView:self.levelImage bottomMargin:15.0f];
        
        [self.submitBtn.layer setCornerRadius:2.0f];
        [self.submitBtn.layer setMasksToBounds: YES];
        [self.submitBtn.layer setBorderColor:UIColorFromRGB(0xFF7299).CGColor];
        [self.submitBtn.layer setBorderWidth:0.5f];
	}
	return self;
}

#pragma mark - updateView
- (void)updateViewWithModel:(InstituteAuth *)model {
	[self.titleLabel setText: model.parameter1];
	if (model.state == 4) {
		[self.markLabel setText: @"已缴费，未提交材料"];
    } else if (model.state == 2) {
        [self.markLabel setText:model.content];
    }
    else {
        [self.markLabel setText: @""];
    }
	if (model.state == 0) {
		[self.submitBtn setTitle: @"立即认证" forState:(UIControlStateNormal)];
	} else if (model.state == 1) {
		[self.submitBtn setTitle: @"认证通过" forState:(UIControlStateNormal)];
	} else if (model.state == 2) {
		[self.submitBtn setTitle: @"修改提交" forState:(UIControlStateNormal)];
	} else if (model.state == 3) {
		[self.submitBtn setTitle: @"审核中" forState:(UIControlStateNormal)];
	} else if (model.state == 4) {
		[self.submitBtn setTitle: @"待提交资料" forState:(UIControlStateNormal)];
	}
}

- (void)submitBtnClick {
	self.submitClick();
}

@end
