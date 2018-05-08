//
//  AnlieBuThressTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "AnlieNewDetilModel.h"
@interface AnlieBuThressTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *fenshu;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starview;
@property (weak, nonatomic) IBOutlet UILabel *jianjie;
@property (weak, nonatomic) IBOutlet UICollectionView *coection;
@property (weak, nonatomic) IBOutlet UIButton *lookshengyuPinlun;

@property (strong, nonatomic) Pinglunanlie *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (assign, nonatomic)NSInteger tiaoshu;
@end
