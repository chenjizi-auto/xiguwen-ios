//
//  SearchbjViewController.h
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "NewShangjiaModel.h"
@interface SearchbjViewController : FatherViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;

@property (nonatomic, strong) NSArray <Baojiashangjiafen *>*dataBJ;

@property (weak, nonatomic) IBOutlet UIImageView *jiageImage;
@property (weak, nonatomic) IBOutlet UIButton *zhongheBTn;
@property (weak, nonatomic) IBOutlet UIButton *xiaoliangBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiageBTn;
@property (strong ,nonatomic) NSString *content;
@end
