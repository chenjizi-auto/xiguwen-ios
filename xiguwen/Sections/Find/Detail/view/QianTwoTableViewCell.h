//
//  QianTwoTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZuoPinCollectionViewCell.h"
#import "FindModel.h"

@interface QianTwoTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (strong,nonatomic) NSMutableArray <Rows *> *dataArrayTP;
@end
