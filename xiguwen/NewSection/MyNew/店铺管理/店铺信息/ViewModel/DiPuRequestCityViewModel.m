//
//  DiPuRequestCityViewModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/24/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DiPuRequestCityViewModel.h"

@implementation DiPuRequestCityViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        //处理正在请求状态
        [[self.DataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.DataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.Subject sendNext:x];
        }];
    }
    return self;
}
- (RACSubject *)Subject{
    if (!_Subject) _Subject = [RACSubject subject];
    return _Subject;
}

/**
 * appapi/Home/Classificationlist //职业类型
 * appapi/Myhome/storeinformation xi
 */
- (RACCommand *)DataCommand
{
    if (!_DataCommand) {
        @weakify(self);
        _DataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/system/huoqudiqu"]
                                                          method:POST
                                                          loding:@"请求中..."
                                                             dic:input];
        }];
    }
    return _DataCommand;
}

@end
