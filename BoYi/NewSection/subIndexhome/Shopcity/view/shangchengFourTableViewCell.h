//
//  shangchengFourTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopcityModel.h"
@interface shangchengFourTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *tiele;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UILabel *dianming;

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *jindianBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) Youlove *model;

@end
