//
//  ShetuanLinxiModel.h
//  BoYi
//
//  Created by heng on 2018/2/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChuangshirenLianxi,ChengyuanLianxi;
@interface ShetuanLinxiModel : NSObject

@property (nonatomic, strong) NSArray<ChengyuanLianxi *> *chengyuan;

@property (nonatomic, strong) ChuangshirenLianxi *chuangshiren;



@end



@interface ChuangshirenLianxi : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *mobile;

@end

@interface ChengyuanLianxi : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *mobile;

@end

