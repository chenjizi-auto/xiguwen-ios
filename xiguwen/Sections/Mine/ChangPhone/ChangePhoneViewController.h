//
//  ChangePhoneViewController.h
//  BoYi
//
//  Created by Chen on 2017/8/13.
//  Copyright © 2017年 hengwu. All rights reserved.
//

typedef NS_ENUM(NSInteger, ChangePhoneStyle) {
    ChangePhoneStyleVerPhone,
    ChangePhoneStyleChangePassword,
    ChangePhoneStyleNewPhone
};

#import "FatherViewController.h"

@interface ChangePhoneViewController : FatherViewController

@property (nonatomic,assign) NSInteger style;

@end
