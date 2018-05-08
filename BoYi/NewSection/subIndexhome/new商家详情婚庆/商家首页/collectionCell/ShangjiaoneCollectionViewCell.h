//
//  ShangjiaoneCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewShangjiaModel.h"

@interface ShangjiaoneCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) Baojiashangjiafen *model;
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yishounumber;

@end
