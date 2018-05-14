//
//  ZLShopDetailsModel.m
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsModel.h"
#import "ZLHTTPSessionManager.h"

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

///各大区头高度
@property (nonatomic,strong) NSArray *sectionHeaderHeightsArray;
///各大区尾高度
@property (nonatomic,strong) NSArray *sectionFooterHeightsArray;

@end

@implementation ZLShopDetailsModel

#pragma mark - Lazy
- (NSMutableArray *)cellModelsArrayM {
    if (!_cellModelsArrayM) {
        _cellModelsArrayM = [NSMutableArray new];
        for (NSInteger index = 0; index < self.titlesArray.count; index++) {
            [_cellModelsArrayM addObject:[NSMutableArray new]];
        }
    }
    return _cellModelsArrayM;
}
- (NSArray *)sectionFooterHeightsArray {
    if (!_sectionFooterHeightsArray) {
        _sectionHeaderHeightsArray = @[@"50.0",
                                       @"30.0",
                                       @"30.0",
                                       @"30.0",
                                       @"30.0",
                                       @"50.0",
                                       @"0"];
    }
    return _sectionFooterHeightsArray;
}
- (NSArray *)sectionHeaderHeightsArray {
    if (!_sectionHeaderHeightsArray) {
        _sectionHeaderHeightsArray = @[@"50.0",
                                       @"50.0",
                                       @"50.0",
                                       @"50.0",
                                       @"50.0",
                                       @"10.0",
                                       @"0"];
    }
    return _sectionHeaderHeightsArray;
}

#pragma mark -
+ (instancetype)loadStaticData {
    ZLShopDetailsModel *dataModel = [self new];
    dataModel.navTitle = @"商家详情页";
    dataModel.titlesArray = @[@"首页",@"报价"];//,@"作品",@"评价",@"动态",@"档期",@"资料"

    //调试动态数据
    [self debugDataWithModel:dataModel];
    
    return dataModel;
}

///调试数据
+ (void)debugDataWithModel:(ZLShopDetailsModel *)dataModel {
    dataModel.title = @"标题标题标题标题标题标题标题标题";
    dataModel.honorsArray = @[@"诚信认证1",@"平台认证1",@"实名认证1",@"平台认证1"];
    dataModel.position = @"队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员";
    dataModel.gradesArray = @[@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1"];
    dataModel.listArray = @[@"浏览   221",@"浏览   221",@"浏览   221"];
    dataModel.address = @"成都市高新区云华路西部信息安全产业园";
    dataModel.phoneNumber = @"10086";
    //首页
    NSInteger section = 1;
    NSInteger row = 1;
    for (NSInteger a = 0; a < section; a++) {
        ZLShopDetailsModel *sectionModel = [self new];
        sectionModel.sectionHeaderTitle = @"区头（333）";
        sectionModel.sectionFooterTitle = @"区尾（333）";
        //模块方案
        sectionModel.moduleStrategy = ZLShopDetailsModuleStrategyStateHome;
        //单元格方案
        sectionModel.cellStrategy = ZLShopDetailsCellStrategyStatePrice;
        //区头高度
        sectionModel.sectionHeaderHeight = [sectionModel.sectionHeaderHeightsArray[sectionModel.moduleStrategy] floatValue];
        //区尾高度
        sectionModel.sectionFooterHeight = 50.0;
        //单元格个数
        sectionModel.cellCount = 4;
        sectionModel.subModelsArrayM = [NSMutableArray new];
        for (NSInteger b = 0; b < row; b++) {
            ZLShopDetailsModel *rowModel = [self new];
            //单元格属性
            rowModel.headImageUrlPath = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526207673432&di=b2a07c33638ed86e183707421de8cabf&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D2296122566%2C1658273351%26fm%3D214%26gp%3D0.jpg";
            rowModel.title = @"婚礼堂";
            rowModel.price = @"￥44400起";
            rowModel.number = @"已售 888";
            //单元格高度
            rowModel.cellHeight = 185.0;
            [sectionModel.subModelsArrayM addObject:rowModel];
        }
        [dataModel.cellModelsArrayM[0] addObject:sectionModel];
    }
    
    //报价
    //作品
    //评价
    //动态
    //档期
    //资料
}

///请求数据
+ (void)requestShopDetailsWithModel:(ZLShopDetailsModel *)model {
//    [ZLHTTPSessionManager requestDataWithUrlPath:<#(NSString *)#> Params:<#(id)#> POST:<#(BOOL)#> ModelArray:<#(NSArray<ZLFileModel *> *)#> HttpHeader:<#(BOOL)#> Results:<#^(ZLSessionManagerErrorState sessionErrorState, id responseObject)complete#>]
}

@end
