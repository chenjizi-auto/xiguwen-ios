//
//  MyDemandCell.m
//  BoYi
//
//  Created by Niklaus on 2018/3/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyDemandCell.h"

@interface MyDemandCell ()

@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *browseLabel;
@property (nonatomic, strong) UILabel *joinLabel;
@property (nonatomic, strong) UILabel *remainingLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MyDemandCell

#pragma mark - Setters and getters
- (UILabel *)titlelabel {
	if (!_titlelabel) {
		_titlelabel = [[UILabel alloc] init];
		[_titlelabel setFont:[UIFont systemFontOfSize:16.0f]];
	}
	return _titlelabel;
}

- (UILabel *)priceLabel {
	if (!_priceLabel) {
		_priceLabel = [[UILabel alloc] init];
		[_priceLabel setFont: [UIFont systemFontOfSize:16.0f]];
		[_priceLabel setTextColor: UIColorFromRGB(0xFC5887)];
	}
	return _priceLabel;
}

- (UILabel *)timeLabel {
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc] init];
		[_timeLabel setFont: [UIFont systemFontOfSize:13.0f]];
		[_timeLabel setTextColor: UIColorFromRGB(0x898989)];
	}
	return _timeLabel;
}

- (UILabel *)browseLabel {
	if (!_browseLabel) {
		_browseLabel = [[UILabel alloc] init];
		[_browseLabel setFont: [UIFont systemFontOfSize:13.0f]];
		[_browseLabel setTextColor: UIColorFromRGB(0x898989)];
		[_browseLabel setTextAlignment: NSTextAlignmentCenter];
	}
	return _browseLabel;
}

- (UILabel *)joinLabel {
	if (!_joinLabel) {
		_joinLabel = [[UILabel alloc] init];
		[_joinLabel setFont: [UIFont systemFontOfSize:13.0f]];
		[_joinLabel setTextColor: UIColorFromRGB(0x898989)];
		[_joinLabel setTextAlignment: NSTextAlignmentRight];
	}
	return _joinLabel;
}

- (UILabel *)remainingLabel {
	if (!_remainingLabel) {
		_remainingLabel = [[UILabel alloc] init];
		[_remainingLabel setFont: [UIFont systemFontOfSize:13.0f]];
		[_remainingLabel setTextColor: UIColorFromRGB(0xF79C23)];
	}
	return _remainingLabel;
}

- (UILabel *)addressLabel {
	if (!_addressLabel) {
		_addressLabel = [[UILabel alloc] init];
		[_addressLabel setFont: [UIFont systemFontOfSize:13.0f]];
		[_addressLabel setTextColor:UIColorFromRGB(0x898989)];
		[_addressLabel setTextAlignment: NSTextAlignmentRight];
	}
	return _addressLabel;
}

- (UIView *)lineView {
	if (!_lineView) {
		_lineView = [[UIView alloc] init];
		[_lineView setBackgroundColor: UIColorFromRGB(0xD9D9D9)];
	}
	return _lineView;
}

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		[self.contentView addSubview: self.titlelabel];
		self.titlelabel.sd_layout
		.topSpaceToView(self.contentView, 15.0f)
		.leftSpaceToView(self.contentView, 15.0f)
		.rightSpaceToView(self.contentView, 15.0f)
		.heightIs(20.0f);
		
		[self.contentView addSubview: self.priceLabel];
		self.priceLabel.sd_layout
		.topSpaceToView(self.titlelabel, 10.0f)
		.leftSpaceToView(self.contentView, 15.0f)
		.rightSpaceToView(self.contentView, 15.0f)
		.heightIs(15.0f);
		
		[self.contentView addSubview: self.timeLabel];
		self.timeLabel.sd_layout
		.topSpaceToView(self.priceLabel, 10.0f)
		.leftSpaceToView(self.contentView, 15.0f)
		.widthIs(ScreenWidth/2)
		.heightIs(15.0f);
		
		[self.contentView addSubview: self.joinLabel];
		self.joinLabel.sd_layout
		.centerYEqualToView(self.timeLabel)
		.rightSpaceToView(self.contentView, 15.0f)
		.widthIs(60.0f)
		.heightIs(15.0f);
		
		[self.contentView addSubview: self.browseLabel];
		self.browseLabel.sd_layout
		.centerYEqualToView(self.timeLabel)
		.leftSpaceToView(self.timeLabel, 5.0f)
		.rightSpaceToView(self.joinLabel, 5.0)
		.heightIs(15.0f);
		
		[self.contentView addSubview: self.addressLabel];
		self.addressLabel.sd_layout
		.topSpaceToView(self.timeLabel, 10.0f)
		.rightSpaceToView(self.contentView, 15.0f)
		.widthIs(100.0f)
		.heightIs(15.0f);
		
		[self.contentView addSubview: self.remainingLabel];
		self.remainingLabel.sd_layout
		.topSpaceToView(self.timeLabel, 10.0f)
		.leftSpaceToView(self.contentView, 15.0f)
		.rightSpaceToView(self.addressLabel, 5.0f)
		.heightIs(15.0f);
		
		[self.contentView addSubview: self.lineView];
		self.lineView.sd_layout
		.topSpaceToView(self.remainingLabel, 15.0f)
		.leftSpaceToView(self.contentView, 0.0f)
		.rightSpaceToView(self.contentView, 0.0f)
		.heightIs(0.5f);
		
		[self setupAutoHeightWithBottomView:self.lineView bottomMargin:0.0f];
	}
	return self;
}

#pragma mark - updateView
- (void)updateViewWithModel:(MyXuqiuModel *)model {
	[self.titlelabel setText: model.title];
	[self.priceLabel setText: [NSString stringWithFormat:@"¥%ld",model.price]];
	[self.timeLabel setText: [NSString stringWithFormat:@"发布时间:%@",model.create_ti]];
	[self.browseLabel setText: [NSString stringWithFormat:@"浏览:%ld",model.browsingvolume]];
	[self.joinLabel setText: [NSString stringWithFormat:@"人数:%ld",model.renshu]];
//	if (model.status == 1) {
//		[self.remainingLabel setText: [NSString stringWithFormat:@"剩余时间:%.2ld:%.2ld:%.2ld",model.countdown/(24 *3600),model.countdown/(24 *3600)%3600,model.countdown/60%60]];
//	} else {
//		[self.remainingLabel setText:@""];
//	}
	
	[self.addressLabel setText: model.dizhi];
	
}

@end
