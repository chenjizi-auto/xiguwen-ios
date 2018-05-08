//
//  BoyiShiPinCommentDetailViewModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPinCommentDetailViewModel.h"

@interface BoyiShiPinCommentDetailViewModel()
@property(nonatomic,strong)RACCommand *Command;
@property(nonatomic,strong)RACSubject *Subject;
@end
@implementation BoyiShiPinCommentDetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        [[self.Command executing] subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self);
        }];
        [self.Command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.Subject sendNext:x];
        }];
    }
    return self;
}
- (RACCommand *)Command
{
    if (!_Command) {
        _Command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return  [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Boyicollege/byvideodetails"] method:POST loding:@"加载中..." dic:input];
        }];
    }
    return _Command;
}
- (RACSubject *)Subject{
    if (!_Subject) {
        _Subject = [RACSubject subject];
    }
    return _Subject;
}
-(void)Request:(NSDictionary*)param{
    [self.Command execute:param];
    __weak typeof(self)weakSelf = self;
    [self.Subject subscribeNext:^(id  _Nullable x) {
        BoyiShiPinDetailModel *model =  [BoyiShiPinDetailModel mj_objectWithKeyValues:x];
        weakSelf.Mblock(model);
    }];
}
@end
