//
//  AnlieNewDetilTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/24.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnlieNewDetilModel.h"
#import "AnlieListSearchModel.h"
@interface AnlieNewDetilTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray <Photourlanlie *>*fuwuArray;
@property (nonatomic, strong) RACSubject *selectItemSubject;


@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *lookbtn;

//属性
@property (strong,nonatomic) Infoanlie *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *fengmianImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *lookMIngxiBtn;
@property (weak, nonatomic) IBOutlet UILabel *jianjie;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;


@end
