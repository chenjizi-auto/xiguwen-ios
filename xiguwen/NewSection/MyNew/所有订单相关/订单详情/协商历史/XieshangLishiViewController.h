//
//  XieshangLishiViewController.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface XieshangLishiViewController : FatherViewController

@property (assign,nonatomic)NSInteger type; //1 婚庆userid
//2 shopid
//3 userid
//4 shopid


@property (assign,nonatomic)BOOL isHunqin;

@property (assign,nonatomic)NSInteger id;
#pragma mark- as

#pragma mark- model

@property (weak, nonatomic) IBOutlet UIButton *sixinNameBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
#pragma mark- view

#pragma mark- api

@end
