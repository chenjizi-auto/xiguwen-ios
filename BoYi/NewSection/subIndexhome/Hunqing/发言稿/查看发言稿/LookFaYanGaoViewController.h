//
//  LookFaYanGaoViewController.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "FayangaoModel.h"
@interface LookFaYanGaoViewController : FatherViewController
@property (nonatomic, strong) Fayangaoarray *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end
