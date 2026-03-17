//
//  ShangjiaTwoCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewShangjiaModel.h"

@interface ShangjiaTwoCollectionViewCell : UICollectionViewCell
@property (strong,nonatomic) Zuopinnewfen *model;
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yishounumber;
@property (weak, nonatomic) IBOutlet UILabel *jianjie;
@property (weak, nonatomic) IBOutlet UIImageView *bofangImage;

@end
