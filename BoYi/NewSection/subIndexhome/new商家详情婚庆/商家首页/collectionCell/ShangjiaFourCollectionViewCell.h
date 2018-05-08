//
//  ShangjiaFourCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnlieNewDetilModel.h"


@interface ShangjiaFourCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) teamWU *model;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Label *price;

@end
