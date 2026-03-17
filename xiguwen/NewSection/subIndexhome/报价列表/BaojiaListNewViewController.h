//
//  BaojiaListNewViewController.h
//  BoYi
//
//  Created by heng on 2018/2/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "NewShangjiaModel.h"
@interface BaojiaListNewViewController : FatherViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;

@property (nonatomic, strong) NSArray <Baojiashangjiafen *>*dataBJ;
@end
