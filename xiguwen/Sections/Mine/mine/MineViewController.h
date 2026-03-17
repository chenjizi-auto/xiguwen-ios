//
//  MineViewController.h
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface MineViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api


@property (weak, nonatomic) IBOutlet UIImageView *imageRZOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageRZtwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageRZthree;

@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UIView *fenView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *viewThree;
@property (weak, nonatomic) IBOutlet UIView *viewFour;


@property (weak, nonatomic) IBOutlet UIView *viewGuanzhu;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;


@end
