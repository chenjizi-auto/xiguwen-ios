//
//  peopleDetailViewController.h
//  BoYi
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "IndexModel.h"
#import "FSCalendar.h"
@interface peopleDetailViewController : FatherViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet FSCalendar *dateView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressCollectionHeight;

//@property (strong,nonatomic) Children *model;

@property (strong,nonatomic) NSString  *userId;
#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (weak, nonatomic) IBOutlet UIImageView *imageRZOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageRZtwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageRZthree;
@property (weak, nonatomic) IBOutlet UIView *fenView;

@property (weak, nonatomic) IBOutlet UIImageView *starOne;
@property (weak, nonatomic) IBOutlet UIView *starView;

@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UIImageView *guanzhuimage;
@property (weak, nonatomic) IBOutlet UILabel *guanzhulabel;
@property (weak, nonatomic) IBOutlet UIButton *guanzhubtntwo;




@end
