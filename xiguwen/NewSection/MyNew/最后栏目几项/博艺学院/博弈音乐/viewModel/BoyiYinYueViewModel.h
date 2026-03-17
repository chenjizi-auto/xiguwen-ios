//
//  BoyiYinYueViewModel.h
//  BoYi
//
//  Created by heng on 2018/1/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoyiYinYueModel.h"
typedef NS_ENUM(NSInteger) {
    tuijian=1,
    zuire=2,
    zuixin=3,
    typeArray=4
}DATATYPE;
typedef void(^YueViewModelBlock)();
@interface BoyiYinYueViewModel : NSObject
@property(nonatomic,strong)NSMutableArray<BoyiYinYueModel*> *tuijian;
@property(nonatomic,strong)NSMutableArray<BoyiYinYueModel*> *zuire;
@property(nonatomic,strong)NSMutableArray<BoyiYinYueModel*> *zuixin;
@property(nonatomic,strong)NSMutableArray<BoyShiPingTypeMode*> *typeArray;
@property(nonatomic,strong)YueViewModelBlock Mblock;
@property(nonatomic,assign) BOOL isfresh;//判断是否是刷新
/**
 * 数据获取
 */
-(void)Request:(NSDictionary*)param;
@end

