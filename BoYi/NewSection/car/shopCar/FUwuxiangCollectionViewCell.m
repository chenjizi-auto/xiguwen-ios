//
//  FUwuxiangCollectionViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FUwuxiangCollectionViewCell.h"

@implementation FUwuxiangCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(Esarrayqw *)model{
    
    self.name.text = model.name;
    if (model.isSele) {
        self.name.textColor = [UIColor whiteColor];
        self.backView.backgroundColor = RGBA(234, 99, 132, 1);
        self.backView.bwidth = 0;
        
    }else {
        self.name.textColor = RGBA(51, 51, 51, 1);
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.bwidth = 1;
    }
    
}

@end
