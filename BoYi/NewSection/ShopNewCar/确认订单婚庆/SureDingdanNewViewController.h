//
//  SureDingdanNewViewController.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"

@interface SureDingdanNewViewController : FatherViewController

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api


@property (nonatomic,assign)NSInteger type; //1立即2购物车
@property (nonatomic,strong)NSString *idPingjie;
@property (nonatomic,strong)NSDictionary *dic;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UILabel *xiaoji;
@property (weak, nonatomic) IBOutlet UILabel *zongji;
@end
