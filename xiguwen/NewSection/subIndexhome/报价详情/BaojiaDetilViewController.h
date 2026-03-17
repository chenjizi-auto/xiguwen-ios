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
#pragma mark- api
@property(nonatomic,assign)NSInteger baojiaid;
@end
