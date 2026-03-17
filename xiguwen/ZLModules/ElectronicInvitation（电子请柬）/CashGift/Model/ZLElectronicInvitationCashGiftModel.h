//
//  ZLElectronicInvitationCashGiftModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/12.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLHTTPSessionManager.h"

@interface ZLElectronicInvitationCashGiftModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///下文主键
@property (nonatomic,strong) NSString *keyId;
///服务器数据页码
@property (nonatomic,unsafe_unretained) NSInteger page;
///服务器数据单页个数
@property (nonatomic,unsafe_unretained) NSInteger count;
///展示静态界面
@property (nonatomic,unsafe_unretained,getter=isAllowShowStaticPage) BOOL showStaticPage;
///加载更多（YES：加载更多  NO：下拉刷新）
@property (nonatomic,unsafe_unretained,getter=isLoadMore) BOOL loadMore;
///展示无更多
@property (nonatomic,unsafe_unretained,getter=isAllowShowNoMore) BOOL showNoMore;
///单元模型
@property (nonatomic,strong) NSArray <ZLElectronicInvitationCashGiftModel *>*unitModels;

///姓名
@property (nonatomic,strong) NSString *name;
///时间
@property (nonatomic,strong) NSString *time;
///金额
@property (nonatomic,strong) NSString *amount;

///礼金数据
+ (void)cashGiftDataWithInfoModel:(ZLElectronicInvitationCashGiftModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
