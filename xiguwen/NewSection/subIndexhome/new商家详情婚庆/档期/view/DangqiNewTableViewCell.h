//
//  DangqiNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/19.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewShangjiaDangqiModel.h"

@interface DangqiNewTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray <DangqiNew *>*fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;

//属性
@property (strong,nonatomic) Dangqinnewarray *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
