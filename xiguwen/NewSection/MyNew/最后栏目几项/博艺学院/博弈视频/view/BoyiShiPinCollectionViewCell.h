//
//  BoyiShiPinCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoyiShiPinModel.h"
@interface BoyiShiPinCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BackImage;
@property (weak, nonatomic) IBOutlet UILabel *singName;
@property (weak, nonatomic) IBOutlet UIImageView *VipImageView;
@property (weak, nonatomic) IBOutlet UILabel *comment;
- (void)data:(BoyiShiPinModel*)model;
@end
