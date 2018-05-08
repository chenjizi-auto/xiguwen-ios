//
//  NTESSessionViewController.m
//  DemoApplication
//
//  Created by chris on 15/10/7.
//  Copyright © 2015年 chris. All rights reserved.
//

#import "NTESSessionViewController.h"
#import "NTESSessionConfig.h"
#import "NTESAttachment.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface NTESSessionViewController ()

@property (nonatomic,strong) NTESSessionConfig *config;

@end

@implementation NTESSessionViewController

- (instancetype)initWithSession:(NIMSession *)session
{
    self = [super initWithSession:session];
    if (self) {
        _config = [[NTESSessionConfig alloc] init];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addPopBackBtn];
}
- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
}
- (void)popViewConDelay
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
//- (NSString *)sessionTitle{
//    return @"聊天";
//}

- (id<NIMSessionConfig>)sessionConfig{
    return self.config;
}


#pragma mark - Private
- (void)sendCustomMessage{
    //构造自定义内容
    NTESAttachment *attachment = [[NTESAttachment alloc] init];
    attachment.title = @"这是一条自定义消息";
    attachment.subTitle = @"这是自定义消息的副标题";
    
    //构造自定义MessageObject
    NIMCustomObject *object = [[NIMCustomObject alloc] init];
    object.attachment = attachment;
    
    //构造自定义消息
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = object;
    
    //发送消息
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:self.session error:nil];
}

@end
