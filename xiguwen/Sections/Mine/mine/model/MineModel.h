//
//  MineModel.h
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreatetimeMS,ZoneMI,UncachedzoneMU,ChronologyMA,ZoneMP,UncachedzoneMO,UserbizauthMN,CreatetimeMB,ZoneMZ,UncachedzoneML,ChronologyMV,ZoneMC,UncachedzoneMX,UpdatetimeMK,ZoneMF,UncachedzoneMD,ChronologyMJ,ZoneMH,UncachedzoneMG;
@interface MineModel : NSObject

// custom code


@property (nonatomic, copy) NSString *authName;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *wechat;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *bizCommentCount;

@property (nonatomic, copy) NSString *commission;

@property (nonatomic, copy) NSString *mobile1;

@property (nonatomic, strong) NSArray<UserbizauthMN *> *userBizAuth;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *bizYdCount;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *bizProductCount;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *isHot;

@property (nonatomic, copy) NSString *paySecret;

@property (nonatomic, copy) NSString *bizViewCount;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *trueName;

@property (nonatomic, copy) NSString *validate_code;

@property (nonatomic, copy) NSString *occupation;

@property (nonatomic, copy) NSString *born;

@property (nonatomic, copy) NSString *credibility;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *bizWorkType;

@property (nonatomic, copy) NSString *frozenMoney;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *remoteFee;

@property (nonatomic, copy) NSString *bizStyle;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *bizPrice;

@property (nonatomic, copy) NSString *wxAccessToken;

@property (nonatomic, copy) NSString *bizCommissionRatio;

@property (nonatomic, copy) NSString *creditData;

@property (nonatomic, copy) NSString *bizAgentId;

@property (nonatomic, copy) NSString *wxOpenid;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *wxUnionid;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *orderCount;

@property (nonatomic, copy) NSString *agent;

@property (nonatomic, copy) NSString *identityPic;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, copy) NSString *tagIds;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *bizType;

@property (nonatomic, copy) NSString *currentprice;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *identity;

@property (nonatomic, copy) NSString *diction;

@property (nonatomic, copy) NSString *rolename;

@property (nonatomic, copy) NSString *levelCoins;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, strong) CreatetimeMS *createTime;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *tagNames;

@property (nonatomic, copy) NSString *redPacket;

@property (nonatomic, copy) NSString *coins;

@property (nonatomic, assign) NSInteger bizDealCount;

@property (nonatomic, copy) NSString *bizBookCount;


@end
@interface CreatetimeMS : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyMA *chronology;

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

@property (nonatomic, strong) ZoneMI *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZoneMI : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneMU *uncachedZone;

@end

@interface UncachedzoneMU : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface ChronologyMA : NSObject

@property (nonatomic, strong) ZoneMP *zone;

@end

@interface ZoneMP : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneMO *uncachedZone;

@end

@interface UncachedzoneMO : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface UserbizauthMN : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger authLevel;

@property (nonatomic, copy) NSString *dailishangId;

@property (nonatomic, strong) UpdatetimeMK *updateTime;

@property (nonatomic, assign) NSInteger certificatesType;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger authType;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, strong) CreatetimeMB *createTime;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *businessType;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger status;

@end

@interface CreatetimeMB : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyMV *chronology;

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

@property (nonatomic, strong) ZoneMZ *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZoneMZ : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneML *uncachedZone;

@end

@interface UncachedzoneML : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface ChronologyMV : NSObject

@property (nonatomic, strong) ZoneMC *zone;

@end

@interface ZoneMC : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneMX *uncachedZone;

@end

@interface UncachedzoneMX : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface UpdatetimeMK : NSObject

@property (nonatomic, assign) BOOL equalNow;

@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, assign) long long millis;

@property (nonatomic, assign) NSInteger centuryOfEra;

@property (nonatomic, assign) BOOL beforeNow;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger hourOfDay;

@property (nonatomic, strong) ChronologyMJ *chronology;

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

@property (nonatomic, strong) ZoneMF *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface ZoneMF : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneMD *uncachedZone;

@end

@interface UncachedzoneMD : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface ChronologyMJ : NSObject

@property (nonatomic, strong) ZoneMH *zone;

@end

@interface ZoneMH : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) UncachedzoneMG *uncachedZone;

@end

@interface UncachedzoneMG : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

