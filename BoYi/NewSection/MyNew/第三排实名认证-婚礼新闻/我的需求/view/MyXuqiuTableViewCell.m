//
//  MyXuqiuTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyXuqiuTableViewCell.h"

@implementation MyXuqiuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(MyXuqiuModel *)model {
    _model = model;
	[self.editBtn.layer setBorderColor:UIColorFromRGB(0xFF7299).CGColor];
	[self.closeBtn.layer setBorderColor:UIColorFromRGB(0xFF7299).CGColor];
	[self.titleLabel setText:[NSString stringWithFormat: @"%@ %@",model.type == 1 ? @"[婚庆]" : @"[商城]",model.title]];
	[self.priceLabel setText:[NSString stringWithFormat:@"¥%.2f",(float)model.price]];
	[self.timeLabel setText:[NSString stringWithFormat:@"发布时间:%@",model.create_ti]];
	[self.statusImg setImage:[UIImage imageNamed: model.status == 1 ? @"进行中" : @"已结束"]];
	[self.browseLabel setText:[NSString stringWithFormat:@"浏览:%ld",(long)model.browsingvolume]];
	[self.joinLabel setText:[NSString stringWithFormat:@"参与:%ld",(long)model.renshu]];
	// 剩余时间
//	if (model.status == 1) {
//		[self.remainLabel setText:[NSString stringWithFormat: @"%.2ld:%.2ld:%.2ld:%.2ld",self.model.countdown/(24 *3600),self.model.countdown/(24 *3600)%3600,self.model.countdown/60%60,self.model.countdown%60]];
//		[self.remainLabel setHidden: NO];
//		[self.timeTitle setHidden: NO];
//	} else {
//		[self.remainLabel setHidden: YES];
//		[self.timeTitle setHidden: YES];
//	}
	// 判断按钮状态
	[self.editBtn setHidden: model.status == 1 ? NO : YES];
	[self.closeBtn setTitle:model.status == 1 ? @"关闭" : @"删除" forState:(UIControlStateNormal)];
}

@end
