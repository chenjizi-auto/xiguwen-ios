//
//  shangpinShopCar.h
//  BoYi
//
//  Created by heng on 2017/12/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shangpinnewModel.h"
#import "mashuModel.h"
@interface shangpinShopCar : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) int priceNUmber;//

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *number;


@property (copy,nonatomic) void(^ block)(NSDictionary *dic);
@property (nonatomic, strong) NSMutableDictionary *dicm;
@property (nonatomic, strong) NSMutableArray *array;//服务项
+ (shangpinShopCar *)showInView:(UIView *)view dic:(shangpinnewModel *)dic block:(void(^)(NSDictionary *dic))block;

@property (strong,nonatomic)NSMutableArray <mashuModel *>*dataArray;
@property (strong, nonatomic)NSString *userId;
@property (weak, nonatomic) IBOutlet UICollectionView *hotCollection;
@property (strong, nonatomic)shangpinnewModel *model;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (nonatomic, assign) NSInteger index;//
@property (nonatomic, assign) NSInteger id;//

@end
