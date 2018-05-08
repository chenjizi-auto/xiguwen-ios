//
//  CarTuijianTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopNewCarModel.h"

@interface CarTuijianTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *hotCollection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (nonatomic, copy) NSArray <ShopCarTuiJian *>*dataArray;
- (void)configModel:(NSArray <ShopCarTuiJian *>*)modelArray;
@end
