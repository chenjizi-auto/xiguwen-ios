//
//  CheckFriendsWeddingModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EvaluationManagementModel.h"

@class Evaluationtime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Scheduledate,Zone,Uncachedzone,Chronology,Zone,Uncachedzone;
@interface CheckFriendsWeddingModel : NSObject

// custom code

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *customName;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger customStar;

@property (nonatomic, copy) NSString *customCommont;

@property (nonatomic, strong) Scheduledate *scheduleDate;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *businessName;

@property (nonatomic, strong) Evaluationtime *evaluationTime;

@property (nonatomic, copy) NSString *province;

@end




