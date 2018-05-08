//
//  ShangchengJiedanTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangchengOrderModel.h"

@interface ShangchengJiedanTableViewCell : UITableViewCell

// xib
@property (nonatomic, strong) RACSubject *selectItemSubject;




@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *yanseChima;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *number;


//属性
@property (strong,nonatomic) Goodsshangcheng *model;

@end
