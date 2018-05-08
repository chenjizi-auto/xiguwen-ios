//
//  SaixuanCollectionViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "SaixuanCollectionViewCell.h"

@implementation SaixuanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    self.name.text = dic[@"area"];
    if ([dic[@"isSele"] isEqualToString:@"0"]) {
        
        self.name.textColor = RGBA(51, 51, 51, 1);
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.bwidth = 1;
        
    }else {
        
        self.name.textColor = [UIColor whiteColor];
        self.backView.backgroundColor = RGBA(234, 99, 132, 1);
        self.backView.bwidth = 0;
    }
    
    
}

@end
