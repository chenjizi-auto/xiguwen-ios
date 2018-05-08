//
//  HotListviewModel.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotModel.h"
#import "fenLeiModel.h"
@interface HotListviewModel : NSObject<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <HotModel *>*dataArray;
@property (strong,nonatomic) HotModel *model;
@property (strong,nonatomic) NSMutableArray *headerArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
//筛选回调
@property (nonatomic, strong) RACSubject *shaixuanSubject;

@property (nonatomic, strong) RACSubject *bannerSubject;//banner
//加载首页分类列表
@property (nonatomic, strong) RACSubject *fenleilistUISubject;
@property (nonatomic, strong) RACCommand *fenleilistDataCommand;
//区域
@property (nonatomic, strong) RACCommand *getquyuDataCommand;
@property (nonatomic, strong) RACSubject *getquyuUISubject;
//分类列表
@property (strong,nonatomic) NSArray *fenleiArray;
@property (assign ,nonatomic) BOOL isZankai;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
