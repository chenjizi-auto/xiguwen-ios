//
//  ZLElectronicInvitationHomeModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/6.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

@interface ZLElectronicInvitationHomeModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///服务器数据页码
@property (nonatomic,unsafe_unretained) NSInteger page;
///服务器数据单页个数
@property (nonatomic,unsafe_unretained) NSInteger count;
///加载更多（YES：加载更多  NO：下拉刷新）
@property (nonatomic,unsafe_unretained,getter=isLoadMore) BOOL loadMore;
///展示无更多
@property (nonatomic,unsafe_unretained,getter=isAllowShowNoMore) BOOL showNoMore;
///数据是否已经到达
@property (nonatomic,unsafe_unretained,getter=isDataDidArrive) BOOL dataArrive;

///单元模型
@property (nonatomic,strong) NSArray <ZLElectronicInvitationHomeModel *>*unitModels;
///下文主键
@property (nonatomic,strong) NSString *keyId;
///图片地址
@property (nonatomic,strong) NSString *imageUrl;
///链接地址
@property (nonatomic,strong) NSString *htmlUrl;
///宴请时间（分享时用）
@property (nonatomic,strong) NSString *sharetime;
///分享地址（分享时用）
@property (nonatomic,strong) NSString *shareurl;

///电子请柬首页数据
+ (void)electronicInvitationHomeDataWithInfoModel:(ZLElectronicInvitationHomeModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
