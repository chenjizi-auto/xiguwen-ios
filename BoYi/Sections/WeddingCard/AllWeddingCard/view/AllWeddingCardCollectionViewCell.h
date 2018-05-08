//
//  AllWeddingCardCollectionViewCell.h
//  BoYi
//
//  Created by Chen on 2017/9/3.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllWeddingCardModel.h"

@interface AllWeddingCardCollectionViewCell : UICollectionViewCell
//属性
@property (strong,nonatomic) AllWeddingCardModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
// xib

@end
