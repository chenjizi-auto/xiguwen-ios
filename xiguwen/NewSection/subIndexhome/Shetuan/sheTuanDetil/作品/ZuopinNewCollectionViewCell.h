//
//  ZuopinNewCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shetuanZuppinModel.h"
@interface ZuopinNewCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) Chengyuanzuopin *model;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *liulan;

@end
