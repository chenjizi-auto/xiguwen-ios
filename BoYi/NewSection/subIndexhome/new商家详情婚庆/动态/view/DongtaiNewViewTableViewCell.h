//
//  DongtaiNewViewTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/19.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewShangjiaDongtaiModel.h"

@interface DongtaiNewViewTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

//属性
@property (strong,nonatomic) Dongtaiarray *model;
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (strong,nonatomic)NSMutableArray <Photourldongtai *>*fuwuArray;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *tuandui;
@property (weak, nonatomic) IBOutlet UILabel *centnet;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (weak, nonatomic) IBOutlet UILabel *liulan;
@property (weak, nonatomic) IBOutlet UILabel *pinlun;
@property (weak, nonatomic) IBOutlet UILabel *dianzan;
@property (weak, nonatomic) IBOutlet UIButton *dianzanBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;
@property (weak, nonatomic) IBOutlet UIImageView *dianzanImage;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *shanchuBtn;

@end
