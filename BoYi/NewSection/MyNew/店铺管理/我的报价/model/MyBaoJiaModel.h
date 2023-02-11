//
//  MyBaoJiaModel.h
//  BoYi
//
//  Created by heng on 2018/1/19.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBaoJiaModel : NSObject

// custom code
@property (nonatomic, strong) NSString *deductible;
@property (nonatomic, strong) NSMutableArray *imglist;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) NSInteger quotationid;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger weigh;
@property (nonatomic, strong) NSString *temporarypay;
@property (nonatomic, strong) NSString *miaoshu;

@end
