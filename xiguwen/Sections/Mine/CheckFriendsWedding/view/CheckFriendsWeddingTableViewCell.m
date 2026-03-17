//
//  CheckFriendsWeddingTableViewCell.m
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "CheckFriendsWeddingTableViewCell.h"

@implementation CheckFriendsWeddingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(CheckFriendsWeddingModel *)model {
    _model = model;
    
    [self.header sd_setImageWithUrl:ImageAppendURL(model.bizCover)];
    self.name.text = model.customName;
    
    self.date.text = [NSString stringWithFormat:@"婚期:%@",[NSDate dateWithTimeIntervalSince1970:model.evaluationTime.millis / 1000].fs_string];
    self.content.text = model.customCommont;
}

@end
