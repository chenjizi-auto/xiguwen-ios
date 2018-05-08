//
//  ShouyinTaiViewController.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface ShouyinTaiViewController : FatherViewController
@property (nonatomic,assign)NSInteger type; // 1 婚庆立即购买 2 婚庆购物车 3 商品立即购买 4 商品购物车 5 店铺认证 6 开通用户会员 7 支付婚庆尾款  8开通商家会员
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSMutableDictionary *dicm;
@property (nonatomic,strong)NSMutableDictionary *dicm1;
@property (nonatomic,strong)NSMutableDictionary *dicm3;


@property (nonatomic,strong)NSMutableDictionary *dicm8;
@property (nonatomic,strong)NSString *bianhao;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (weak, nonatomic) IBOutlet UILabel *hejiprice;
@end
