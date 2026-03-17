//
//  GetMoneyListModel.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/29.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMoneyListModel : NSObject

// custom code

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger cardid;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *updatetime;

@property (nonatomic, copy) NSString *creater;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *updater;

@end
