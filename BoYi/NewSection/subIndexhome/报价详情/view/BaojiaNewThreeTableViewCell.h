//
//  BaojiaNewThreeTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/23.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaojiaDetilModel.h"
@interface BaojiaNewThreeTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (strong,nonatomic) BaojiaDetilModel *model;
@end
