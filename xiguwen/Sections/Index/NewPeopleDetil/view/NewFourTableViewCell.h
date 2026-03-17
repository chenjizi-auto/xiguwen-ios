//
//  NewFourTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "peopleDetailModel.h"
@interface NewFourTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *teamCollection;

@property (strong,nonatomic)NSMutableArray *reamArray;

@property (strong,nonatomic) peopleDetailModel *model;

@property (strong, nonatomic)NSString *userId;
@property (nonatomic, strong) RACSubject *selectItemSubject;

@end
