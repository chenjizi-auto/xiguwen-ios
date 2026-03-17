//
//  ZLIntegralDetailModel.h
//  BoYi
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

@interface ZLIntegralDetailModel : NSObject

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///服务器数据页码
@property (nonatomic,unsafe_unretained) NSInteger page;
///服务器数据单页个数
@property (nonatomic,unsafe_unretained) NSInteger count;
///加载更多（YES：加载更多  NO：下拉刷新）
@property (nonatomic,unsafe_unretained) BOOL more;
///展示无更多
@property (nonatomic,unsafe_unretained) BOOL showNoMore;


///单元模型
@property (nonatomic,strong) NSArray <ZLIntegralDetailModel *>*unitModels;
///标题
@property (nonatomic,strong) NSString *title;
///时间
@property (nonatomic,strong) NSString *time;
///积分
@property (nonatomic,strong) NSString *integral;


///积分明细
+ (void)integralDetailWithInfoModel:(ZLIntegralDetailModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
