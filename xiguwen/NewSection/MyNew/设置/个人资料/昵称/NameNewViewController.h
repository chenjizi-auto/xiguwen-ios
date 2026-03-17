//
//  NameNewViewController.h
//  BoYi
//
//  Created by heng on 2018/1/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface NameNewViewController : FatherViewController

@property (copy,nonatomic) void(^ block)(NSString *value);
@property (copy,nonatomic) NSString *placeHolder;
@property (copy,nonatomic) NSString *textValue;
@end
