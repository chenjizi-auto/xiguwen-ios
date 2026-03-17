//
//  TuijianNewCollectionViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopNewCarModel.h"
@interface TuijianNewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *occupation;
@property (weak, nonatomic) IBOutlet UILabel *evaluateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fans;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage1;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage2;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage3;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage4;
@property (strong,nonatomic) ShopCarTuiJian *model;
@end
