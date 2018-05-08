//
//  VideoViewController.h
//  BoYi
//
//  Created by apple on 2017/9/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface VideoViewController : FatherViewController<UIWebViewDelegate>
@property (strong,nonatomic) UIWebView *webView;
@property (nonatomic,strong) NSString *urlString;

@end
