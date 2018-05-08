//
//  ShetuanTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShetuanModel.h"

@interface ShetuanTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Shetuan *model;

// xib
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headrimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *chengyuan;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *address;



@end
