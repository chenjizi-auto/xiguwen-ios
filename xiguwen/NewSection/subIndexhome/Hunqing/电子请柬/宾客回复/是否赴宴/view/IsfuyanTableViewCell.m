//
//  IsfuyanTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "IsfuyanTableViewCell.h"

@implementation IsfuyanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(Fuyan *)model {
    _model = model;
	
	[self.name setText:model.name];
	[self.time setText:model.createti];
	[self.number setText:[NSString stringWithFormat:@"%ld",model.fuyannum]];
}
@end
