//
//  NewShangjiaDangqiModel.h
//  BoYi
//
//  Created by heng on 2018/2/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dangqinnewarray,DangqiNew;
@interface NewShangjiaDangqiModel : NSObject

@property (nonatomic, strong) NSArray<Dangqinnewarray *> *dangqinNewArray;

@end
@interface Dangqinnewarray : NSObject

@property (nonatomic, assign) NSInteger danshu;

@property (nonatomic, strong) NSArray<DangqiNew *> *dangqi;

@property (nonatomic, copy) NSString *dateye;

@end

@interface DangqiNew : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *dateye;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger create_ti;

@property (nonatomic, copy) NSString *contactnumber;

@property (nonatomic, copy) NSString *update_ti;

@property (nonatomic, assign) NSInteger shijiancuo;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *contacts;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *timeslot;

@property (nonatomic, copy) NSString *remarks;

@end

