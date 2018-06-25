//
//  ZLElectronicInvitationPreviewTemplateView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationPreviewTemplateView.h"

@interface ZLElectronicInvitationPreviewTemplateView ()

///预览视图
@property (nonatomic,weak) UIWebView *webView;
///编辑
@property (nonatomic,weak) UIButton *editButton;
///返回键
@property (nonatomic,weak) UIButton *leftBarButtonItem;

@end

@implementation ZLElectronicInvitationPreviewTemplateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self webView];
        [self editButton];
    }
    return self;
}

#pragma mark - Set
- (void)setHtmlUrl:(NSString *)htmlUrl {
    _htmlUrl = htmlUrl;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_htmlUrl]]];
}

#pragma mark - Lazy
- (UIWebView *)webView {
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - CGRectGetHeight(self.editButton.superview.frame))];
        [webView setMediaPlaybackRequiresUserAction:NO];
        //ios11 适配
        if (@available(iOS 11.0, *)) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset;
        }
        [self addSubview:webView];
        [self leftBarButtonItem];
        _webView = webView;
    }
    return _webView;
}
- (UIButton *)editButton {
    if (!_editButton) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat safetyAreaHeight = statusBarHeight == 20.0 ? 0 : 24.0;
        
        //夹层，用来弥补iPhoneX的底部安全域
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 50.0 - safetyAreaHeight, UIScreen.mainScreen.bounds.size.width, 50.0 + safetyAreaHeight);
        [self addSubview:effectView];
        
        UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        [editButton setTitle:@"开始制作" forState:UIControlStateNormal];
        editButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        [editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
        editButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [effectView.contentView addSubview:editButton];
        _editButton = editButton;
    }
    return _editButton;
}
- (UIButton *)leftBarButtonItem {
    if (!_leftBarButtonItem) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(15.0, statusBarHeight, 30.0, 40.0)];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"返回按钮.png"];
        [sender setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(leftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        [sender.titleLabel sizeToFit];
        [self addSubview:sender];
        _leftBarButtonItem = sender;
    }
    return _leftBarButtonItem;
}

#pragma mark - separate
- (void)closeMusic {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
}

#pragma mark - Action
- (void)editButtonAction {
    if (self.startedMaking) {
        self.startedMaking();
    }
}
- (void)leftBarButtonItemAction {
    if (self.goBack) {
        self.goBack();
    }
}

@end
