//
//  GuanzhuAnlieTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuanzhuAnlieModel.h"

@interface GuanzhuAnlieTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) AnliGuanzhuModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *headrimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *guanzhu;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, copy) void(^onDidcancelFocus)(void);
@end
