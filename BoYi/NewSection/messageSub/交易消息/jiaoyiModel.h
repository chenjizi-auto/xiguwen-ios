//
//  jiaoyiModel.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Contjiaoyi;
@interface jiaoyiModel : NSObject

@property (nonatomic, strong) NSArray<Contjiaoyi *> *cont;

@property (nonatomic, assign) NSInteger num;

@end
@interface Contjiaoyi : NSObject

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cont;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger sid;

@property (nonatomic, assign) NSInteger types;

@end

