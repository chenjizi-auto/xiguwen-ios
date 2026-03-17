//
//  TwoTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZuoPinCollectionViewCell.h"
#import "FindTJModel.h"

@interface TwoTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (strong,nonatomic) NSMutableArray <EsarraytjTJ *> *dataArrayTJ;

//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

@end
