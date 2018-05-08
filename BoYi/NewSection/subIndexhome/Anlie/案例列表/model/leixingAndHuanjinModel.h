//
//  leixingAndHuanjinModel.h
//  BoYi
//
//  Created by heng on 2018/1/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Leixingandhuanjin;
@interface leixingAndHuanjinModel : NSObject

@property (nonatomic, strong) NSArray<Leixingandhuanjin *> *leixingAndHuanjin;

@end
@interface Leixingandhuanjin : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL isSelete;

@end

