//
//  ZLElectronicInvitationEditTemplateView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLElectronicInvitationEditTemplateModel.h"

///编辑页功能条
typedef NS_ENUM (NSInteger , ZLEditTemplateFunction){
    ///删除
    ZLEditTemplateFunctionDeleteInvitation = 1,
    ///删页
    ZLEditTemplateFunctionDeletePage ,
    ///预览
    ZLEditTemplateFunctionPreview ,
};

@interface ZLElectronicInvitationEditTemplateView : UIView

///弱引用数据
@property (nonatomic,weak) ZLElectronicInvitationEditTemplateModel *infoModel;
///改变图片
@property (nonatomic,copy) void (^changeImageAction)(void);
///保存文本
@property (nonatomic,copy) void (^saveTextAction)(void);
///底部功能条事件
@property (nonatomic,copy) void (^bottomFunctionAction)(ZLEditTemplateFunction type);
///错误日志
@property (nonatomic,strong) NSString *errorMessage;
///展示遮盖
@property (nonatomic,unsafe_unretained) BOOL showHud;

//删除某个页面
- (void)deletePage;

@end
