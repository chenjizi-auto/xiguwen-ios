//
//  shangchengOrderNFooter.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "shangchengOrderNFooter.h"

@implementation shangchengOrderNFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setModel:(DataShangcheng *)model {
    _model = model;
    self.shifukuan.text =@"¥ 0.00";
    self.gongjiNumber.text = [NSString stringWithFormat:@"共%ld件商品",model.goods.count ];
    self.xiaoji.text = [NSString stringWithFormat:@"¥ %@",model.order_amount];
}
@end
