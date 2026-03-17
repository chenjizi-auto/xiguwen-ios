//
//  OrderDetilcollectiontableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuanzhuShangpinCellCollectionViewCell.h"
#import "OrderDetilModelNew.h"
#import "OrderDetilModelSC.h"

@interface OrderDetilcollectiontableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic,strong)OrderDetilModelNew *model;
@property (nonatomic,strong)OrderDetilModelSC *modelsc;
@property (nonatomic, strong) RACSubject *selectItemSubject;

@end
