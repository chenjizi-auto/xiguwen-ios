//
//  EvaluationManagementTableViewCell.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluationManagementModel.h"
#import <HCSStarRatingView.h>

@interface EvaluationManagementTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) EvaluationManagementModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *starValue;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;

@end
