//
//  CertificationDataModel.h
//  BoYi
//
//  Created by Niklaus on 2018/3/29.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CertificationNew,PlatformAuth,IntegrityAuth,InstituteAuth;

@interface CertificationDataModel : NSObject

// 认证模块信息

@property (nonatomic, strong) PlatformAuth *pingtai;// 平台认证
@property (nonatomic, strong) IntegrityAuth *chengxin;// 诚信认证
@property (nonatomic, strong) NSArray<InstituteAuth *> *xueyuan;// 学院认证


@end

@interface PlatformAuth : NSObject
// 平台认证
@property (nonatomic, assign) NSInteger id;// 认证id
@property (nonatomic, strong) NSString *parameter1;// 认证名称
@property (nonatomic, strong) NSString *parameter2;// 认证金额
@property (nonatomic, assign) NSInteger state;// 认证状态
@property (nonatomic, strong) NSString * userid;// 用户id
@property (nonatomic, strong) NSString *statusStr;// 认证状态显示
@property (nonatomic, assign) NSInteger uid;

@end

@interface IntegrityAuth : NSObject
// 诚信认证
@property (nonatomic, assign) NSInteger id;// 认证id
@property (nonatomic, strong) NSArray *jine;// 诚信认证类型数组
@property (nonatomic, strong) NSString *parameter1;// 认证名称
@property (nonatomic, strong) NSString *parameter2;// 认证金额
@property (nonatomic, assign) NSInteger state;// 认证状态
@property (nonatomic, assign) NSInteger userid;// 用户id
@property (nonatomic, strong) NSString *statusStr;// 认证状态显示
@property (nonatomic, assign) NSInteger uid;

@end

@interface InstituteAuth : NSObject
// 学院认证
@property (nonatomic, assign) NSInteger id;// 认证id
@property (nonatomic, strong) NSString *parameter1;// 认证名称
@property (nonatomic, strong) NSString *parameter2;// 认证金额
@property (nonatomic, assign) NSInteger state;// 认证状态
@property (nonatomic, strong) NSString *userid;// 用户id
@property (nonatomic, strong) NSString *statusStr;// 认证状态显示
@property (nonatomic, strong) NSString *content;// 拒绝原因
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger did;
@end

