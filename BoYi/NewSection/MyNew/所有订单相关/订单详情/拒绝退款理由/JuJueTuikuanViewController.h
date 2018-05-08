//
//  JuJueTuikuanViewController.h
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "UItextViewWithPlaceHloder.h"
@interface JuJueTuikuanViewController : FatherViewController
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *liyou;
@property (assign,nonatomic)NSInteger id;
@property (assign,nonatomic)NSInteger type;
@end

