//
//  DaitongguoChengyuanTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaitongguoChengyuanModel.h"

@interface DaitongguoChengyuanTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) DaitongguoChengyuanModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;

@property (nonatomic, copy) void(^onDidAgree)(BOOL isAgree);

@end
