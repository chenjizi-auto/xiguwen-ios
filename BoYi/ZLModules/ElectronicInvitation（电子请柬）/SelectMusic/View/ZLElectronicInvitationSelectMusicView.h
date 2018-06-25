//
//  ZLElectronicInvitationSelectMusicView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLElectronicInvitationSelectMusicModel.h"

@interface ZLElectronicInvitationSelectMusicView : UIView

///弱引用数据
@property (nonatomic,weak) ZLElectronicInvitationSelectMusicModel *infoModel;
///加载数据
@property (nonatomic,copy) void (^loadData)(void);
///错误日志
@property (nonatomic,strong) NSString *errorMessage;
///展示遮盖
@property (nonatomic,unsafe_unretained) BOOL showHud;

@end
