//
//  SearchshangjiaListViewModel.h
//  BoYi
//
//  Created by heng on 2018/2/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnlieListModel.h"


@interface SearchshangjiaListViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) NSMutableArray <Shangjiatuanduilist *>*dataArray;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//区域
@property (nonatomic, strong) RACCommand *getquyuDataCommand;
@property (nonatomic, strong) RACSubject *getquyuUISubject;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (nonatomic, strong) RACSubject *fenleilistUISubject;
@property (nonatomic, strong) RACCommand *fenleilistDataCommand;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
