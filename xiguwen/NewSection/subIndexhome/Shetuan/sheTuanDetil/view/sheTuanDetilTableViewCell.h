//
//  ShetuanDetilTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShetuanDetilModel.h"

@interface ShetuanDetilTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) ShetuanDetilModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *beijingimage;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *liulanNUmber;

@end
