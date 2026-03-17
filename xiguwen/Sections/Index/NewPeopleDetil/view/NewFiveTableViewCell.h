//
//  NewFiveTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "peopleDetailModel.h"
#import "ZuoPinCollectionViewCell.h"

@interface NewFiveTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *zuopinCollection;

@property (strong,nonatomic)NSMutableArray *fuwuxiangArray;

@property (strong,nonatomic) peopleDetailModel *model;

@property (nonatomic, strong) RACSubject *selectItemSubject;
//@property (strong, nonatomic)NSString *userId;
@end
