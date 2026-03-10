//
//  ZLSelectBankCardModel.h
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/10/30.
//  Copyright © 2018年   . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLSelectBankCardModel : NSObject

///页码
@property (nonatomic,unsafe_unretained) NSInteger page;
///单页数量
@property (nonatomic,unsafe_unretained) NSInteger size;
///加载更多
@property (nonatomic,unsafe_unretained) BOOL loadMore;
///没有更多
@property (nonatomic,unsafe_unretained) BOOL noMore;

///主键id
@property (nonatomic,strong) NSString *keyId;
///标题
@property (nonatomic,strong) NSString *keyTitle;
///标题
@property (nonatomic,strong) NSString *subTitle;

///单元模型
@property (nonatomic,strong) NSMutableArray <ZLSelectBankCardModel *>*unitModels;

///下拉刷新、上拉加载
@property (nonatomic,copy) void (^load)(void);
///处理结果
@property (nonatomic,copy) void (^results)(void);
///删除银行卡
@property (nonatomic,copy) void (^deleteBankCard)(void);
///删除银行卡
@property (nonatomic,copy) void (^deleteBankCardResults)(void);
///事件
@property (nonatomic,copy) void (^action)(ZLSelectBankCardModel *unitModel);

///加载模型
+ (instancetype)loadModel;

@end
