//
//  ZLElectronicInvitationSelectMusicViewController.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLElectronicInvitationSelectMusicModel.h"

@interface ZLElectronicInvitationSelectMusicViewController : UIViewController

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///下文主键
@property (nonatomic,strong) NSString *keyId;
///已经选择过的音乐模型
@property (nonatomic,strong) ZLElectronicInvitationSelectMusicModel *musicModel;
///音乐模型被选中
@property (nonatomic,copy) void (^clickRow)(ZLElectronicInvitationSelectMusicModel *musicModel);

@end
