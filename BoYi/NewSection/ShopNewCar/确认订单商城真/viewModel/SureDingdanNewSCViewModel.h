//
//  SureDingdanNewSCViewModel.h
//  BoYi
//
//  Created by heng on 2018/3/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sureDingdanSCmodel.h"
@interface SureDingdanNewSCViewModel : NSObject<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,assign)NSInteger type; //1立即2购物车
// custom code
@property (strong,nonatomic) NSMutableArray <CartlistSC *>*dataArray;

@property (strong,nonatomic) sureDingdanSCmodel *model;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
//备注
@property (nonatomic, strong) NSString *note;


/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;
@end
