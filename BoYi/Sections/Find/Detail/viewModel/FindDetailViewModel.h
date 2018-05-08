//
//  FindDetailViewModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindDetailModel.h"
#import "TalkPJTableViewCell.h"
#import "FindXinXiModel.h"
#import "FindModel.h"
#import "FindTJModel.h"
#import "FindPJModel.h"

@interface FindDetailViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <FindDetailModel *>*dataArray;

@property (strong,nonatomic) FindXinXiModel *xinxiModel;

@property (strong,nonatomic) NSMutableArray <Rows *> *dataArrayTP;

@property (strong,nonatomic) NSMutableArray <EsarraytjTJ *> *dataArrayTJ;

@property (strong,nonatomic) NSMutableArray <EsarraypjPJ *> *dataArrayPJ;



//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubjectTP;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubjectTJ;

@property (nonatomic, strong) RACSubject *refreshUISubjectPJ;
//信息
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//图片
@property (nonatomic, strong) RACCommand *refreshDataCommandTP;
//推荐
@property (nonatomic, strong) RACCommand *refreshDataCommandTJ;
//评价
@property (nonatomic, strong) RACCommand *refreshDataCommandPJ;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
//look
@property (nonatomic, strong) RACSubject *lookSubject;
//more
@property (nonatomic, strong) RACSubject *moreSubject;

/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;
- (void)ConvertingToObjectTP:(id)object;
- (void)ConvertingToObjectTJ:(id)object;
@end
