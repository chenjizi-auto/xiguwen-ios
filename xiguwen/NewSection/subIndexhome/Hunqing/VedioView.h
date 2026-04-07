//
//  VedioView.h
//  BoYi
//
//  Created by heng on 2018/4/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface VedioView : UIView<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) NSString *urlString;
@property (strong,nonatomic) WKWebView *webView;
+ (VedioView *)showInView:(UIView *)view url:(NSString *)url;

@end
