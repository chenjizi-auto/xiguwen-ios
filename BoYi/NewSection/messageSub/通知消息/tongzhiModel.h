//
//  tongzhiModel.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Conttongzhi;
@interface tongzhiModel : NSObject

@property (nonatomic, strong) NSArray<Conttongzhi *> *cont;

@property (nonatomic, assign) NSInteger num;

@end
@interface Conttongzhi : NSObject

@property (nonatomic, copy) NSString *titlea;

@property (nonatomic, copy) NSString *titleb;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *cont;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *url;

@end

