//
//  BoyiShipinXiaJiCommentTableViewCell.m
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShipinXiaJiCommentTableViewCell.h"
@interface BoyiShipinXiaJiCommentTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *commentL;

@end

@implementation BoyiShipinXiaJiCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCommentDetail:(BoyiShiPinXiaJiCommentDetailModel *)data{
    self.commentL.text =  [NSString stringWithFormat:@"%@：%@",data.nickname,data.comm];
}
@end
