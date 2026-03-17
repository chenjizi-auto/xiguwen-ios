//
//  TypeViewCollectionReusableView.m
//  BoYi
//
//  Created by heng on 2017/12/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "TypeViewCollectionReusableView.h"

@implementation TypeViewCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13.5, 20, 20)];
        
        [self addSubview:_image];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 180, 18)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = RGBA(137, 137, 137, 1);
        

        _titleLabel.centerY = _image.centerY;
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
