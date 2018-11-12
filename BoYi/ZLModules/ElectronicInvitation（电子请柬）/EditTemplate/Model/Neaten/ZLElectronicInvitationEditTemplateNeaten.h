//
//  ZLElectronicInvitationEditTemplateNeaten.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditTemplateModel.h"

@interface ZLElectronicInvitationEditTemplateNeaten : ZLElectronicInvitationEditTemplateModel

///将json字符串转换为容器，并进行数据整理
+ (void)editTemplateDataWithJsonString:(NSString *)jsonString InfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel;

@end
