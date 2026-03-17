//
//  ShangChengTuikuanTwoViewController.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "UItextViewWithPlaceHloder.h"
@interface ShangChengTuikuanTwoViewController : FatherViewController


@property (assign, nonatomic) NSInteger typeStitc;
@property (assign, nonatomic) BOOL isYiFaHuo;
@property (assign, nonatomic) NSInteger id;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *yanseChima;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *yuanyin;
@property (weak, nonatomic) IBOutlet UILabel *tuikuanDetil;
@property (weak, nonatomic) IBOutlet UITextField *shijikuquan;

@property (weak, nonatomic) IBOutlet UIButton *xieyi;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end
