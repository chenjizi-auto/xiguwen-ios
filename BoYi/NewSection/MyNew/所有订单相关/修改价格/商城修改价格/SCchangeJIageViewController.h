//
//  SCchangeJIageViewController.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "ShangchengOrderModel.h"

@interface SCchangeJIageViewController : FatherViewController
@property (assign,nonatomic) NSInteger id;
@property (nonatomic,nonatomic) DataShangcheng *model;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *yanseChima;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UITextField *changeJinge;


@end
