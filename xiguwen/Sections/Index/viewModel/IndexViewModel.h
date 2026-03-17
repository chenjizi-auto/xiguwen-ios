//
//  IndexViewModel.h
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndexModel.h"

@interface IndexViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray *dataArray;

//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *refreshUISubjectCH;

@property (nonatomic, strong) RACSubject *refreshUISubjectZC;

@property (nonatomic, strong) RACSubject *refreshUISubjectSY;

@property (nonatomic, strong) RACSubject *refreshUISubjectSX;

@property (nonatomic, strong) RACSubject *refreshUISubjectHZ;
//请求

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) RACCommand *refreshDataCommandCH;

@property (nonatomic, strong) RACCommand *refreshDataCommandZC;

@property (nonatomic, strong) RACCommand *refreshDataCommandSY;

@property (nonatomic, strong) RACCommand *refreshDataCommandSX;

@property (nonatomic, strong) RACCommand *refreshDataCommandHZ;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
//中
@property (nonatomic, strong) RACSubject *gotoZhongSubject;
//han
@property (nonatomic, strong) RACSubject *gotoHanSubject;
//huaxia
@property (nonatomic, strong) RACSubject *gotoHuaSubject;
//more
@property (nonatomic, strong) RACSubject *gotoMoreSubject;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;
//其它五个请求
- (void)ConvertingToObjectCH:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

- (void)ConvertingToObjectZC:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

- (void)ConvertingToObjectSY:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

- (void)ConvertingToObjectSX:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

- (void)ConvertingToObjectHZ:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
