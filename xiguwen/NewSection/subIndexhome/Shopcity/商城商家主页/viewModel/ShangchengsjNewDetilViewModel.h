//
//  ShangchengsjNewDetilViewModel.h
//  BoYi
//
//  Created by heng on 2018/2/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShangchengsjNewDetilModel.h"
#import "shangjiaPinglunModel.h"
#import "NewShangjiaDongtaiModel.h"

@interface ShangchengsjNewDetilViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
//动态数组
@property (strong,nonatomic) NSMutableArray <Dongtaiarray *>*dataArrayDongtai;

@property (strong,nonatomic) NSMutableArray <Shangjiapinglun *>*dataArrayPingjia;

@property (strong,nonatomic) NSMutableArray <Shopshangchengsj *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

//主页
@property (nonatomic, strong) RACCommand *indexDataCommand;
//主页
@property (nonatomic, strong) RACSubject *indexSubject;
//热门
@property (nonatomic, strong) RACCommand *hotDataCommand;
//热门
@property (nonatomic, strong) RACSubject *hotSubject;



//评论
@property (nonatomic, strong) RACCommand *pinglunDataCommand;
@property (nonatomic, strong) RACSubject *pinglunSubject;
//动态
@property (nonatomic, strong) RACCommand *dongtaiDataCommand;
@property (nonatomic, strong) RACSubject *dongtaiSubject;

@property (assign, nonatomic) NSInteger type;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
