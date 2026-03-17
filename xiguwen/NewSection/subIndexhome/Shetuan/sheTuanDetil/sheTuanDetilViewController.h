//
//  ShetuanDetilViewController.h
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface ShetuanDetilViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view
@property (assign, nonatomic) NSInteger id;
#pragma mark- api
@property (weak, nonatomic) IBOutlet UILabel *titleNav;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHegiht;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnHeight;

@property (weak, nonatomic) IBOutlet UIButton *navPopBtn;
@property (weak, nonatomic) IBOutlet UIView *navview;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@end
