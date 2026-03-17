//
//  GuanzhuShangpinCellCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shangpinGuanzhuModel.h"
@interface GuanzhuShangpinCellCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) ShangpingGuanzhuModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yishounumber;
@end
