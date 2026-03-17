//
//  BoyiShiPinTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoyiShiPinModel.h"

@interface BoyiShiPinTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//属性
@property (strong,nonatomic) BoyiShiPinModel *model;
@property (weak, nonatomic) IBOutlet UICollectionView *hotCollection;
// xib
@property (nonatomic, strong) RACSubject *selectItemSubject;
@end
