//
//  peopleDetailModel.h
//  BoYi
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChannelL,CommentsQ,CommentlistW,UserE,CreatetimeA,IchronologyS,IbaseD,IbaseF,IbaseG,IparamH,IzoneJ,UpdatetimeR,IchronologyT,IbaseY,IbaseU,IbaseI,IparamO,IzoneP,UserTS,CreatetimeTZ,IchronologyTX,IbaseTC,IbaseTV,IbaseTB,IparamTN,IzoneTM,UpdatetimeTD,IchronologyTF,IbaseTG,IbaseTH,IbaseTJ,IparamTK,IzoneTL,YoulikelistbWE,UserinfobvoWR,BizworkWT,AuthlistWY,CreatetimeWF,IchronologyWG,IbaseWH,IbaseWJ,IbaseWK,IparamWL,IzoneWZ,UpdatetimeWU,IchronologyWI,IbaseWO,IbaseWP,IbaseWA,IparamWS,IzoneWD,RecommendusersZ,CreatetimeQT,IchronologyQY,IbaseQU,IbaseQI,IbaseQO,IparamQP,IzoneQA,RecommenduserX,BizworkC,UpdatetimeV,IchronologyB,IbaseN,IbaseM,IbaseQW,IparamQE,IzoneQR,UserQS,CreatetimeQZ,IchronologyQX,IbaseQC,IbaseQV,IbaseQB,IparamQN,IzoneQM,UpdatetimeQD,IchronologyQF,IbaseQG,IbaseQH,IbaseQJ,IparamQK,IzoneQL,ProductlistWX,CreatetimeET,IchronologyEY,IbaseEU,IbaseEI,IbaseEO,IparamEP,IzoneTA,UpdatetimeW,IchronologyWC,IbaseWV,IbaseWB,IbaseWN,IparamWM,IzoneER,ExamplelistYQ,UserinfobvoYW,BizworkYE;
@interface peopleDetailModel : NSObject



@property (nonatomic, strong) CommentsQ *comments;

@property (nonatomic, strong) NSMutableDictionary *openCitiesMap;

@property (nonatomic, strong) NSArray *topList;

@property (nonatomic, strong) ChannelL *channel;

@property (nonatomic, strong) NSArray<RecommendusersZ *> *recommendUsers;

@property (nonatomic, strong) NSArray<YoulikelistbWE *> *youLikeListB;

@property (nonatomic, strong) NSArray<AuthlistWY *> *authList;

@property (nonatomic, copy) NSString *scheduleData;

@property (nonatomic, strong) NSArray<NSString *> *openProvinces;

@property (nonatomic, copy) NSString *creditData;

@property (nonatomic, strong) NSArray<ProductlistWX *> *productList;

@property (nonatomic, strong) UserTS *user;

@property (nonatomic, strong) NSArray<ExamplelistYQ *> *exampleList;

@property (nonatomic, copy) NSString *follow;

@end



@interface ChannelL : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger findFlag;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, assign) NSInteger positionId;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *url;

@end


@interface CommentsQ : NSObject

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<CommentlistW *> *commentList;

@end

@interface CommentlistW : NSObject

@property (nonatomic, assign) NSInteger orderId;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, strong) UserE *user;

@end

@interface UserE : NSObject

@property (nonatomic, assign) NSInteger bizWorkType;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger bizDealCount;

@property (nonatomic, assign) NSInteger levelCoins;

@property (nonatomic, assign) NSInteger coins;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger orderCount;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, strong) UpdatetimeR *updateTime;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger bizViewCount;

@property (nonatomic, assign) NSInteger isHot;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, assign) NSInteger bizAgentId;

@property (nonatomic, copy) NSString *tagNames;

@property (nonatomic, strong) CreatetimeA *createTime;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, copy) NSString *trueName;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) NSInteger bizPrice;

@property (nonatomic, copy) NSString *identity;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, assign) NSInteger bizProductCount;

@end

@interface CreatetimeA : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyS *iChronology;

@end

@interface IchronologyS : NSObject

@property (nonatomic, strong) IbaseD *iBase;

@end

@interface IbaseD : NSObject

@property (nonatomic, strong) IbaseF *iBase;

@property (nonatomic, strong) IparamH *iParam;

@end

@interface IbaseF : NSObject

@property (nonatomic, strong) IbaseG *iBase;

@end

@interface IbaseG : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamH : NSObject

@property (nonatomic, strong) IzoneJ *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneJ : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface UpdatetimeR : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyT *iChronology;

@end

@interface IchronologyT : NSObject

@property (nonatomic, strong) IbaseY *iBase;

@end

@interface IbaseY : NSObject

@property (nonatomic, strong) IbaseU *iBase;

@property (nonatomic, strong) IparamO *iParam;

@end

@interface IbaseU : NSObject

@property (nonatomic, strong) IbaseI *iBase;

@end

@interface IbaseI : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamO : NSObject

@property (nonatomic, strong) IzoneP *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneP : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface UserTS : NSObject

@property (nonatomic, assign) NSInteger bizWorkType;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger bizDealCount;

@property (nonatomic, assign) NSInteger levelCoins;

@property (nonatomic, assign) NSInteger coins;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger orderCount;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, strong) UpdatetimeTD *updateTime;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger bizViewCount;

@property (nonatomic, assign) NSInteger isHot;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *tagNames;

@property (nonatomic, strong) CreatetimeTZ *createTime;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, copy) NSString *trueName;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) NSInteger bizPrice;

@property (nonatomic, copy) NSString *identity;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, assign) CGFloat money;

@property (nonatomic, assign) NSInteger bizProductCount;

@end

@interface CreatetimeTZ : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyTX *iChronology;

@end

@interface IchronologyTX : NSObject

@property (nonatomic, strong) IbaseTC *iBase;

@end

@interface IbaseTC : NSObject

@property (nonatomic, strong) IbaseTV *iBase;

@property (nonatomic, strong) IparamTN *iParam;

@end

@interface IbaseTV : NSObject

@property (nonatomic, strong) IbaseTB *iBase;

@end

@interface IbaseTB : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamTN : NSObject

@property (nonatomic, strong) IzoneTM *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneTM : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface UpdatetimeTD : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyTF *iChronology;

@end

@interface IchronologyTF : NSObject

@property (nonatomic, strong) IbaseTG *iBase;

@end

@interface IbaseTG : NSObject

@property (nonatomic, strong) IbaseTH *iBase;

@property (nonatomic, strong) IparamTK *iParam;

@end

@interface IbaseTH : NSObject

@property (nonatomic, strong) IbaseTJ *iBase;

@end

@interface IbaseTJ : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamTK : NSObject

@property (nonatomic, strong) IzoneTL *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneTL : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface YoulikelistbWE : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *caseTime;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger totalD;

@property (nonatomic, copy) NSString *caseDetail;

@property (nonatomic, assign) NSInteger exampleType;

@property (nonatomic, assign) NSInteger goodD;

@property (nonatomic, copy) NSString *caseComment;

@property (nonatomic, copy) NSString *caseEnvironment;

@property (nonatomic, copy) NSString *caseType;

@property (nonatomic, strong) UserinfobvoWR *userInfoBvo;

@property (nonatomic, copy) NSString *caseHotel;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger status;

@end

@interface UserinfobvoWR : NSObject

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, strong) BizworkWT *bizWork;

@property (nonatomic, copy) NSString *area;

@end

@interface BizworkWT : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger findFlag;

@end

@interface AuthlistWY : NSObject

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger authType;

@property (nonatomic, strong) UpdatetimeWU *updateTime;

@property (nonatomic, assign) NSInteger authLevel;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, strong) CreatetimeWF *createTime;

@end

@interface CreatetimeWF : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyWG *iChronology;

@end

@interface IchronologyWG : NSObject

@property (nonatomic, strong) IbaseWH *iBase;

@end

@interface IbaseWH : NSObject

@property (nonatomic, strong) IbaseWJ *iBase;

@property (nonatomic, strong) IparamWL *iParam;

@end

@interface IbaseWJ : NSObject

@property (nonatomic, strong) IbaseWK *iBase;

@end

@interface IbaseWK : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamWL : NSObject

@property (nonatomic, strong) IzoneWZ *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneWZ : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface UpdatetimeWU : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyWI *iChronology;

@end

@interface IchronologyWI : NSObject

@property (nonatomic, strong) IbaseWO *iBase;

@end

@interface IbaseWO : NSObject

@property (nonatomic, strong) IbaseWP *iBase;

@property (nonatomic, strong) IparamWS *iParam;

@end

@interface IbaseWP : NSObject

@property (nonatomic, strong) IbaseWA *iBase;

@end

@interface IbaseWA : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamWS : NSObject

@property (nonatomic, strong) IzoneWD *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneWD : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface RecommendusersZ : NSObject

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger recommendId;

@property (nonatomic, assign) NSInteger exampleId;

@property (nonatomic, strong) RecommenduserX *recommendUser;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, strong) UpdatetimeV *updateTime;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) CreatetimeQT *createTime;

@property (nonatomic, strong) UserQS *user;

@end

@interface CreatetimeQT : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyQY *iChronology;

@end

@interface IchronologyQY : NSObject

@property (nonatomic, strong) IbaseQU *iBase;

@end

@interface IbaseQU : NSObject

@property (nonatomic, strong) IbaseQI *iBase;

@property (nonatomic, strong) IparamQP *iParam;

@end

@interface IbaseQI : NSObject

@property (nonatomic, strong) IbaseQO *iBase;

@end

@interface IbaseQO : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamQP : NSObject

@property (nonatomic, strong) IzoneQA *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneQA : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface RecommenduserX : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger bizPrice;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, strong) BizworkC *bizWork;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, assign) NSInteger bizDealCount;

@property (nonatomic, assign) NSInteger bizWorkType;

@end

@interface BizworkC : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger findFlag;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, assign) NSInteger positionId;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *url;

@end

@interface UpdatetimeV : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyB *iChronology;

@end

@interface IchronologyB : NSObject

@property (nonatomic, strong) IbaseN *iBase;

@end

@interface IbaseN : NSObject

@property (nonatomic, strong) IbaseM *iBase;

@property (nonatomic, strong) IparamQE *iParam;

@end

@interface IbaseM : NSObject

@property (nonatomic, strong) IbaseQW *iBase;

@end

@interface IbaseQW : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamQE : NSObject

@property (nonatomic, strong) IzoneQR *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneQR : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface UserQS : NSObject

@property (nonatomic, assign) NSInteger bizWorkType;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger bizDealCount;

@property (nonatomic, assign) NSInteger levelCoins;

@property (nonatomic, assign) NSInteger coins;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger orderCount;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, strong) UpdatetimeQD *updateTime;

@property (nonatomic, copy) NSString *bizCover;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger bizViewCount;

@property (nonatomic, assign) NSInteger isHot;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *bizStar;

@property (nonatomic, copy) NSString *tagNames;

@property (nonatomic, strong) CreatetimeQZ *createTime;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, copy) NSString *trueName;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) NSInteger bizPrice;

@property (nonatomic, copy) NSString *identity;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, assign) CGFloat money;

@property (nonatomic, assign) NSInteger bizProductCount;

@end

@interface CreatetimeQZ : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyQX *iChronology;

@end

@interface IchronologyQX : NSObject

@property (nonatomic, strong) IbaseQC *iBase;

@end

@interface IbaseQC : NSObject

@property (nonatomic, strong) IbaseQV *iBase;

@property (nonatomic, strong) IparamQN *iParam;

@end

@interface IbaseQV : NSObject

@property (nonatomic, strong) IbaseQB *iBase;

@end

@interface IbaseQB : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamQN : NSObject

@property (nonatomic, strong) IzoneQM *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneQM : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface UpdatetimeQD : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyQF *iChronology;

@end

@interface IchronologyQF : NSObject

@property (nonatomic, strong) IbaseQG *iBase;

@end

@interface IbaseQG : NSObject

@property (nonatomic, strong) IbaseQH *iBase;

@property (nonatomic, strong) IparamQK *iParam;

@end

@interface IbaseQH : NSObject

@property (nonatomic, strong) IbaseQJ *iBase;

@end

@interface IbaseQJ : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamQK : NSObject

@property (nonatomic, strong) IzoneQL *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneQL : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface ProductlistWX : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) NSInteger productType;

@property (nonatomic, assign) NSInteger channelId;

@property (nonatomic, assign) NSInteger deposit;

@property (nonatomic, assign) NSInteger coins;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger currentPrice;

@property (nonatomic, strong) CreatetimeET *createTime;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, assign) NSInteger auditCount;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UpdatetimeW *updateTime;

@end

@interface CreatetimeET : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyEY *iChronology;

@end

@interface IchronologyEY : NSObject

@property (nonatomic, strong) IbaseEU *iBase;

@end

@interface IbaseEU : NSObject

@property (nonatomic, strong) IbaseEI *iBase;

@property (nonatomic, strong) IparamEP *iParam;

@end

@interface IbaseEI : NSObject

@property (nonatomic, strong) IbaseEO *iBase;

@end

@interface IbaseEO : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamEP : NSObject

@property (nonatomic, strong) IzoneTA *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneTA : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface UpdatetimeW : NSObject

@property (nonatomic, assign) long long iMillis;

@property (nonatomic, strong) IchronologyWC *iChronology;

@end

@interface IchronologyWC : NSObject

@property (nonatomic, strong) IbaseWV *iBase;

@end

@interface IbaseWV : NSObject

@property (nonatomic, strong) IbaseWB *iBase;

@property (nonatomic, strong) IparamWM *iParam;

@end

@interface IbaseWB : NSObject

@property (nonatomic, strong) IbaseWN *iBase;

@end

@interface IbaseWN : NSObject

@property (nonatomic, assign) NSInteger iMinDaysInFirstWeek;

@end

@interface IparamWM : NSObject

@property (nonatomic, strong) IzoneER *iZone;

@property (nonatomic, copy) NSString *iID;

@property (nonatomic, strong) NSArray *iInfoCache;

@end

@interface IzoneER : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *iStandardOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iWallOffsets;

@property (nonatomic, strong) NSArray<NSNumber *> *iTransitions;

@property (nonatomic, strong) NSArray<NSString *> *iNameKeys;

@property (nonatomic, copy) NSString *iID;

@end

@interface ExamplelistYQ : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *caseTime;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger totalD;

@property (nonatomic, copy) NSString *caseDetail;

@property (nonatomic, assign) NSInteger exampleType;

@property (nonatomic, assign) NSInteger goodD;

@property (nonatomic, copy) NSString *caseComment;

@property (nonatomic, copy) NSString *caseEnvironment;

@property (nonatomic, copy) NSString *caseType;

@property (nonatomic, strong) UserinfobvoYW *userInfoBvo;

@property (nonatomic, copy) NSString *caseHotel;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, assign) NSInteger status;

@end

@interface UserinfobvoYW : NSObject

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, strong) BizworkYE *bizWork;

@property (nonatomic, copy) NSString *area;

@end

@interface BizworkYE : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger findFlag;

@end

