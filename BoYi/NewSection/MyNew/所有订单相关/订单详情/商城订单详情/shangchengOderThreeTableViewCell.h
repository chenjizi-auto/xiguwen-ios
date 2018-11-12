//
//  shangchengOderThreeTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetilModelSC.h"
@interface shangchengOderThreeTableViewCell : UITableViewCell

@property (nonatomic,strong)GoodsSCDetil *model;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *yanseChima;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *number;
@end
