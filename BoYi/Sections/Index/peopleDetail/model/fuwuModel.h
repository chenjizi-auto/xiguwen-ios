//
//  fuwuModel.h
//  BoYi
//
//  Created by apple on 2017/8/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Esarrayqw,Createtimeo,ZoneZ,Uncachedzoned,Chronologyp,Zonea,Uncachedzones,Updatetimee,Zoneu,Uncachedzonei,Chronologyr,Zonet,Uncachedzoney;
@interface fuwuModel : NSObject



@property (nonatomic, strong) NSArray<Esarrayqw *> *esArrayq;


@end
@interface Esarrayqw : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) NSInteger productType;

@property (nonatomic, assign) NSInteger channelId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger deposit;

@property (nonatomic, assign) NSInteger coins;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *originalPrice;

@property (nonatomic, assign) NSInteger currentPrice;

@property (nonatomic, strong) Createtimeo *createTime;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, assign) NSInteger auditCount;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Updatetimee *updateTime;

@property (nonatomic, assign) BOOL isSele;

@end

@interface Createtimeo : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) Chronologyp *chronology;

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

@property (nonatomic, strong) Zone *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZoneZ : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) Uncachedzoned *uncachedZone;

@end

@interface Uncachedzoned : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface Chronologyp : NSObject

@property (nonatomic, strong) Zonea *zone;

@end

@interface Zonea : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) Uncachedzones *uncachedZone;

@end

@interface Uncachedzones : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface Updatetimee : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) Chronologyr *chronology;

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

@property (nonatomic, strong) Zoneu *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface Zoneu : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) Uncachedzonei *uncachedZone;

@end

@interface Uncachedzonei : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface Chronologyr : NSObject

@property (nonatomic, strong) Zonet *zone;

@end

@interface Zonet : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) Uncachedzoney *uncachedZone;

@end

@interface Uncachedzoney : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

