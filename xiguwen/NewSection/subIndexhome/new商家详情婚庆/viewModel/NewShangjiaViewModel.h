//
//  NewShangjiaViewModel.h
//  BoYi
//
//  Created by heng on 2017/12/21.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewShangjiaModel.h"
#import "NewShangjiaDongtaiModel.h"
#import "NewShangjiaDangqiModel.h"
#import "shangjiaZiliaoModel.h"
#import "shangjiaPinglunModel.h"

@interface NewShangjiaViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <NewShangjiaModel *>*dataArray;

@property (strong,nonatomic) NewShangjiaModel *model;

@property (strong,nonatomic) shangjiaZiliaoModel *shangjiaModel;

//报价数组
@property (strong,nonatomic) NSMutableArray <Baojiashangjiafen *>*dataArrayBaojia;
//作品数组
@property (strong,nonatomic) NSMutableArray <Zuopinnewfen *>*dataArrayZuopin;
//动态数组
@property (strong,nonatomic) NSMutableArray <Dongtaiarray *>*dataArrayDongtai;
//档期数组
@property (strong,nonatomic) NSMutableArray <Dangqinnewarray *>*dataArrayDangqi;
//评价数组
@property (strong,nonatomic) NSMutableArray <Shangjiapinglun *>*dataArrayPingjia;

@property (strong,nonatomic) NSString *dongtaiNumber;

@property (strong,nonatomic) NSString *pingjiaNumber;
//专门刷新数据
@property (nonatomic, strong) RACSubject *refreshUITypeSubject;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//请求报价列表
@property (nonatomic, strong) RACCommand *refreshBaojiaListDataCommand;
@property (nonatomic, strong) RACSubject *BaojiaListUISubject;
//请求作品列表
@property (nonatomic, strong) RACCommand *refreZuopinListDataCommand;
@property (nonatomic, strong) RACSubject *ZuopinListUISubject;
//请求动态列表
@property (nonatomic, strong) RACCommand *refreDongtaiListDataCommand;
@property (nonatomic, strong) RACSubject *DongtaiListUISubject;
//请求档期
@property (nonatomic, strong) RACCommand *refredangqiListDataCommand;
@property (nonatomic, strong) RACSubject *dangqiUISubject;
//请求资料
@property (nonatomic, strong) RACCommand *refreziliaoDataCommand;
@property (nonatomic, strong) RACSubject *ziliaoUISubject;
//请求资料
@property (nonatomic, strong) RACCommand *refrepinglunDataCommand;
@property (nonatomic, strong) RACSubject *pinglunUISubject;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (nonatomic, assign) NSInteger markType;


//关注
@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;

@property (nonatomic, strong) RACSubject *addguanUISubject;
@property (nonatomic, strong) RACSubject *deleteguanzhuUISubject;

@property (nonatomic, strong) RACCommand *dianzanCommand;
@property (nonatomic, strong) RACSubject *dianzansuessUISubject;//点赞陈工回调

@property (nonatomic, strong) RACSubject *dianzanUISubject;//点赞回调
@property (nonatomic, strong) RACSubject *pinglunseleUISubject;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;
- (void)Convertin:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;
// 首页报价
@property (nonatomic, strong) RACSubject *shouyeSubject;
@property (nonatomic, strong) RACSubject *zuopinindexSubject;
// 报价
@property (nonatomic, strong) RACSubject *baojiaSubject;
// 作品
@property (nonatomic, strong) RACSubject *zuopinSubject;
// 评价
@property (nonatomic, strong) RACSubject *pingjiaSubject;
// 动态
@property (nonatomic, strong) RACSubject *dongtaiSubject;
// 档期
@property (nonatomic, strong) RACSubject *dangqiSubject;
//电话
@property (nonatomic, strong) RACSubject *iphoneSubject;
//更多报价
@property (nonatomic, strong) RACSubject *moreBaojiaSubject;
//更多作品
@property (nonatomic, strong) RACSubject *morezuopinSubject;
//推荐点击
@property (nonatomic, strong) RACSubject *tuijianSubject;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) RACSubject *lookImageSubject;//看图

@property (nonatomic, strong) RACSubject *hiddenNavSubject;// 隐藏导航栏

@end
