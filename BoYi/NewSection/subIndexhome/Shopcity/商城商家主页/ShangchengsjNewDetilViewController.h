//
//  ShangchengsjNewDetilViewController.h
//  BoYi
//
//  Created by heng on 2018/2/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "ShangchengsjNewDetilModel.h"
@interface ShangchengsjNewDetilViewController : FatherViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger id;

@property (weak, nonatomic) IBOutlet UIView *fatherview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIImageView *jiageImage;
@property (weak, nonatomic) IBOutlet UIButton *zhongheBTn;
@property (weak, nonatomic) IBOutlet UIButton *xiaoliangBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiageBTn;

@property (strong,nonatomic) NSMutableArray <Shopshangchengsj *>*dataArray;
@property (strong,nonatomic) ShangchengsjNewDetilModel *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fans;
@property (weak, nonatomic) IBOutlet UIButton *isguanBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headerimage;


@end
