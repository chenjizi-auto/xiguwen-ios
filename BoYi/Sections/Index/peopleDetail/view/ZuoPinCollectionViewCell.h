//
//  ZuoPinCollectionViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
@interface ZuoPinCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (strong,nonatomic) Rows *model;

@end
