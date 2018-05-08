//
//  TlakTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "peopleDetailModel.h"
#import "HCSStarRatingView.h"
@interface TlakTableViewCell : UITableViewCell

@property (nonatomic, strong)CommentlistW *model;
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *star;
@property (weak, nonatomic) IBOutlet UILabel *fenshu;

@end
