//
//  ShopCarList.h
//  BoYi
//
//  Created by apple on 2017/9/1.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarList : UIView<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *bgView;

// custom code
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) NSMutableArray *dataArrayYuanshi;

@property (assign,nonatomic) NSInteger zongjiageStr;
@property (assign,nonatomic) float zongDingjinStr;

@property (copy,nonatomic) void(^ block)(NSDictionary *dic);
@property (nonatomic, strong) NSMutableDictionary *dicm;
+ (ShopCarList *)showInView:(UIView *)view dic:(NSMutableDictionary *)dic block:(void(^)(NSDictionary *dic))block;

@property (weak, nonatomic) IBOutlet UILabel *zongdingjin;

@property (weak, nonatomic) IBOutlet UILabel *zongjiage;

@end
