//
//  MyNewModel.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNewModel : NSObject
@end


@interface DiPuDataModel:NSObject
@property(nonatomic,copy)NSString* background;
@property(nonatomic,assign)NSInteger cityid;
@property(nonatomic,copy)NSString* content;
@property(nonatomic,assign)NSInteger countyid;
@property(nonatomic,copy)NSString* nickname;
@property(nonatomic,assign)NSInteger occupationid;
@property(nonatomic,copy)NSArray* shopimg;
@property(nonatomic,assign)NSInteger provinceid;
@property(nonatomic,copy)NSString* site;
@property(nonatomic,assign)NSInteger team;
@property(nonatomic,assign)NSInteger userid;
@property(nonatomic,copy)NSString * message;
@end
