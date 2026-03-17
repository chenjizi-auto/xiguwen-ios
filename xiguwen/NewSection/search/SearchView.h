//
//  SearchView.h
//  BoYi
//
//  Created by heng on 2017/11/28.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchLsModel.h"
@interface SearchView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *search;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong,nonatomic)SearchLsModel *model;
@property (strong,nonatomic)NSMutableDictionary *dic;

@property (strong,nonatomic)NSMutableArray <LishiSearch *>*remenArray;
@property (strong,nonatomic)NSMutableArray <HotSearch *>*lishiArray;

@property (copy,nonatomic) void(^ block)(NSDictionary *dic);

+ (SearchView *)showInView:(UIView *)view array:(NSMutableArray *)array block:(void(^)(NSDictionary *dic))block;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *iamge4;
@property (strong,nonatomic)NSString *type;

@end
