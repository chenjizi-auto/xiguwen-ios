//
//  ShangjiaIndexTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewShangjiaModel.h"
@interface ShangjiaIndexTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

//属性
//@property (strong,nonatomic) ShangjiaIndexModel *model;

// xib
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (strong,nonatomic) NewShangjiaModel *model;
@property (weak, nonatomic) IBOutlet UILabel *baojianumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end

