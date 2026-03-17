//
//  RequestManager.h
//  Sahara
//
//  Created by Chen on 15/6/12.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//
typedef NS_ENUM(NSInteger, RequestMethod) {
    GET,          // regular table view
    POST,         // preferences style table view
    PUT,
    DELETE
};
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SBJson4.h"
#import <RACSignal.h>

@interface RequestManager : NSObject
+ (id)sharedManager;



/**
 通过RAC进行请求
 
 @param url 地址
 @param method 请求类型
 @param loding 加载图
 @param dic 传值
 @return 返回信号
 */
- (RACSignal *)RACRequestUrl:(NSString *)url
                      method:(RequestMethod)method
                      loding:(NSString *)loding
                         dic:(NSDictionary *)dic;


/**
  请求
 
 @param url 地址
 @param method 请求方式
 @param loding 加载
 @param dic info
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return 网络请求的task
 */
- (NSURLSessionDataTask *)requestUrl:(NSString *)url
                              method:(RequestMethod)method
                              loding:(NSString *)loding
                                 dic:(NSDictionary *)dic
                            progress:(void (^)(NSProgress *progress))progress
                             success:(void (^)(NSURLSessionDataTask *task, id response))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;




- (NSURLSessionDataTask *)PostUrl:(NSString *)url
                           loding:(NSString *)loding
                              dic:(NSDictionary *)dic
                    Authorization:(NSString *)Authorization
                          success:(void (^)(NSURLSessionDataTask *task, id response))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)GETUrl:(NSString *)url
                             dic:(NSDictionary *)dic
                        progress:(void (^)(NSProgress *))progress
                         success:(void (^)(NSURLSessionDataTask *task, id response))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)PUTUrl:(NSString *)url
                          loding:(NSString *)loding
                             dic:(NSDictionary *)dic
                   Authorization:(NSString *)Authorization
                         success:(void (^)(NSURLSessionDataTask *task, id response))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)DELETEUrl:(NSString *)url
                             loding:(NSString *)loding
                                dic:(NSDictionary *)dic
                      Authorization:(NSString *)Authorization
                            success:(void (^)(NSURLSessionDataTask *task, id response))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
//上传图片
-(void)updatePic:(NSData *)data
      parameters:(id)parameters
        response:(void (^)(id response))callBack;
//上传多张图片
-(NSURLSessionDataTask *)updatePics:(NSArray *)pics url:(NSString *)url parameters:(id)parameters response:(void (^)(id response))callBack;
+ (NSString *)SbJson:(id)obj;
+ (NSString *)JsonStr:(id)obj;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)myViewController;
@end
