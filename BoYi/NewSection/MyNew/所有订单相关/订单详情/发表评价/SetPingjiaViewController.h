//
//  SetPingjiaViewController.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "UItextViewWithPlaceHloder.h"
@interface SetPingjiaViewController : FatherViewController
@property (assign,nonatomic)NSInteger id;
@property (assign,nonatomic)BOOL isHunQin;

@property (weak, nonatomic) IBOutlet UILabel *fenshu;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *content;
@property (weak, nonatomic) IBOutlet UIButton *nimingBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@end
