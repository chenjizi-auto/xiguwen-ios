//
//  UserInfoModel.h
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/19.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Createtime,Zone,Uncachedzone,Chronology,Updatetime,UserBizAuth;
@interface UserInfoModel : NSObject<NSCopying>


@property (nonatomic, assign) NSInteger addressId;


@property (nonatomic, copy) NSString *creditData;

@property (nonatomic, strong) NSArray<UserBizAuth *> *userBizAuth;

@property (nonatomic, copy) NSString *authName;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *wechat;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *bizCommentCount;

@property (nonatomic, copy) NSString *commission;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *bizYdCount;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *bizProductCount;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger isHot;

@property (nonatomic, copy) NSString *paySecret;

@property (nonatomic, copy) NSString *bizViewCount;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *trueName;

@property (nonatomic, copy) NSString *validate_code;

@property (nonatomic, copy) NSString *occupation;

@property (nonatomic, copy) NSString *born;

@property (nonatomic, copy) NSString *credibility;

@property (nonatomic, assign) NSInteger status;

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

@property (nonatomic, copy) NSString *bizAgentId;

@property (nonatomic, copy) NSString *wxOpenid;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *wxUnionid;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger orderCount;

@property (nonatomic, copy) NSString *agent;

@property (nonatomic, copy) NSString *identityPic;

@property (nonatomic, assign) CGFloat money;

@property (nonatomic, copy) NSString *tagIds;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *bizType;

@property (nonatomic, copy) NSString *currentprice;

@property (nonatomic, strong) Updatetime *updateTime;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *identity;

@property (nonatomic, copy) NSString *diction;

@property (nonatomic, copy) NSString *rolename;

@property (nonatomic, assign) NSInteger levelCoins;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, strong) Createtime *createTime;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *tagNames;

@property (nonatomic, copy) NSString *redPacket;

@property (nonatomic, assign) NSInteger coins;

@property (nonatomic, copy) NSString *bizDealCount;

@property (nonatomic, copy) NSString *bizBookCount;

@end

@interface Createtime : NSObject

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

@property (nonatomic, assign) NSInteger monthOfYear;

@property (nonatomic, assign) NSInteger millisOfDay;

@property (nonatomic, assign) BOOL afterNow;

@property (nonatomic, assign) NSInteger minuteOfDay;

@property (nonatomic, assign) NSInteger secondOfMinute;

@property (nonatomic, assign) NSInteger minuteOfHour;

@property (nonatomic, strong) Zone *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end

@interface Zone : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) Uncachedzone *uncachedZone;

@end

@interface Uncachedzone : NSObject

@property (nonatomic, assign) BOOL fixed;

@property (nonatomic, assign) BOOL cachable;

@property (nonatomic, copy) NSString *id;

@end

@interface Chronology : NSObject

@property (nonatomic, strong) Zone *zone;

@end





@interface Updatetime : NSObject

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

@property (nonatomic, assign) NSInteger monthOfYear;

@property (nonatomic, assign) NSInteger millisOfDay;

@property (nonatomic, assign) BOOL afterNow;

@property (nonatomic, assign) NSInteger minuteOfDay;

@property (nonatomic, assign) NSInteger secondOfMinute;

@property (nonatomic, assign) NSInteger minuteOfHour;

@property (nonatomic, strong) Zone *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end


@interface UserBizAuth : NSObject



@property (nonatomic, assign) NSInteger authLevel;

@property (nonatomic, assign) NSInteger authType;


@end

    
