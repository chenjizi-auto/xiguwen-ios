//
//  GoodsNewSCTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/26.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopNewCarModel.h"
@interface GoodsNewSCTableViewCell : UITableViewCell
@property (strong,nonatomic) Goods *model;
@property (weak, nonatomic) IBOutlet UIImageView *isGouImage;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *priceD;

@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *jianBtn;
@property (weak, nonatomic) IBOutlet UIButton *seleBtn;
@end
