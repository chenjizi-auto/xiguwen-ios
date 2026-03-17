//
//  RiChengNewViewModel.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RiChengNewModel.h"


@interface RiChengNewViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <Newrichengarray *>*dataArray;
@property (strong,nonatomic) NSMutableArray <Newrichengarray *>*dataArrayWancheng;
@property (strong,nonatomic) NSMutableArray <Newrichengarray *>*dataArrayJintian;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

// 删除某个
@property (nonatomic, strong) RACSubject *deleteItemSubject;
// 修改某个状态
@property (nonatomic, strong) RACSubject *statusItemSubject;
// 编辑某个内容
@property (nonatomic, strong) RACSubject *editItemSubject;

/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
