//
//  JoinSheTuanTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/16.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShetuanModel.h"

@interface JoinSheTuanTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Shetuan *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIButton *refusedBtn;

@property (nonatomic, copy) void(^onDidJoin)(Shetuan *model);
@property (nonatomic, copy) void(^onDidRefused)(Shetuan *model);

@end
