//
//  ShangjiaNewFourCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/22.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewShangjiaModel.h"
@interface ShangjiaNewFourCollectionViewCell : UICollectionViewCell
@property (strong,nonatomic) Tuijiantd *model;

@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;

@property (weak, nonatomic) IBOutlet IB_DESIGN_Label *price;

@end
