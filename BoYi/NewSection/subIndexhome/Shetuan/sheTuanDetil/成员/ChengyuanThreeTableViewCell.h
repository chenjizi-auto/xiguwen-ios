//
//  ChengyuanThreeTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/15.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shetuanChengyuanModel.h"
@interface ChengyuanThreeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) Chengyuan *model;
@end
