//
//  ZLIntegralGoodsListModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/26.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

@interface ZLIntegralGoodsListModel : NSObject

///服务器数据页码
@property (nonatomic,unsafe_unretained) NSInteger page;
///服务器数据单页个数
@property (nonatomic,unsafe_unretained) NSInteger count;
///加载更多（YES：加载更多  NO：下拉刷新）
@property (nonatomic,unsafe_unretained) BOOL more;
///展示无更多
@property (nonatomic,unsafe_unretained) BOOL showNoMore;


///单元模型
@property (nonatomic,strong) NSArray <ZLIntegralGoodsListModel *>*unitModels;
///下文主键
@property (nonatomic,strong) NSString *keyId;
///图片地址
@property (nonatomic,strong) NSString *imageUrl;
///标题
@property (nonatomic,strong) NSString *title;
///积分
@property (nonatomic,strong) NSString *integral;


///积分商品
+ (void)integralGoodsListWithInfoModel:(ZLIntegralGoodsListModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete;

@end
