//
//  ShangChengListNewViewController.h
//  BoYi
//
//  Created by heng on 2018/2/28.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface ShangChengListNewViewController : FatherViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (assign, nonatomic) NSInteger id;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (weak, nonatomic) IBOutlet UIImageView *jiageImage;
@property (weak, nonatomic) IBOutlet UIButton *zhongheBTn;
@property (weak, nonatomic) IBOutlet UIButton *xiaoliangBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiageBTn;
@end
