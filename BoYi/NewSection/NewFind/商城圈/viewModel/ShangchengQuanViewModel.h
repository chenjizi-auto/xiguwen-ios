//
//  ShangchengQuanViewModel.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HunqinQuanModel.h"


@interface ShangchengQuanViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (strong,nonatomic) NSMutableArray <Hunqinnewarray *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
//点赞
@property (nonatomic, strong) RACSubject *dianzanSubject;
//加载首页分类列表
@property (nonatomic, strong) RACSubject *fenleilistUISubject;
@property (nonatomic, strong) RACCommand *fenleilistDataCommand;

@property (nonatomic, strong) RACSubject *pinglunseleUISubject;
@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;
@property (nonatomic, strong) RACCommand *dianzanCommand;
@property (nonatomic, strong) RACCommand *deleteDianzanCommand;
@property (nonatomic, strong) RACSubject *refreshdateSubject;


@property (nonatomic, strong) Hunqinnewarray *selectModel;
@property (nonatomic, copy) void(^onSelectedImage)(NSArray *array,NSInteger index);
@property (nonatomic, copy) void(^onSelectedHeader)(NSInteger index);
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
