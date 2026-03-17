//
//  NewPeopleDetilViewController.h
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface NewPeopleDetilViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (strong,nonatomic) NSString  *userId;

@property (weak, nonatomic) IBOutlet UIImageView *guanzhuimage;
@property (weak, nonatomic) IBOutlet UILabel *guanzhulabel;
@property (weak, nonatomic) IBOutlet UIButton *guanzhubtntwo;

@end
