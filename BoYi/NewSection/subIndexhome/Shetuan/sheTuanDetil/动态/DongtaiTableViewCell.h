//
//  DongtaiTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/13.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShetuanDetilModel.h"
@interface DongtaiTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *hotCollection;
@property (strong, nonatomic) Dynamiclist *model;
@property (strong, nonatomic) NSMutableArray <Pics *>*hotArray;



@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headrimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *tuandui;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *isGunazhuBTn;

@property (weak, nonatomic) IBOutlet UIButton *liulanBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;
@property (weak, nonatomic) IBOutlet UIButton *dianzanBtn;

@end
