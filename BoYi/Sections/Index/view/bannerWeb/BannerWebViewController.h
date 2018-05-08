//
//  BannerWebViewController.h
//  BoYi
//
//  Created by apple on 2017/8/17.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface BannerWebViewController : FatherViewController <UIWebViewDelegate>

@property (strong,nonatomic) NSString *name;
@property (nonatomic,strong) NSString *urlString;

@end
