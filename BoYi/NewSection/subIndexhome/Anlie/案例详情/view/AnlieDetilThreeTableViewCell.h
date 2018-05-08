//
//  AnlieDetilThreeTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/27.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnlieNewDetilModel.h"
@interface AnlieDetilThreeTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray <Gdanli *>*fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (nonatomic, strong) AnlieNewDetilModel *model;

@end
