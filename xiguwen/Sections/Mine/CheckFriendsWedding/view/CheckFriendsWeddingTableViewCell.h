//
//  CheckFriendsWeddingTableViewCell.h
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckFriendsWeddingModel.h"

@interface CheckFriendsWeddingTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) CheckFriendsWeddingModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
