//
//  AskViewController.h
//  BoYi
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "UItextViewWithPlaceHloder.h"


@interface AskViewController : FatherViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *content;
@property (strong,nonatomic)NSString *idString;
@end
