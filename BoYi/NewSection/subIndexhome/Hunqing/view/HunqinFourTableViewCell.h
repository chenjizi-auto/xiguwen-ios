//
//  HunqinFourTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/7.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotnewCollectionViewCell.h"
#import "HunqinModel.h"
@interface HunqinFourTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UICollectionView *hotCollection;
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (nonatomic, strong) Remengeren *geren;
@property (nonatomic, strong) NSMutableArray *hotArray;
@end
