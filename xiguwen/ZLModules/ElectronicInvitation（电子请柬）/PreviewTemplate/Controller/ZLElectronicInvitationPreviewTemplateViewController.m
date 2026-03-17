//
//  ZLElectronicInvitationPreviewTemplateViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationPreviewTemplateViewController.h"
#import "ZLElectronicInvitationPreviewTemplateView.h"
#import "ZLElectronicInvitationEditTemplateViewController.h"

@interface ZLElectronicInvitationPreviewTemplateViewController ()

///主视图
@property (nonatomic,weak) ZLElectronicInvitationPreviewTemplateView *previewTemplateView;

@end

@implementation ZLElectronicInvitationPreviewTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.previewTemplateView.htmlUrl = self.htmlUrl;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.previewTemplateView closeMusic];
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationPreviewTemplateView *previewTemplateView = [[ZLElectronicInvitationPreviewTemplateView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:previewTemplateView];
    self.previewTemplateView = previewTemplateView;
    //开始制作
    __weak typeof(self)weakSelf = self;
    previewTemplateView.startedMaking = ^{
        ZLElectronicInvitationEditTemplateViewController *editTemplateVc = [ZLElectronicInvitationEditTemplateViewController new];
        editTemplateVc.keyId = weakSelf.keyId;
        editTemplateVc.userId = weakSelf.userId;
        editTemplateVc.token = weakSelf.token;
        editTemplateVc.isFromPreviewTemplateEnter = YES;
        [weakSelf.navigationController pushViewController:editTemplateVc animated:YES];
    };
    //返回
    previewTemplateView.goBack = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
}

@end
