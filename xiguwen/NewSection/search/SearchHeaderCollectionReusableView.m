//
//  SearchHeaderCollectionReusableView.m
//  BoYi
//
//  Created by heng on 2017/11/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "SearchHeaderCollectionReusableView.h"

@implementation SearchHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 17.5, 54, 16)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = RGBA(137, 137, 137, 1);
        [self addSubview:_titleLabel];
        
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 44, 0, 24, 24)];
        _btn.centerY = _titleLabel.centerY;
        [_btn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _btn.contentEdgeInsets = UIEdgeInsetsZero;
        _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);

        [self addSubview:_btn];
    }
    return self;
}
@end
