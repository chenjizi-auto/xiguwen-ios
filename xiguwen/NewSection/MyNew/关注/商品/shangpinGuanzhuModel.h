//
//  shangpinGuanzhuModel.h
//  BoYi
//
//  Created by heng on 2018/2/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShangpingGuanzhuModel;
@interface shangpinGuanzhuModel : NSObject

@property (nonatomic, strong) NSArray<ShangpingGuanzhuModel *> *shangping;

@end
@interface ShangpingGuanzhuModel : NSObject

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSArray *shopimg;

@property (nonatomic, copy) NSString *shopnamea;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *shopname;

@end

