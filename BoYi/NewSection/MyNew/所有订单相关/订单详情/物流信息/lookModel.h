//
//  lookModel.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Traces;
@interface lookModel : NSObject

@property (nonatomic, strong) NSArray<Traces *> *Traces;

@property (nonatomic, assign) BOOL Success;

@property (nonatomic, copy) NSString *ShipperCode;

@property (nonatomic, copy) NSString *State;

@property (nonatomic, copy) NSString *LogisticCode;

@property (nonatomic, copy) NSString *EBusinessID;

@end
@interface Traces : NSObject

@property (nonatomic, copy) NSString *AcceptStation;

@property (nonatomic, copy) NSString *AcceptTime;

@end

