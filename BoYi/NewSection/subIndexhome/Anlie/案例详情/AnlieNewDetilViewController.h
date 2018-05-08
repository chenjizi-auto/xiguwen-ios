//
//  AnlieNewDetilViewController.h
//  BoYi
//
//  Created by heng on 2017/12/24.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "AnlieListSearchModel.h"
@interface AnlieNewDetilViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (nonatomic, assign)NSInteger anlieID;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIImageView *isGuanzhuImage;
@end
