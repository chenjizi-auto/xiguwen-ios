//
//  ShangjianewTwoTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/20.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewShangjiaModel.h"

@interface ShangjianewTwoTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (strong,nonatomic) NewShangjiaModel *model;
@property (weak, nonatomic) IBOutlet UILabel *zuopinumber;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtnother;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UILabel *pingjiaNumber;


@end
