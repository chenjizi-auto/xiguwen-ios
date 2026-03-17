//
//  GGListModel.h
//  BoYi
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EsarrayqweQWR,CreatetimeQWS,ZoneQWH,UncachedzoneQWJ,ChronologyQWD,ZoneQWF,UncachedzoneQWG,UpdatetimeQWT,ZoneQWP,UncachedzoneQWA,ChronologyQWU,ZoneQWI,UncachedzoneQWO;
@interface GGListModel : NSObject



@property (nonatomic, strong) NSArray<EsarrayqweQWR *> *esArrayQWE;


@end
@interface EsarrayqweQWR : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *parentName;

@property (nonatomic, assign) NSInteger isCheck;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, strong) UpdatetimeQWT *updateTime;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *goodEvaluation;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *positionName;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger positionId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *commentCount;

@property (nonatomic, copy) NSString *urlStatus;

@property (nonatomic, strong) CreatetimeQWS *createTime;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *updateTimeStr;

@property (nonatomic, copy) NSString *entityId;

@end

@interface CreatetimeQWS : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyQWD *chronology;

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

@property (nonatomic, assign) NSInteger secondOfMinute;

@property (nonatomic, assign) NSInteger minuteOfDay;

@property (nonatomic, assign) NSInteger minuteOfHour;

@property (nonatomic, strong) ZoneQWH *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZoneQWH : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneQWJ *uncachedZone;

@end

@interface UncachedzoneQWJ : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface ChronologyQWD : NSObject

@property (nonatomic, strong) ZoneQWF *zone;

@end

@interface ZoneQWF : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneQWG *uncachedZone;

@end

@interface UncachedzoneQWG : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface UpdatetimeQWT : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyQWU *chronology;

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

@property (nonatomic, assign) NSInteger secondOfMinute;

@property (nonatomic, assign) NSInteger minuteOfDay;

@property (nonatomic, assign) NSInteger minuteOfHour;

@property (nonatomic, strong) ZoneQWP *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZoneQWP : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneQWA *uncachedZone;

@end

@interface UncachedzoneQWA : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface ChronologyQWU : NSObject

@property (nonatomic, strong) ZoneQWI *zone;

@end

@interface ZoneQWI : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneQWO *uncachedZone;

@end

@interface UncachedzoneQWO : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

