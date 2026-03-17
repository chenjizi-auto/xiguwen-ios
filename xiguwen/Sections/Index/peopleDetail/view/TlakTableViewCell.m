//
//  TlakTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "TlakTableViewCell.h"

@implementation TlakTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommentlistW *)model{
    _model = model;
    [self.header sd_setImageWithUrl:String(ImageHomeURL,model.user.avatar) placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.user.cnName;
    self.content.text = model.user.descn;
    self.time.text = [NSString stringWithFormat:@"%@",[[NSDate dateWithTimeIntervalSince1970:model.user.createTime.iMillis / 1000] fs_stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    self.fenshu.text = [NSString stringWithFormat:@"%ld分",(long)model.user.coins];
    self.star.value = model.user.coins;

}


@end
