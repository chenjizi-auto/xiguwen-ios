//
//  HunqinFourTuanduiTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/26.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotnewCollectionViewCell.h"
#import "HunqinModel.h"

@interface HunqinFourTuanduiTableViewCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *hotCollection;
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (nonatomic, strong) Rementuandui *tuandui;
@property (nonatomic, strong) NSMutableArray *hotArray;

@end
