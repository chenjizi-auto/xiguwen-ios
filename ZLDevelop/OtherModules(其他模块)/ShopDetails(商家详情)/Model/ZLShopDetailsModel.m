//
//  ZLShopDetailsModel.m
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsModel.h"
#import "ZLShopDetailsParsingModel.h"

/* 数据结构
 ZLShopDetailsModel{
    navTitle = @"导航栏标题",
    title = @"姓名",
    ...
    cellModelsArrayM = {
        cellModelsArrayM = {
            *subModel = {
                title = @"区头值",
                ...
                subModelsArrayM = {
                    *subModel = {
                        title = @"单元格标题",
                        ...
                    }
                    ...
                }
            }
            ...
        }
    }
 }
 */

@interface ZLShopDetailsModel ()

///商家详情地址
@property (nonatomic,strong) NSArray *urlStrArray;
//商家id
@property(nonatomic,strong) NSNumber *shopId;

@end

@implementation ZLShopDetailsModel

#pragma mark - StaticData
+ (instancetype)loadStaticDataWithShopId:(NSNumber *)shopId {
    ZLShopDetailsModel *dataModel = [self new];
    dataModel.navTitle = @"商家详情页";
    dataModel.titlesArray = @[@"首页",@"报价",@"作品",@"评价",@"动态",@"档期",@"资料"];
    dataModel.urlStrArray = @[@"http://www.boyihunjia.com/appapi/User/index",
                              @"http://www.boyihunjia.com/appapi/User/baojialist",
                              @"http://www.boyihunjia.com/appapi/User/zuopinlist",
                              @"http://www.boyihunjia.com/appapi/User/businesscomment",
                              @"http://www.boyihunjia.com/appapi/User/dongtaiapp",
                              @"http://www.boyihunjia.com/appapi/User/dangqi",
                              @"http://www.boyihunjia.com/appapi/User/merchantdata",];
    dataModel.shopId = shopId;
    dataModel.cellModelsArrayM = [NSMutableArray arrayWithObjects:[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new], nil];
    return dataModel;
}

#pragma mark - Request
+ (void)requestShopDetailsWithModel:(ZLShopDetailsModel *)model Results:(void (^)(ZLSessionManagerErrorState sessionErrorState))complete {
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (model.moduleStrategy == ZLShopDetailsModuleStrategyStateInfo) {
        params[@"userid"] = model.shopId;
    }else {
        params[@"id"] = model.shopId;
    }
    [ZLHTTPSessionManager requestDataWithUrlPath:model.urlStrArray[model.moduleStrategy] Params:params POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        //解析
        [ZLShopDetailsParsingModel modelDataWithResponseObject:responseObject Model:model];
        //回执下文
        complete(ZLSessionManagerErrorStateNull);
    }];
}

@end
