//
//  StockTableViewCell.m
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "StockTableViewCell.h"

@interface StockTableViewCell ()

@property (nonatomic, strong) UILabel *typeOne;
@property (nonatomic, strong) UILabel *typeTwo;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation StockTableViewCell

- (UILabel *)typeOne {
	if (!_typeOne) {
		_typeOne = [[UILabel alloc] init];
		[_typeOne setFont:[UIFont systemFontOfSize:16.0f]];
		[_typeOne setTextAlignment:NSTextAlignmentCenter];
	}
	return _typeOne;
}
- (UILabel *)typeTwo {
	if (!_typeTwo) {
		_typeTwo = [[UILabel alloc] init];
		[_typeTwo setFont:[UIFont systemFontOfSize:16.0f]];
		[_typeTwo setTextAlignment:NSTextAlignmentCenter];
	}
	return _typeTwo;
}
- (UILabel *)priceLabel {
	if (!_priceLabel) {
		_priceLabel = [[UILabel alloc] init];
		[_priceLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_priceLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _priceLabel;
}
- (UILabel *)numberLabel {
	if (!_numberLabel) {
		_numberLabel = [[UILabel alloc] init];
		[_numberLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_numberLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _numberLabel;
}
- (UIView *)lineView {
	if (!_lineView) {
		_lineView = [[UIView alloc] init];
		[_lineView setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _lineView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		[self.contentView addSubview:self.typeOne];
		self.typeOne.sd_layout
		.topSpaceToView(self.contentView, 0.0f)
		.leftSpaceToView(self.contentView, 0.0f)
		.widthIs(ScreenWidth/4)
		.heightIs(50.0f);
		
		[self.contentView addSubview:self.typeTwo];
		self.typeTwo.sd_layout
		.topSpaceToView(self.contentView, 0.0f)
		.leftSpaceToView(self.typeOne, 0.0f)
		.widthIs(ScreenWidth/4)
		.heightIs(50.0f);
		
		[self.contentView addSubview:self.priceLabel];
		self.priceLabel.sd_layout
		.topSpaceToView(self.contentView, 0.0f)
		.leftSpaceToView(self.typeTwo, 0.0f)
		.widthIs(ScreenWidth/4)
		.heightIs(50.0f);
		
		[self.contentView addSubview:self.numberLabel];
		self.numberLabel.sd_layout
		.topSpaceToView(self.contentView, 0.0f)
		.leftSpaceToView(self.priceLabel, 0.0f)
		.widthIs(ScreenWidth/4)
		.heightIs(50.0f);
		
		[self.contentView addSubview: self.lineView];
		self.lineView.sd_layout
		.bottomSpaceToView(self.contentView, 0.0f)
		.leftSpaceToView(self.contentView, 0.0f)
		.rightSpaceToView(self.contentView, 0.0f)
		.heightIs(1.0f);
	}
	return self;
}

- (void)updateViewWithModel:(SkuModel *)model {
	[self.typeOne setText:model.sku1name];
	[self.typeTwo setText: model.sku2name];
	[self.priceLabel setText:model.prices];
	[self.numberLabel setText: model.number];
	
}


@end
