//
//  NewTalkTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluationManagementModel.h"
#import "HCSStarRatingView.h"
@interface NewTalkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *star;
@property (weak, nonatomic) IBOutlet UILabel *fenshu;
@property (strong, nonatomic) EvaluationManagementModel *model;
@end
