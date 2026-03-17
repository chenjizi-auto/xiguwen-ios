//
//  ZuopinNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/20.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZuopinNewModel.h"

@interface ZuopinNewTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;

//属性
//@property (strong,nonatomic) ZuopinNewModel *model;

@property (weak, nonatomic) IBOutlet UILabel *zuopinNumber;

@end
