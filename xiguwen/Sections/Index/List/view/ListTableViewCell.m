//
//  ListTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(Userlist *)model{
    
    _model = model;
    
    [self.headerImage sd_setImageWithUrl:String(ImageHomeURL,model.biz_cover) placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.cn_name;
    self.price.text = String(@"",model.biz_price);
    self.haopinglv.text = [NSStringFormatter(model.biz_star) isBlankString] ? @"好评率 0" :String(@"好评率 ",model.biz_star);
    self.fensishu.text = [NSStringFormatter(model.follow) isBlankString] ? @"粉丝数 0" :String(@"粉丝数 ",model.follow);
    self.liulanliang.text = [NSStringFormatter(model.biz_view_count) isBlankString] ? @"浏览量 0" : String(@"浏览量 ",model.biz_view_count);
    
    if (![[NSString stringWithFormat:@"%lu",(unsigned long)model.reputation.length] isBlankString]) {
        int max = [model.reputation intValue];
        int a = 0,b = 0,c = 0,d = 0;
        a = max / 1250;
        b = (max % 1250) / 250;
        c = (max % 1250 % 250) / 50;
        d = (max % 1250 % 250 % 50) / 10;
        for (int i = 0; i < a + b + c + d; i ++) {
            NSString *imageString;
            
            if (i > 8) {
                break;
            }
            if (i < a) {
                imageString = @"未标题-5";//zhi
            }
            if (a <= i  && i  < a + b) {
                imageString = @"未标题-2";//huang
            }
            if (i  >= a + b && i <a + b + c) {
                imageString = @"未标题-1";//zhuan
            }
            if (i  >= a + b + c && i < a + b + c + d) {
                imageString = @"未标题-3";//xing
            }
            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
            
            view.frame = CGRectMake(i * 15, 0, 13, 13);
            
            [self.starView addSubview:view];
            
        }
        if (max < 10 && max > 0) {
            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
            
            view.frame = CGRectMake(0, 0, 13, 13);
            
            [self.starView addSubview:view];
        }
    }

//    if (model.reputation.length == 0) {
//        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
//        
//        view.frame = CGRectMake(15, 0, 13, 13);
//        
//        [self.starView addSubview:view];
//    }

    
}


@end
