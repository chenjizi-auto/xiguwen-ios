//
//  MyNewViewModel.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyNewModel.h"


@interface MyNewViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <MyNewModel *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
//用户传递tag
@property (nonatomic, strong) RACSubject *userTagSubject;
//商家传递tag
@property (nonatomic, strong) RACSubject *shangjiaTagSubject;

//商家传递taghunqin
@property (nonatomic, strong) RACSubject *shangjiaHunQinTagSubject;

@property (nonatomic, assign) BOOL isUser;

/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
