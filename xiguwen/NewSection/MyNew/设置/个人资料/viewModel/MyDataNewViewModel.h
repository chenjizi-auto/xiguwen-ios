//
//  MyDataNewViewModel.h
//  BoYi
//
//  Created by heng on 2018/1/9.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDataNewModel.h"


@interface MyDataNewViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSArray *titleArray;
@property (strong,nonatomic) NSArray *titleKeyArray;
@property (strong,nonatomic) NSArray *cityKeyArray;
@property (strong,nonatomic) NSMutableArray <MyDataNewModel *>*dataArray;
@property (strong,nonatomic) NSMutableDictionary *dicInfo;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//更新数据
@property (nonatomic, strong) RACSubject *selectItemSubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
@property (nonatomic, strong) RACCommand *updateDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *updateRequestSubject;


/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
