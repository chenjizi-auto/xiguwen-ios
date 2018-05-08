//
//  BoyiYinYueViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "BoyiYinYueViewModel.h"
@interface BoyiYinYueViewModel()

@property (nonatomic, strong) RACCommand *Command;

@property (nonatomic, strong) RACSubject *Subject;
@end
@implementation BoyiYinYueViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        //处理正在请求状态
        [[self.Command executing] subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self);
        }];
        //请求成功
        [self.Command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.Subject sendNext:x];
        }];
        
    }
    return self;
}

- (RACSubject *)Subject {
    
    if (!_Subject) _Subject = [RACSubject subject];
    
    return _Subject;
}
- (RACCommand *)Command {
    
    if (!_Command) {
        @weakify(self);
        _Command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Boyicollege/collegemusiclist"]
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _Command;
}



-(void)Request:(NSDictionary*)param{
    [self.Command execute:param];
    __weak typeof(self)weakSelf = self;
    [self.Subject subscribeNext:^(id  _Nullable x) {
        [weakSelf handleData:x];
    }];
}


-(void)handleData:(id)data{
    [({if(!self.tuijian) self.tuijian = [[NSMutableArray alloc] init];
        if (self.isfresh) [self.tuijian removeAllObjects];
        self.tuijian;
    }) addObjectsFromArray:[BoyiYinYueModel mj_objectArrayWithKeyValuesArray:data[@"tuijian"]]];
    [({if(!self.zuire) self.zuire = [[NSMutableArray alloc] init];
        if (self.isfresh) [self.zuire removeAllObjects];
        self.zuire;
    }) addObjectsFromArray:[BoyiYinYueModel mj_objectArrayWithKeyValuesArray:data[@"zuire"]]];
    
    [({if(!self.zuixin) self.zuixin = [[NSMutableArray alloc] init];
        if (self.isfresh) [self.zuixin removeAllObjects];
        self.zuixin;
    }) addObjectsFromArray:[BoyiYinYueModel mj_objectArrayWithKeyValuesArray:data[@"zuixin"]]];
    if (!self.typeArray) {
        self.typeArray =  [BoyShiPingTypeMode mj_objectArrayWithKeyValuesArray:data[@"type"]];
    }
    self.Mblock();
}
@end
