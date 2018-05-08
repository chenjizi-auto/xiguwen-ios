//
//  SaiXuanView.h
//  BoYi
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaiXuanView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *timeBtnMark;//
@property (nonatomic, strong) UIButton *priceBtnMark;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) NSMutableArray *array;//地区
@property (nonatomic, strong) NSMutableDictionary *dicm;
@property (copy,nonatomic) void(^ block)(NSDictionary *dic);

+ (SaiXuanView *)showInView:(UIView *)view array:(NSMutableArray *)array block:(void(^)(NSDictionary *dic))block;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (weak, nonatomic) IBOutlet UIButton *moneyBtnOne;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtnTwo;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtnThree;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtnFour;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtnFive;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtnSix;


@end
