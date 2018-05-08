//
//  ShareView.m
//  ThreeAsk_New
//
//  Created by apple on 2017/6/29.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import "ShareView.h"
#import "UIButton+HNButton.h"
#import "UIView+Extension.h"
//#import "UMSocial.h"
#import <UShareUI/UShareUI.h>
#import "commonTool.h"
@interface ShareView ()

@property (nonatomic, strong)UIView *btnView;
@property (nonatomic, strong)UIButton *cover;


@end




@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
        
        UIButton *cover = [UIButton new];
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0;
        cover.frame = self.bounds;
        [cover addTarget:self action:@selector(selfHied) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        UIView *btnView = [UIView new];
        btnView.width = self.width;
        btnView.height = ScaleFloat(180);
        btnView.y = self.height;
        btnView.backgroundColor = RGBA(231, 231, 231,1);
        [self addSubview:btnView];
        self.btnView = btnView;
        
        CGFloat margin = ScaleFloat(20);
        CGFloat btnWith = (self.width - margin * 5) * 0.25;
        CGFloat btnHeight = btnWith + ScaleFloat(15);
        NSArray *titleArray = @[@"QQ好友", @"微信", @"朋友圈", @"新浪微博", @"QQ空间"];
        for (NSInteger i = 0; i < 5; i++) {
            
            NSString *imageNmae = [NSString stringWithFormat:@"Fenxiang%ld",(long)i + 1];
            UIButton *btn = [UIButton new];
            btn.titleLabel.font = ScaleFont(12);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:imageNmae] forState:UIControlStateNormal];
            btn.width = btnWith;
            btn.height = btnHeight;
            btn.x = margin + (btn.width + margin) * (i % 4);
            btn.y = margin + (btn.height + ScaleFloat(10)) * (i / 4);
            btn.tag = i;
            [btnView addSubview:btn];
            [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn verticalImageAndTitle:ScaleFloat(3)];
        }
    }
    return self;
}

- (void)shareBtnClick:(UIButton *)shareBtn {
    
    [self selfHied];
    
    NSString *urlString = nil;
    NSString *icon = nil;
    UMSocialPlatformType type = 4;
    
    NSString *content = nil;
    NSString *title = nil;
    
    if (_type == ShareViewTypeDownApp) {
        
        urlString = [NSString stringWithFormat:@"http://www.baidu.com"];
        icon = @"icon_chose_arrow_nor";
        
        if (!icon.length) {
            icon = @"http://www.swsir.com/share/icons/paipan.jpg";
        }
        content = [NSString stringWithFormat:@"简介:"];
        title = [NSString stringWithFormat:@"三问周易预测大师-"];
    }

    switch (shareBtn.tag) {
        case 0: // QQ好友
            
        {
            type  = UMSocialPlatformType_QQ;
            
        }
            
            break;
            
        case 1: // 微信
            
            type  = UMSocialPlatformType_WechatSession;
            
            break;
            
        case 2: // 朋友圈
            
            type  = UMSocialPlatformType_WechatTimeLine;
            
            break;
            
        case 3: // 新浪微博
            
            type  = UMSocialPlatformType_Sina;
            
            break;
            
        case 4: // QQ空间
            
            type  = UMSocialPlatformType_Qzone;

            break;
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:[UIImage imageNamed:icon]];
    //设置网页地址
    shareObject.webpageUrl =urlString;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform: type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)show {
    
    self.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _cover.alpha = 0.7;
        _btnView.y = self.height - _btnView.height;
        
    }];
}

- (void)selfHied {
    [UIView animateWithDuration:0.5 animations:^{
        
        _cover.alpha = 0;
        _btnView.y = self.height;
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
@end
