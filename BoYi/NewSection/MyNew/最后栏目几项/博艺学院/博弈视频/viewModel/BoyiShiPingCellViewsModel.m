//
//  BoyiShiPingCellViewsModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPingCellViewsModel.h"

@implementation BoyiShiPingCellViewsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        [[self.command executing] subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self);
        }];
        [self.command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.subject sendNext:x];
        }];
    }
    return self;
}
- (RACCommand *)command{
    if (!_command) {
        _command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Boyicollege/collegevideolist"] method:POST loding:@"加载中...." dic:input];
        }];
    }
    return _command;
}

- (RACSubject *)subject{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}
@end
