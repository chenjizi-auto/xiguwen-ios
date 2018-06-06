//
//  SearchNewViewController.h
//  BoYi
//
//  Created by heng on 2018/2/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "SearchLsModel.h"

@interface SearchNewViewController : FatherViewController
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *search;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong,nonatomic)SearchLsModel *model;

//当前城市名
@property (strong ,nonatomic) NSString *currentCityName;

@property (strong,nonatomic)NSMutableArray <LishiSearch *>*remenArray;
@property (strong,nonatomic)NSMutableArray <HotSearch *>*lishiArray;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *iamge4;
@property (strong,nonatomic)NSString *type;

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@property (weak, nonatomic) IBOutlet IB_DESIGN_View *cityView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightwu;



@end
