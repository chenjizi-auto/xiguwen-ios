//
//  ZLElectronicInvitationHomeView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/5.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLElectronicInvitationHomeModel.h"

@interface ZLElectronicInvitationHomeView : UIView

///弱引用数据
@property (nonatomic,weak) ZLElectronicInvitationHomeModel *infoModel;
///加载数据
@property (nonatomic,copy) void (^loadData)(void);
///创建我的请柬
@property (nonatomic,copy) void (^createMyInvitation)(void);
///查看详情
@property (nonatomic,copy) void (^lookDetail)(ZLElectronicInvitationHomeModel *model);

@end
