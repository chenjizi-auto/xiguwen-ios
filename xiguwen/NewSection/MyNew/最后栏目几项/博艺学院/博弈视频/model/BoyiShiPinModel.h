//
//  BoyiShiPinModel.h
//  BoYi
//
//  Created by heng on 2018/1/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyiShiPinModel : NSObject
@property(nonatomic,copy)NSString * cover;
@property(nonatomic,assign)NSInteger create_ti;
@property(nonatomic,copy)NSString * describe;
@property(nonatomic,assign)NSInteger display;
@property(nonatomic,assign)NSInteger downloads;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger istop;
@property(nonatomic,assign)NSInteger isvipsee;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,assign)NSInteger pv;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger update_ti;
@property(nonatomic,copy)NSString* video_url;
@property(nonatomic,assign)NSInteger weight;
@end


@interface BoyShiPingTypeMode:NSObject
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)NSInteger weigh;
@end

