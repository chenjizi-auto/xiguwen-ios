//
//  YaoQingNewchengyuanTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YaoQingNewchengyuanModel.h"

@interface YaoQingNewchengyuanTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) YaoQingNewchengyuanModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;
@property (nonatomic, copy) void(^onDidinvite)(void);

@end
