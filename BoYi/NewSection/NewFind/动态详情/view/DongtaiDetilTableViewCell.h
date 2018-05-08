//
//  DongtaiDetilTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DongtaiDetilModel.h"

@interface DongtaiDetilTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Zanlist *model;

// xib
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
