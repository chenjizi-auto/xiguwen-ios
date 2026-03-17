//
//  mashuModel.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/22.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class mingxi;
@interface mashuModel : NSObject

@property (nonatomic, strong) NSArray<mingxi *> *array;
@property (nonatomic, assign) BOOL issele;//

@end
@interface mingxi : NSObject

@property (nonatomic, assign) BOOL isSele;//
@property (nonatomic, copy) NSString *id;//
@property (nonatomic, copy) NSString *sku1name;
@property (nonatomic, copy) NSString *sku2name;

@end
