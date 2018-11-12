//
//  SPneCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2018/4/21.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPneCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yishounumber;

@end
