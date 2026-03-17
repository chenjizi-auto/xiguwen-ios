//
//  WenZangDetilViewController.h
//  BoYi
//
//  Created by heng on 2018/1/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface WenZangDetilViewController : FatherViewController<UIWebViewDelegate>

@property (strong,nonatomic) NSString *name;
@property (nonatomic,strong) NSString *urlString;

@end
