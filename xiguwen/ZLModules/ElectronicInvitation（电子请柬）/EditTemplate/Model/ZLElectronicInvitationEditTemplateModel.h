//
//  ZLElectronicInvitationEditTemplateModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/9.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

///控件类型
typedef NS_ENUM (NSInteger , ZLEditTemplateUnitType){
    ///文字
    ZLEditTemplateUnitTypeTextView = 1,
    ///图片
    ZLEditTemplateUnitTypeButton ,
};

@interface ZLElectronicInvitationEditTemplateModel : NSObject

///预览模板页进入（值不同则返回方式不同）
@property (nonatomic,unsafe_unretained) BOOL isFromPreviewTemplateEnter;

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///模板id
@property (nonatomic,strong) NSString *keyId;
///请柬id
@property (nonatomic,strong) NSString *invitationId;
///请柬预览地址
@property (nonatomic,strong) NSString *invitationUrl;
///滑动视图
@property (nonatomic,unsafe_unretained) CGRect frame;
///单元页面大小（单页Max时）
@property (nonatomic,unsafe_unretained) CGSize pageSize;
///间距
@property (nonatomic,unsafe_unretained) CGFloat space;


///宴请时间（分享时用）
@property (nonatomic,strong) NSString *sharetime;
///分享地址（分享时用）
@property (nonatomic,strong) NSString *shareurl;

///当前选中的音乐模型
@property (nonatomic,strong) ZLElectronicInvitationEditTemplateModel *currentMusicModel;
///音乐地址
@property (nonatomic,strong) NSString *musicUrl;

///子模型容器
@property (nonatomic,strong) NSArray <NSArray *>*units;
///邀请函数据
@property (nonatomic,strong) NSDictionary *invitationDatas;

///控件类型
@property (nonatomic,unsafe_unretained) ZLEditTemplateUnitType unitType;
///当前事件的索引
@property (nonatomic,strong) NSIndexPath *currentIndexPath;
///将要修改的内容
@property (nonatomic,strong) NSString *willChangeValue;
///将要删除的页码索引
@property (nonatomic,unsafe_unretained) NSInteger willDeletePageIndex;
///将要上传的图片数据
@property (nonatomic,strong) NSData *imageData;

///删除编辑模块单页数据
+ (void)deleteEditTemplatePageDataWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

///删除编辑模块数据
+ (void)deleteEditTemplateDataWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

///修改编辑模块数据
+ (void)changeEditTemplateDataWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

///编辑模块数据
+ (void)editTemplateDataWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

///图片换地址（千牛）
+ (void)imageUrlWithInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

@end
