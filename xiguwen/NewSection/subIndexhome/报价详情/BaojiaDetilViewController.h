//
//  BaojiaDetilViewController.h
//  BoYi
//
//  Created by heng on 2017/12/23.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface BaojiaDetilViewController : FatherViewController



#pragma mark- as

#pragma mark- model

#pragma mark- view

@property (weak, nonatomic) IBOutlet UIImageView *isGuanzhuImage;
@property (weak, nonatomic) IBOutlet UIView *bottomBarContainer;
@property (weak, nonatomic) IBOutlet UIView *leftActionContainer;
@property (weak, nonatomic) IBOutlet UIView *messageActionContainer;
@property (weak, nonatomic) IBOutlet UIView *phoneActionContainer;
@property (weak, nonatomic) IBOutlet UIView *followActionContainer;
@property (weak, nonatomic) IBOutlet UIView *rightActionContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightActionWidthConstraint;
#pragma mark- api
@property(nonatomic,assign)NSInteger baojiaid;
@end
