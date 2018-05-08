//
//  ShangChengListnCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/28.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangChengListNewModel.h"

@interface ShangChengListnCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) Shopnew *model;
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yishou;
@end
