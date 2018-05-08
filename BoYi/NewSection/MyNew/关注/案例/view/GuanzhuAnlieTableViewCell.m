//
//  GuanzhuAnlieTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "GuanzhuAnlieTableViewCell.h"

@implementation GuanzhuAnlieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(AnliGuanzhuModel *)model {
    _model = model;
    [self.headrimage sd_setImageWithUrl:model.weddingcover placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.title;
    
    self.content.text = model.titlea;
    self.price.text = [NSString stringWithFormat:@"¥%ld起",model.weddingexpenses];
    self.guanzhu.text = [NSString stringWithFormat:@"关注 %ld",model.followed];
}

- (IBAction)cancelFocus:(UIButton *)sender {
	// 取消关注
	self.onDidcancelFocus();
}


@end
