//
//  DongtaiDetilModel.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Zanlist,PhotourldongtaiD,CommentlistDongtai,Xiaji;
@interface DongtaiDetilModel : NSObject

// custom code


@property (nonatomic, assign) NSInteger myzan;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger pv;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *theteam;

@property (nonatomic, copy) NSString *create_ti;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, strong) NSArray<Zanlist *> *zanlist;

@property (nonatomic, assign) NSInteger commentnum;

@property (nonatomic, strong) NSArray<PhotourldongtaiD *> *photourl;

@property (nonatomic, assign) NSInteger zan;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSArray<CommentlistDongtai *> *commentlist;

@property (nonatomic, copy) NSString *content;

@end
@interface Zanlist : NSObject

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *nickname;

@end

@interface PhotourldongtaiD : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger mydynamicid;

@property (nonatomic, copy) NSString *photourl;

@end

@interface CommentlistDongtai : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, strong) NSArray<Xiaji *> *xiaji;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger myzan;

@property (nonatomic, copy) NSString *create_ti;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *comm;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) NSInteger pid;

@end

@interface Xiaji : NSObject

@property (nonatomic, copy) NSString *comm;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, copy) NSString *nickname;

@end

