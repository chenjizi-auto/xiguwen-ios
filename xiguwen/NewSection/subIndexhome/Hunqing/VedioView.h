//
//  VedioView.h
//  BoYi
//
//  Created by heng on 2018/4/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VedioView : UIView<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) NSString *urlString;
@property (strong,nonatomic) UIWebView *webView;
+ (VedioView *)showInView:(UIView *)view url:(NSString *)url;

@end
