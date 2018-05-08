//
//  GuanzhuShangpinViewController.h
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "shangpinGuanzhuModel.h"
@interface GuanzhuShangpinViewController : FatherViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) NSMutableArray <ShangpingGuanzhuModel *>*dataArray;

#pragma mark- as

@end
