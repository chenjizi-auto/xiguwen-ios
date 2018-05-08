//
//  DongraiDetilHeader.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DongtaiDetilModel.h"
@interface DongraiDetilHeader : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

// xib
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UILabel *jianjie;

@property (weak, nonatomic) IBOutlet UILabel *pinglunNumber;


@property (weak, nonatomic) IBOutlet UILabel *dianzanNumber;


@property (strong,nonatomic) NSMutableArray *hotArray;

@property (strong, nonatomic) RACSubject *gotoNextVc;
@property (strong, nonatomic) RACSubject *gotoNextVc1;
@property (strong, nonatomic) RACSubject *clickImageSubject; //点击图片放大
@property (strong, nonatomic) DongtaiDetilModel *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end
