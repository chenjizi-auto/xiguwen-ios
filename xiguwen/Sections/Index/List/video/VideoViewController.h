//
//  VideoViewController.h
//  BoYi
//
//  Created by apple on 2017/9/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import <WebKit/WebKit.h>

@interface VideoViewController : FatherViewController<WKNavigationDelegate>
@property (strong,nonatomic) WKWebView *webView;
@property (nonatomic,strong) NSString *urlString;

@end
