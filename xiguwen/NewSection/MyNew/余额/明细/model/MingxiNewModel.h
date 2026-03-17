//
//  MingxiNewModel.h
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MingxiNewModel : NSObject

// custom code
@property (nonatomic, strong) NSString *aftermoney;
@property (nonatomic, strong) NSString *beforemoney;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *inmoney;
@property (nonatomic, strong) NSString *outmoney;
@property (nonatomic, assign) NSInteger relation_id;
@property (nonatomic, strong) NSString *relation_model;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, assign) NSInteger trade_type;
@property (nonatomic, assign) NSInteger updated_at;
@property (nonatomic, assign) NSInteger userid;

@end
