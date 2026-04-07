//
//  BannerWebViewController.h
//  BoYi
//
//  Created by apple on 2017/8/17.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import <WebKit/WebKit.h>

@interface BannerWebViewController : FatherViewController <WKNavigationDelegate>

@property (strong,nonatomic) NSString *name;
@property (nonatomic,strong) NSString *urlString;

@end
