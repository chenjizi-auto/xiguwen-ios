//
//  ZLElectronicInvitationPreviewInvitationView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

///预览请柬页事件
typedef NS_ENUM (NSInteger , ZLPreviewInvitationActionType){
    ///编辑
    ZLPreviewInvitationActionTypeEdit = 1,
    ///祝福
    ZLPreviewInvitationActionTypeBless ,
    ///宾客
    ZLPreviewInvitationActionTypeGuests ,
    ///礼金
    ZLPreviewInvitationActionTypeCashGift ,
    ///发送
    ZLPreviewInvitationActionTypeSend ,
};

@interface ZLElectronicInvitationPreviewInvitationView : UIView

///链接地址
@property (nonatomic,strong) NSString *htmlUrl;
///预览事件
@property (nonatomic,copy) void (^previewAction)(ZLPreviewInvitationActionType actionType);
///返回
@property (nonatomic,copy) void (^goBack)(void);

//关闭音乐（进入下个页面时）
- (void)closeMusic;

@end
