//
//  MyxuqiuCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyXuqiuModel.h"

@interface MyxuqiuCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) PlayersModel *model;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
