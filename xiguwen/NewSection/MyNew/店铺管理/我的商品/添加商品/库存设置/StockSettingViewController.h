//
//  StockSettingViewController.h
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "MyGoodsModel.h"

@interface StockSettingViewController : FatherViewController

@property (nonatomic, strong) MyGoodsModel *model;
@property (nonatomic, copy) void(^onDidReturn)(MyGoodsModel *model);

@end
