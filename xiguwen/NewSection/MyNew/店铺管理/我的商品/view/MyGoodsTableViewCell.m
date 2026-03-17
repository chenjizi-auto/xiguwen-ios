//
//  MyGoodsTableViewCell.m
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyGoodsTableViewCell.h"

@interface MyGoodsTableViewCell ()

@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *statusImg;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MyGoodsTableViewCell

#pragma mark - Setters and getters
- (UIImageView *)headerImg {
	if (!_headerImg) {
		_headerImg = [[UIImageView alloc] init];
		[_headerImg setContentMode:UIViewContentModeScaleAspectFit];
	}
	return _headerImg;
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
	}
	return _titleLabel;
}

- (UILabel *)priceLabel {
	if (!_priceLabel) {
		_priceLabel = [[UILabel alloc] init];
		[_priceLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_priceLabel setTextColor:UIColorFromRGB(0xFC5887)];
	}
	return _priceLabel;
}

- (UIImageView *)statusImg {
	if (!_statusImg) {
		_statusImg = [[UIImageView alloc] init];
		[_statusImg setContentMode:UIViewContentModeScaleAspectFit];
	}
	return _statusImg;
}

- (UIView *)lineView {
	if (!_lineView) {
		_lineView = [[UIView alloc] init];
		[_lineView setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _lineView;
}

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		[self.contentView addSubview:self.headerImg];
		self.headerImg.sd_layout
		.centerYEqualToView(self.contentView)
		.leftSpaceToView(self.contentView, 15.0f)
		.widthIs(60.0f)
		.heightEqualToWidth();
		
		[self.contentView addSubview: self.titleLabel];
		self.titleLabel.sd_layout
		.leftSpaceToView(self.headerImg, 15.0f)
		.rightSpaceToView(self.contentView, 45.0f)
		.topSpaceToView(self.contentView, 10.0f)
		.heightIs(20.0f);
		
		[self.contentView addSubview: self.priceLabel];
		self.priceLabel.sd_layout
		.leftSpaceToView(self.headerImg, 15.0f)
		.rightSpaceToView(self.contentView, 15.0f)
		.bottomSpaceToView(self.contentView, 10.0f)
		.heightIs(20.0f);
		
		[self.contentView addSubview: self.statusImg];
		self.statusImg.sd_layout
		.topSpaceToView(self.contentView, 0.0f)
		.rightSpaceToView(self.contentView, 0.0f)
		.widthIs(45.0f)
		.heightIs(40.0f);
		
		[self.contentView addSubview:self.lineView];
		self.lineView.sd_layout
		.bottomSpaceToView(self.contentView, 0.0f)
		.leftSpaceToView(self.contentView, 0.0f)
		.rightSpaceToView(self.contentView, 0.0f)
		.heightIs(1.0f);
	}
	return self;
}

- (void)setModel:(MyGoodsModel *)model {
	_model = model;
	[self.headerImg sd_setImageWithUrl:model.shopimg[0]];
	[self.titleLabel setText: model.shopname];
	[self.priceLabel setText: [NSString stringWithFormat:@"¥%@起",model.price]];
	if (model.state == 1) {
		[self.statusImg setImage:[UIImage imageNamed: @"审核中"]];
	} else if (model.state == 2) {
		if (model.status == 1) {
			[self.statusImg setImage:[UIImage imageNamed: @"已上架"]];
		} else {
			[self.statusImg setImage:[UIImage imageNamed: @"未上架"]];
		}
	} else if (model.state == 3) {
		[self.statusImg setImage:[UIImage imageNamed: @"未通过"]];
	}
}

@end
