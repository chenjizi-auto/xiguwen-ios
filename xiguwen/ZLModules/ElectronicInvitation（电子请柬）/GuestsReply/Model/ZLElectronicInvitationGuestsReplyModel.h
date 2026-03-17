//
//  ZLElectronicInvitationGuestsReplyModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

///回复页类型
typedef NS_ENUM (NSInteger , ZLInvitationGuestsReplyType){
    ///祝福
    ZLInvitationGuestsReplyTypeBless = 0,
    ///赴宴
    ZLInvitationGuestsReplyTypeGoToDinner ,
    ///待定
    ZLInvitationGuestsReplyTypeWaitSure ,
};

@interface ZLElectronicInvitationGuestsReplyModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///服务器数据页码
@property (nonatomic,unsafe_unretained) NSInteger page;
///服务器数据单页个数
@property (nonatomic,unsafe_unretained) NSInteger count;
///静态赋值（主视图在创建时，会创建一个数据管理者，当这个数据管理者被主视图引用时，当前状态值会改为YES）
@property (nonatomic,unsafe_unretained,getter=isStaticGiveValue) BOOL staticGiveValue;
///加载更多（YES：加载更多  NO：下拉刷新）
@property (nonatomic,unsafe_unretained,getter=isLoadMore) BOOL loadMore;
///展示无更多
@property (nonatomic,unsafe_unretained,getter=isAllowShowNoMore) BOOL showNoMore;
///数据是否已经到达
@property (nonatomic,unsafe_unretained,getter=isDataDidArrive) BOOL dataArrive;

///当前区域索引
@property (nonatomic,unsafe_unretained) NSInteger currentSection;
///展示静态界面
@property (nonatomic,unsafe_unretained) BOOL showStaticPage;

///区域模型:每个区域模型为本类对象，区域模型记载着当前请柬类型的数据加载状态，用于保存缓存数据。
@property (nonatomic,strong) NSArray <ZLElectronicInvitationGuestsReplyModel *>*sectionModels;
///单元模型
@property (nonatomic,strong) NSArray <ZLElectronicInvitationGuestsReplyModel *>*unitModels;

///将要删除的模型
@property (nonatomic,strong) ZLElectronicInvitationGuestsReplyModel *willDeleteModel;

///下文主键
@property (nonatomic,strong) NSString *keyId;
///标题
@property (nonatomic,strong) NSString *title;
///标题宽度
@property (nonatomic,unsafe_unretained) CGFloat titleWidth;
///时间
@property (nonatomic,strong) NSString *time;
///内容
@property (nonatomic,strong) NSString *content;
///内容高度
@property (nonatomic,unsafe_unretained) CGFloat contentHeight;
///单元格高度
@property (nonatomic,unsafe_unretained) CGFloat cellHeight;
///赴宴人数、赴宴状态
@property (nonatomic,unsafe_unretained) NSInteger value;


///删除数据
+ (void)dleteDataWithInfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

///宾客回复数据
+ (void)guestsReplyDataWithInfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
