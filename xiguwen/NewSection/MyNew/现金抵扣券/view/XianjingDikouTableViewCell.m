//
//  XianjingDikouTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "XianjingDikouTableViewCell.h"

@implementation XianjingDikouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(XianjingDikouModel *)model {
    _model = model;
	[self.priceLabel setText:[UserDataNew sharedManager].userInfoModel.user.vouchers];
}
@end
