//
//  MyConcernShopTableViewCell.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyConcernModel.h"
#import "HCSStarRatingView.h"

@interface MyConcernShopTableViewCell : UITableViewCell
//属性
@property (strong,nonatomic) MyConcernModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *eventBtn;
//@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;

@end
