//
//  MyTuceModel.h
//  BoYi
//
//  Created by heng on 2018/1/19.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTuceModel : NSObject

// custom code
@property (nonatomic ,assign) NSInteger clicked;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, assign) NSInteger create_ti;
@property (nonatomic, assign) NSInteger examinetime;
@property (nonatomic, assign) NSInteger followed;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger putaway;
@property (nonatomic, strong) NSString *statecontent;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, assign) NSInteger update_ti;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, strong) NSMutableArray *imglist;

@end

