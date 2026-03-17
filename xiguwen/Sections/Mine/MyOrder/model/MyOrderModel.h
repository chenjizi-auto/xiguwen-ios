//
//  MyOrderModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bizuser,Bizwork,User,Createtime,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,Detailinfobvolist,Byuserbizproduct,Bizuser,Scheduledate,Zone,Uncachedzone,Chronology,Zone,Uncachedzone,User;
@interface MyOrderModel : NSObject

// custom code

@property (nonatomic, copy) NSString *alipaysellerid;

@property (nonatomic, strong) User *user;

@property (nonatomic, copy) NSString *alipaytradestatus;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *userStarEnd;

@property (nonatomic, assign) NSInteger findFlag;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) CGFloat deposit;

@property (nonatomic, copy) NSString *userStars;

@property (nonatomic, copy) NSString *weixinbanktype;

@property (nonatomic, copy) NSString *alipaynotifyid;

@property (nonatomic, copy) NSString *weixintradetype;

@property (nonatomic, copy) NSString *alipaygmtcreate;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *redPacketMoney;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *businessName;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *weixinopenid;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *needPayPrice;

@property (nonatomic, copy) NSString *alipaytotalfee;

@property (nonatomic, assign) NSInteger payStatus;

@property (nonatomic, copy) NSString *start;

@property (nonatomic, copy) NSString *alipayselleremail;

@property (nonatomic, copy) NSString *weixintimer;

@property (nonatomic, copy) NSString *customName;

@property (nonatomic, assign) NSInteger payType;

@property (nonatomic, copy) NSString *bizComment;

@property (nonatomic, copy) NSString *voucher;

@property (nonatomic, copy) NSString *alipaytradeno;

@property (nonatomic, copy) NSString *weixincashfee;

@property (nonatomic, copy) NSString *refundDesn;

@property (nonatomic, copy) NSString *end;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *weixinissubscribe;

@property (nonatomic, copy) NSString *weixinorderid;

@property (nonatomic, strong) NSArray<Detailinfobvolist *> *detailInfoBvoList;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *evaluationTime;

@property (nonatomic, copy) NSString *alipaynotifytime;

@property (nonatomic, copy) NSString *weixinfeetype;

@property (nonatomic, copy) NSString *userComment;

@property (nonatomic, copy) NSString *orderType;

@property (nonatomic, copy) NSString *alipaynotifytype;

@property (nonatomic, copy) NSString *weixinsign;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *alipaygmtpayment;

@property (nonatomic, strong) Createtime *createTime;

@property (nonatomic, copy) NSString *weixincashfeetype;

@property (nonatomic, copy) NSString *bizStars;

@property (nonatomic, copy) NSString *coins;

@property (nonatomic, copy) NSString *userStarStart;

@property (nonatomic, strong) Bizuser *bizUser;

@property (nonatomic, copy) NSString *bizUserId;

@end
@interface Bizuser : NSObject

@property (nonatomic, copy) NSString *bizDealCount;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, strong) Bizwork *bizWork;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *bizWorkType;

@property (nonatomic, copy) NSString *agent;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *userType;

@property (nonatomic, copy) NSString *goods;

@property (nonatomic, assign) CGFloat bizPrice;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *remoteFee;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *username;

@end

@interface User : NSObject

@property (nonatomic, copy) NSString *authName;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *id;

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

@property (nonatomic, copy) NSString *bizAgentId;

@property (nonatomic, copy) NSString *wxOpenid;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *wxUnionid;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *orderCount;

@property (nonatomic, copy) NSString *agent;

@property (nonatomic, copy) NSString *identityPic;

@property (nonatomic, copy) NSString *money;

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

@property (nonatomic, copy) NSString *userType;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *tagNames;

@property (nonatomic, copy) NSString *redPacket;

@property (nonatomic, copy) NSString *coins;

@property (nonatomic, copy) NSString *bizDealCount;

@property (nonatomic, copy) NSString *bizBookCount;

@end



@interface Detailinfobvolist : NSObject

@property (nonatomic, strong) Byuserbizproduct *byUserBizProduct;

@property (nonatomic, strong) Scheduledate *scheduleDate;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *userComment;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *userStar;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, strong) Bizuser *bizUser;

@property (nonatomic, copy) NSString *scheduleType;

@property (nonatomic, assign) CGFloat deposit;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, strong) User *user;

@property (nonatomic, copy) NSString *dinnerAddress;

@property (nonatomic, copy) NSString *coins;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *dinnerType;

@property (nonatomic, copy) NSString *bizUserId;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *userId;

@end

@interface Byuserbizproduct : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *productType;

@property (nonatomic, copy) NSString *channelId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *deposit;

@property (nonatomic, copy) NSString *coins;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *originalPrice;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *auditCount;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *updateTime;

@end

@interface Scheduledate : NSObject

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

@property (nonatomic, assign) NSInteger secondOfDay;

@property (nonatomic, assign) NSInteger dayOfYear;

@property (nonatomic, assign) NSInteger yearOfCentury;

@property (nonatomic, assign) NSInteger era;

@property (nonatomic, assign) NSInteger yearOfEra;

@property (nonatomic, assign) NSInteger millisOfDay;

@property (nonatomic, assign) NSInteger monthOfYear;

@property (nonatomic, assign) BOOL afterNow;

@property (nonatomic, assign) NSInteger secondOfMinute;

@property (nonatomic, assign) NSInteger minuteOfDay;

@property (nonatomic, assign) NSInteger minuteOfHour;

@property (nonatomic, strong) Zone *zone;

@property (nonatomic, assign) NSInteger dayOfMonth;

@end


