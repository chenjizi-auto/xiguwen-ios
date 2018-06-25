//
//  ZLElectronicInvitationPreviewInvitationView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationPreviewInvitationView.h"

@interface ZLElectronicInvitationPreviewInvitationView ()

///预览视图
@property (nonatomic,weak) UIWebView *webView;
///功能条
@property (nonatomic,weak) UIView *functionBar;
///返回键
@property (nonatomic,weak) UIButton *leftBarButtonItem;

@end

@implementation ZLElectronicInvitationPreviewInvitationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self webView];
        [self functionBar];
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
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
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
- (UIView *)functionBar {
    if (!_functionBar) {
        CGFloat width = 60.0;
        CGFloat height = 60.0;
        CGFloat allHeight = 360.0;
        CGFloat bottomSpacing = 40.0;
        CGFloat spacing = 15.0;
        UIView *functionBar = [[UIView alloc] initWithFrame:CGRectMake(spacing, self.frame.size.height - allHeight - bottomSpacing, width, allHeight)];
        NSArray *imageNames = @[@"祝福.png",@"宾客.png",@"礼金.png",@"发送.png",@"编辑.png"];
        NSArray *tags = @[@(ZLPreviewInvitationActionTypeBless),@(ZLPreviewInvitationActionTypeGuests),@(ZLPreviewInvitationActionTypeCashGift),@(ZLPreviewInvitationActionTypeSend),@(ZLPreviewInvitationActionTypeEdit)];
        for (NSInteger index = 0; index < imageNames.count; index++) {
            UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(0, (height + spacing) * index, width, height)];
            NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:imageNames[index]];
            [sender setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
            [sender addTarget:self action:@selector(functionBarAction:) forControlEvents:UIControlEventTouchUpInside];
            sender.tag = [tags[index] integerValue];
            [functionBar addSubview:sender];
        }
        [self addSubview:functionBar];
        _functionBar = functionBar;
    }
    return _functionBar;
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
- (void)leftBarButtonItemAction {
    if (self.goBack) {
        self.goBack();
    }
}
- (void)editButtonAction {
    if (self.previewAction) {
        self.previewAction(ZLPreviewInvitationActionTypeEdit);
    }
}
- (void)functionBarAction:(UIButton *)sender {
    if (self.previewAction) {
        self.previewAction(sender.tag);
    }
}

@end
