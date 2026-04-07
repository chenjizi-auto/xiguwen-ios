//
//  ZLIntegralShopH5PageCell.m
//  ProjectModules
//
//  Created by zhaolei on 2018/5/28.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLIntegralShopH5PageCell.h"
#import "ZLIntegralShopH5PageView.h"
#import <WebKit/WebKit.h>

@interface ZLIntegralShopH5PageCell ()<WKNavigationDelegate>

///网页交互
@property (nonatomic,weak) WKWebView *webView;

@end

@implementation ZLIntegralShopH5PageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    [self webView];
}

#pragma mark - Lazy
- (WKWebView *)webView {
    if (!_webView) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - statusBarHeight - 44.0) configuration:configuration];
        if (@available(iOS 11.0, *)) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset;
        }
        webView.navigationDelegate = self;
        webView.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
        [self.contentView addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

#pragma mark - Set
- (void)setSrcPath:(NSString *)srcPath {
    _srcPath = srcPath;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_srcPath]]];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        CGFloat height = [result respondsToSelector:@selector(floatValue)] ? [result floatValue] : 0;
        if (height) {
            CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
            CGFloat bottomSecurityDomain = statusBarHeight == 20.0 ? 0 : 14.0;
            CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height - statusBarHeight - 44.0;
            height = height > screenHeight ? height : screenHeight;
            height = height + bottomSecurityDomain;
            self.webView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, height);
            ((ZLIntegralShopH5PageView *)self.superview.superview).cellHeight = height;
        }
    }];
}

#pragma mark - Public
- (BOOL)canGoBack {
    return self.webView.canGoBack;
}
- (void)goBack {
    [self.webView goBack];
}
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    ZLIntegralShopH5PageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLIntegralShopH5PageCell class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([ZLIntegralShopH5PageCell class])];
    }
    return cell;
}

@end
