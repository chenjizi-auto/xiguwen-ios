//
//  FindViewController.h
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface FindViewController : FatherViewController<UITextFieldDelegate>

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *isXheirht;
@end
