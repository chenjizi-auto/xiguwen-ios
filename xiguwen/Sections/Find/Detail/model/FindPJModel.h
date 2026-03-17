//
//  FindPJModel.h
//  BoYi
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EsarraypjPJ,CreatetimePJ,UncachedzonePJ,UpdatetimePJ,ZonePJ,ChronologyPJ,ZonePJ;
@interface FindPJModel : NSObject


@property (nonatomic, strong) NSArray<EsarraypjPJ *> *esArrayPJ;


@end

@interface EsarraypjPJ : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger exampleId;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) UpdatetimePJ *updateTime;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) CreatetimePJ *createTime;

@end

@interface CreatetimePJ : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyPJ *chronology;

@property (nonatomic, assign) NSInteger millisOfSecond;

@property (nonatomic, assign) NSInteger weekyear;

@property (nonatomic, assign) NSInteger weekOfWeekyear;

@property (nonatomic, assign) NSInteger yearOfEra;

@property (nonatomic, assign) NSInteger dayOfYear;

@property (nonatomic, assign) NSInteger yearOfCentury;

@property (nonatomic, assign) NSInteger era;

@property (nonatomic, assign) NSInteger secondOfDay;

@property (nonatomic, assign) NSInteger monthOfYear;

@property (nonatomic, assign) NSInteger millisOfDay;

@property (nonatomic, assign) BOOL afterNow;

@property (nonatomic, assign) NSInteger minuteOfDay;

@property (nonatomic, assign) NSInteger secondOfMinute;

@property (nonatomic, assign) NSInteger minuteOfHour;

@property (nonatomic, strong) ZonePJ *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZonePJ : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzonePJ *uncachedZone;

@end


@interface ChronologyPJ : NSObject

@property (nonatomic, strong) ZonePJ *zone;

@end

@interface UncachedzonePJ : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface UpdatetimePJ : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyPJ *chronology;

@property (nonatomic, assign) NSInteger millisOfSecond;

@property (nonatomic, assign) NSInteger weekyear;

@property (nonatomic, assign) NSInteger weekOfWeekyear;

@property (nonatomic, assign) NSInteger yearOfEra;

@property (nonatomic, assign) NSInteger dayOfYear;

@property (nonatomic, assign) NSInteger yearOfCentury;

@property (nonatomic, assign) NSInteger era;

@property (nonatomic, assign) NSInteger secondOfDay;

@property (nonatomic, assign) NSInteger monthOfYear;

@property (nonatomic, assign) NSInteger millisOfDay;

@property (nonatomic, assign) BOOL afterNow;

@property (nonatomic, assign) NSInteger minuteOfDay;

@property (nonatomic, assign) NSInteger secondOfMinute;

@property (nonatomic, assign) NSInteger minuteOfHour;

@property (nonatomic, strong) ZonePJ *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end






