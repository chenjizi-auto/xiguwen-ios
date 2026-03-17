//
//  ZLElectronicInvitationSelectTemplateView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLElectronicInvitationSelectTemplateModel.h"

@interface ZLElectronicInvitationSelectTemplateView : UIView

///弱引用数据
@property (nonatomic,weak) ZLElectronicInvitationSelectTemplateModel *infoModel;
///加载数据
@property (nonatomic,copy) void (^loadData)(void);
///查看详情
@property (nonatomic,copy) void (^lookDetail)(ZLElectronicInvitationSelectTemplateModel *model);

@end
