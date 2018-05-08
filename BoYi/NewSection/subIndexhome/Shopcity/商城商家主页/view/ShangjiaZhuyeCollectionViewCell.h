//
//  ShangjiaZhuyeCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangchengsjNewDetilModel.h"
@interface ShangjiaZhuyeCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) Shopshangchengsj *model;
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yishou;
@end
