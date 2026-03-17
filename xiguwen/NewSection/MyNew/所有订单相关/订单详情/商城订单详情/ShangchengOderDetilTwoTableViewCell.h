//
//  ShangchengOderDetilTwoTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetilModelSC.h"
@interface ShangchengOderDetilTwoTableViewCell : UITableViewCell
@property (nonatomic,strong)GoodsSCDetil *model;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *yanseChima;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *actionBtn;

@end
