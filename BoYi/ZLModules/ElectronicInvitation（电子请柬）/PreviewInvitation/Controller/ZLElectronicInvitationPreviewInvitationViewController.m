//
//  ZLElectronicInvitationPreviewInvitationViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationPreviewInvitationViewController.h"
#import "ZLElectronicInvitationPreviewInvitationView.h"
#import "ZLElectronicInvitationEditTemplateViewController.h"
#import "ZLElectronicInvitationGuestsReplyViewController.h"
#import "ZLElectronicInvitationCashGiftViewController.h"
#import "ZLElectronicInvitationShareInvitationViewController.h"

@interface ZLElectronicInvitationPreviewInvitationViewController ()

///主视图
@property (nonatomic,weak) ZLElectronicInvitationPreviewInvitationView *previewInvitationView;

@end

@implementation ZLElectronicInvitationPreviewInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.previewInvitationView.htmlUrl = self.htmlUrl;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.previewInvitationView closeMusic];
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationPreviewInvitationView *previewInvitationView = [[ZLElectronicInvitationPreviewInvitationView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:previewInvitationView];
    self.previewInvitationView = previewInvitationView;
    //预览事件
    __weak typeof(self)weakSelf = self;
    previewInvitationView.previewAction = ^(ZLPreviewInvitationActionType actionType) {
        if (actionType == ZLPreviewInvitationActionTypeEdit) {//编辑
            if (weakSelf.isFromEditPageEnter) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                return ;
            }
            ZLElectronicInvitationEditTemplateViewController *editTemplateVc = [ZLElectronicInvitationEditTemplateViewController new];
            editTemplateVc.keyId = weakSelf.keyId;
            editTemplateVc.userId = weakSelf.userId;
            editTemplateVc.token = weakSelf.token;
            [weakSelf.navigationController pushViewController:editTemplateVc animated:YES];
        }else if (actionType == ZLPreviewInvitationActionTypeBless//祝福
                  || actionType == ZLPreviewInvitationActionTypeGuests) {//宾客
            ZLElectronicInvitationGuestsReplyViewController *guestsReplyVc = [ZLElectronicInvitationGuestsReplyViewController new];
            guestsReplyVc.keyId = weakSelf.keyId;
            guestsReplyVc.userId = weakSelf.userId;
            guestsReplyVc.token = weakSelf.token;
            guestsReplyVc.lookGuests = actionType == ZLPreviewInvitationActionTypeGuests ? YES : NO;
            [weakSelf.navigationController pushViewController:guestsReplyVc animated:YES];
        }else if (actionType == ZLPreviewInvitationActionTypeCashGift) {//礼金
            ZLElectronicInvitationCashGiftViewController *cashGiftVc = [ZLElectronicInvitationCashGiftViewController new];
            cashGiftVc.keyId = weakSelf.keyId;
            cashGiftVc.userId = weakSelf.userId;
            cashGiftVc.token = weakSelf.token;
            [weakSelf.navigationController pushViewController:cashGiftVc animated:YES];
        }else if (actionType == ZLPreviewInvitationActionTypeSend) {//分享
            ZLElectronicInvitationShareInvitationViewController *shareInvitationVc = [ZLElectronicInvitationShareInvitationViewController new];
            shareInvitationVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            shareInvitationVc.imageUrl = weakSelf.imageUrl;
            shareInvitationVc.sharetime = weakSelf.sharetime;
            shareInvitationVc.htmlUrl = weakSelf.htmlUrl;
            [weakSelf presentViewController:shareInvitationVc animated:NO completion:nil];
        }
    };
    //返回
    previewInvitationView.goBack = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

@end
