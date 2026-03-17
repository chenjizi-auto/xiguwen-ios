//
//  ShetuanDetilViewModel.h
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShetuanDetilModel.h"
#import "shetuanChengyuanModel.h"
#import "shetuanZuppinModel.h"
#import "ShetuanLinxiModel.h"

@interface ShetuanDetilViewModel : NSObject <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

// custom code
@property (strong,nonatomic) ShetuanDetilModel *modelIndex;
@property (strong,nonatomic) shetuanChengyuanModel *modelChengyuan;
@property (strong,nonatomic) shetuanZuppinModel *modelZuopin;
@property (strong,nonatomic) ShetuanLinxiModel *modellianxi;
//刷新数据的时候使用
@property (nonatomic, strong) RACSubject *refreshUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *refreshDataCommand;
//重新加载数据
@property (nonatomic, strong) RACCommand *zuopinDataCommand;
@property (nonatomic, strong) RACSubject *zuopinUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *chengyuanDataCommand;
@property (nonatomic, strong) RACSubject *chengyuanUISubject;
//重新加载数据
@property (nonatomic, strong) RACCommand *lianxifangshiDataCommand;
@property (nonatomic, strong) RACSubject *lianxifangshiUISubject;
//选择某个
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (nonatomic, strong) RACSubject *isNavViewSubject;

@property (nonatomic, assign) NSInteger markType;


@property (nonatomic, strong) RACCommand *refrepinglunDataCommand;
@property (nonatomic, strong) RACSubject *pinglunUISubject;

//关注

@property (nonatomic, strong) RACSubject *guanzhuUISubject;
@property (nonatomic, strong) RACCommand *addguanzhuCommand;
@property (nonatomic, strong) RACCommand *deleguanzhuCommand;
@property (nonatomic, strong) RACCommand *dianzanCommand;

//登录
@property (nonatomic, strong) RACSubject *loginubject;

//点击
@property (nonatomic, strong) RACSubject *selectRenSubject;
@property (nonatomic, strong) RACSubject *selectZuopinSubject;
@property (nonatomic, strong) RACSubject *selectLianxiRenmSubject;

@property (nonatomic, strong) RACSubject *pinglunseleUISubject;
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh;

@end
