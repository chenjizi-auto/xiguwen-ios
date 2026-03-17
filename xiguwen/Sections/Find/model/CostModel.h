//
//  CostModel.h
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RowsGB,CreatetimeGH,ZoneGZ,UncachedzoneGX,ChronologyGJ,ZoneGK,UncachedzoneGL,UpdatetimeGC,ZoneGN,UncachedzoneGM,ChronologyGV,ZoneGB,UncachedzoneGN;
@interface CostModel : NSObject

// custom code


@property (nonatomic, assign) NSInteger nowPage;

@property (nonatomic, strong) NSArray<RowsGB *> *rows;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger totalPage;


@end
@interface RowsGB : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, strong) UpdatetimeGC *updateTime;

@property (nonatomic, assign) NSInteger exampleId;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) CreatetimeGH *createTime;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *material;

@end

@interface CreatetimeGH : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyGJ *chronology;

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

@property (nonatomic, strong) ZoneGZ *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZoneGZ : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneGX *uncachedZone;

@end

@interface UncachedzoneGX : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface ChronologyGJ : NSObject

@property (nonatomic, strong) ZoneGK *zone;

@end

@interface ZoneGK : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneGL *uncachedZone;

@end

@interface UncachedzoneGL : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface UpdatetimeGC : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyGV *chronology;

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

@property (nonatomic, strong) ZoneGN *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZoneGN : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneGM *uncachedZone;

@end

@interface UncachedzoneGM : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface ChronologyGV : NSObject

@property (nonatomic, strong) ZoneGB *zone;

@end

@interface ZoneGB : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneGN *uncachedZone;

@end

@interface UncachedzoneGN : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

