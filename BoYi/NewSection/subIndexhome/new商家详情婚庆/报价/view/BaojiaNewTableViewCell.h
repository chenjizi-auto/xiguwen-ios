//
//  BaojiaNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/19.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewShangjiaModel.h"
@interface BaojiaNewTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (weak, nonatomic) IBOutlet UILabel *baojiaNumber;
@end
