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
- (UIView *)levelView {
    if (!_levelView) {
        _levelView = [[UIView alloc] init];
        _levelView.backgroundColor = UIColor.orangeColor;
        _levelView.layer.cornerRadius = 2;
        _levelView.layer.masksToBounds = true;
    }
    return _levelView;
}
- (UILabel *)levelLabel {
	if (!_levelLabel) {
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.font = [UIFont systemFontOfSize:11];
        _levelLabel.textColor = UIColor.whiteColor;
	}
	return _levelLabel;
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
	}
	return _titleLabel;
}

- (UILabel *)markLabel {
	if (!_markLabel) {
		_markLabel = [[UILabel alloc] init];
		[_markLabel setFont: [UIFont systemFontOfSize:13.0f]];
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
        [_submitBtn.layer setCornerRadius:2.0f];
        [_submitBtn.layer setMasksToBounds: YES];
        [_submitBtn.layer setBorderColor:UIColorFromRGB(0xFF7299).CGColor];
        [_submitBtn.layer setBorderWidth:0.5f];
	}
	return _submitBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
		[self.contentView addSubview: self.levelView];
        [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView.mas_leading).offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.levelView addSubview: self.levelLabel];
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(self.levelView).offset(3);
            make.trailing.bottom.mas_equalTo(self.levelView).offset(-3);
        }];
        
//		self.levelImage.sd_layout
//		.topSpaceToView(self.contentView, 15.0f)
//		.leftSpaceToView(self.contentView, 15.0f)
//		.widthIs(30.0f)
//		.heightIs(20.0f);
        
        
		
		[self.contentView addSubview: self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.levelView.mas_trailing).offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview: self.markLabel];
        [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.titleLabel.mas_trailing).offset(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
//		self.titleLabel.sd_layout
//		.centerYEqualToView(self.levelView)
//		.leftSpaceToView(self.levelImage, 10.0f)
//		.heightIs(20.0f);
//		[self.titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth/2];
		
		[self.contentView addSubview: self.submitBtn];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-15);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(self.contentView.top).offset(15);
            make.bottom.mas_equalTo(self.contentView.bottom).offset(-15);
        }];
        
        
//		self.submitBtn.sd_layout
//		.centerYEqualToView(self.levelView)
//		.rightSpaceToView(self.contentView, 15.0f)
//		.widthIs(80.0f)
//		.heightIs(30.0f);
		
		
		
        
//		self.markLabel.sd_layout
//		.centerYEqualToView(self.titleLabel)
//		.leftSpaceToView(self.titleLabel, 5.0f)
//		.rightSpaceToView(self.submitBtn, 10.0f)
//		.heightIs(20.0f);
		
//		[self setupAutoHeightWithBottomView:self.levelImage bottomMargin:15.0f];
        
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
