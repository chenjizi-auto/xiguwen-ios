//
//  HunqinQuanTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunqinQuanModel.h"

@interface HunqinQuanTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//属性
@property (strong,nonatomic) Hunqinnewarray *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

// xib
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIView *btmView;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headrImage;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UIButton *dianzanBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;


@property (weak, nonatomic) IBOutlet UILabel *jianjie;

@property (weak, nonatomic) IBOutlet UILabel *liulanNumber;
@property (weak, nonatomic) IBOutlet UIImageView *liulanImage;

@property (weak, nonatomic) IBOutlet UILabel *pinglunNumber;
@property (weak, nonatomic) IBOutlet UIImageView *pinglunImage;

@property (weak, nonatomic) IBOutlet UILabel *dianzanNumber;
@property (weak, nonatomic) IBOutlet UIImageView *dianzanImage;

@property (strong,nonatomic) NSMutableArray *hotArray;
@property (nonatomic, strong) RACSubject *clickImageSubject;


@end
