//
//  ShangchengTuikuanViewController.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "OrderDetilModelSC.h"
@interface ShangchengTuikuanViewController : FatherViewController


@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)GoodsSCDetil *model;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *yanseChima;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *number;
@end
