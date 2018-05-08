//
//  DongtaiDetilViewModel.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DongtaiDetilModel.h"


@interface DongtaiDetilViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) DongtaiDetilModel *model;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (assign, nonatomic) NSInteger isPinglun;

@property (nonatomic, strong) RACSubject *pinglunseleUISubject;
@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;
@property (nonatomic, strong) RACCommand *dianzanCommand;
@property (nonatomic, strong) RACCommand *deleteDianzanCommand;
@property (nonatomic, strong) RACSubject *refreshdateSubject;
@property (nonatomic, strong) RACSubject *addguanzhuSubject;
@property (nonatomic, strong) RACSubject *deleguanzhuSubject;



/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
