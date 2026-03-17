//
//  ZLElectronicInvitationGuestsReplyView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLElectronicInvitationGuestsReplyModel.h"

@interface ZLElectronicInvitationGuestsReplyView : UIView

///弱引用数据
@property (nonatomic,weak) ZLElectronicInvitationGuestsReplyModel *infoModel;
///加载数据
@property (nonatomic,copy) void (^loadData)(void);
///删除数据
@property (nonatomic,copy) void (^deleteData)(void);
///错误日志
@property (nonatomic,strong) NSString *errorMessage;

@end
