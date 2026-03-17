//
//  AllTpyeViewController.h
//  BoYi
//
//  Created by heng on 2017/12/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "allTpyeModel.h"
@interface AllTpyeViewController : FatherViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *coection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong,nonatomic) NSMutableArray <Alltypearray *> *dataArray;

@property (assign,nonatomic) NSInteger isHunqin;
@end
