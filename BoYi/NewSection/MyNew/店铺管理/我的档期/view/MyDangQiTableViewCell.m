//
//  MyDangQiTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyDangQiTableViewCell.h"
@interface MyDangQiTableViewCell()

@end
@implementation MyDangQiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setModel:(DangQiDetailsModel *)model {
    _model = model;
	NSString *str = [NSString stringWithFormat: @"%@日",[model.date substringFromIndex:8]];
	self.nameLabel.text = [NSString stringWithFormat:@"%@（%@）%@",str,model.timeslot,model.contacts ? model.contacts : @""];

//	model.contactnumber = [model.contactnumber stringByReplacingOccurrencesOfString:[model.contactnumber substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
	
	self.phoneLabel.text = model.contactnumber ? model.contactnumber : @"";//[model.contactnumber stringByReplacingOccurrencesOfString:[model.contactnumber substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
	
	[self.remindBtn setHidden: !model.remind];
	[self.systemBtn setHidden: !model.xitong];
}
@end
