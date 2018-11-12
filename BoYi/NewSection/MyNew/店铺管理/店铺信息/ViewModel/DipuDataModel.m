//
//  DipuDataModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DipuDataModel.h"

@implementation DipuDataModel
- (instancetype)init{
    self = [super init];
    if(self){
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
        
        
        
        //处理正在请求状态
        [[self.DataIficationlistCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.DataIficationlistCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.DataIficationlistSubject sendNext:x];
        }];
        
        
        //处理正在请求状态
        [[self.UpDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.UpDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.UpDataSubject sendNext:x];
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
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Myhome/storeinformation"]
                                                          method:POST
                                                          loding:@"请求中..."
                                                             dic:input];
        }];
    }
    return _DataCommand;
}

- (RACCommand *)DataIficationlistCommand{
    if (!_DataIficationlistCommand) {
        _DataIficationlistCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Home/Classificationlist"]
                                                          method:POST
                                                          loding:@"请求中..."
                                                             dic:input];
        }];
    }
    return _DataIficationlistCommand;
}

- (RACCommand *)UpDataCommand{
    if (!_UpDataCommand) {
        _UpDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Myhome/storeinformationedit"]
                                                          method:POST
                                                          loding:@"请求中..."
                                                             dic:input];
        }];
    }
    return _UpDataCommand;
}
- (RACSubject *)UpDataSubject
{
    if (!_UpDataSubject) {
        _UpDataSubject = [RACSubject subject];
    }
    return _UpDataSubject;
}

- (RACSubject *)DataIficationlistSubject{
    if (!_DataIficationlistSubject) {
        _DataIficationlistSubject = [RACSubject subject];
    }
    return _DataIficationlistSubject;
}


/**
 * 上传图片
 */
-(void)UpImage:(NSData*)ImageData indext:(NSInteger)indext{
    NSString *base64String = [ImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    AFHTTPSessionManager * mager = [AFHTTPSessionManager manager];
    mager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];
    [mager POST:@"http://www.boyihunjia.com/appapi/System/uploadimgba" parameters:@{@"img":[@"data:image/jpg;base64," stringByAppendingString:base64String]} progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue]==0) {
            self.ImageBlock(responseObject[@"data"],indext);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
