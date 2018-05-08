//
//  ZuopinTwoTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shetuanZuppinModel.h"
@interface ZuopinTwoTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *Collection;
@property (strong, nonatomic) shetuanZuppinModel *model;
@property (strong, nonatomic) NSMutableArray <Chengyuanzuopin *>*hotArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@end
