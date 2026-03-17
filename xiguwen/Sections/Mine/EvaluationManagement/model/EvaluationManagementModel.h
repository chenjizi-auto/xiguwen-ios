//
//  EvaluationManagementModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Evaluationtime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone;
@interface EvaluationManagementModel : NSObject

// custom code

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *customName;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger customStar;

@property (nonatomic, copy) NSString *customCommont;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *businessName;

@property (nonatomic, strong) Evaluationtime *evaluationTime;

@property (nonatomic, copy) NSString *province;

@end
@interface Evaluationtime : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) Chronology *chronology;

@property (nonatomic, assign) NSInteger millisOfSecond;

@property (nonatomic, assign) NSInteger weekyear;

@property (nonatomic, assign) NSInteger weekOfWeekyear;

@property (nonatomic, assign) NSInteger yearOfEra;

@property (nonatomic, assign) NSInteger dayOfYear;

@property (nonatomic, assign) NSInteger yearOfCentury;

@property (nonatomic, assign) NSInteger era;

@property (nonatomic, assign) NSInteger secondOfDay;

@property (nonatomic, assign) NSInteger millisOfDay;

@property (nonatomic, assign) NSInteger monthOfYear;

@property (nonatomic, assign) BOOL afterNow;

@property (nonatomic, assign) NSInteger secondOfMinute;

@property (nonatomic, assign) NSInteger minuteOfDay;

@property (nonatomic, assign) NSInteger minuteOfHour;

@property (nonatomic, strong) Zone *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end



