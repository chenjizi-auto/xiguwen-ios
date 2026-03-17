//
//  FansModel.h
//  BoYi
//
//  Created by heng on 2018/1/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Fansarrayw;
@interface FansModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Fansarrayw *> *fansArray;


@end



@interface Fansarrayw : NSObject

@property (nonatomic, copy) NSString *diqu;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *occupationid;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, copy) NSString *head;

@end

