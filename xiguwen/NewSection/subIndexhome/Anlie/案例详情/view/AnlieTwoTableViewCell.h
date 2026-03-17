//
//  AnlieTwoTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/27.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnlieNewDetilModel.h"
@interface AnlieTwoTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray <teamWU *>*fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (nonatomic, strong)AnlieNewDetilModel *model;


@property (weak, nonatomic) IBOutlet UIImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage1;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage2;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage3;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage4;


@property (weak, nonatomic) IBOutlet UILabel *haopinlv;
@property (weak, nonatomic) IBOutlet UILabel *pinlunshu;
@property (weak, nonatomic) IBOutlet UILabel *fensishu;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *lookBtn;


@end
