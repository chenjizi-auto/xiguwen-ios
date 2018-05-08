//
//  shetuanChengyuanModel.h
//  BoYi
//
//  Created by heng on 2018/2/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Chuangshiren,Chengyuan;
@interface shetuanChengyuanModel : NSObject

@property (nonatomic, strong) NSArray<Chengyuan *> *chengyuan;

@property (nonatomic, strong) Chuangshiren *chuangshiren;

@end
@interface Chuangshiren : NSObject

@property (nonatomic, copy) NSString *zuidijia;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger usertype;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, copy) NSString *occupation;

@property (nonatomic, copy) NSString *head;

@end

@interface Chengyuan : NSObject

@property (nonatomic, copy) NSString *zuidijia;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger usertype;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger occupationid;

@property (nonatomic, copy) NSString *occupation;

@property (nonatomic, copy) NSString *head;

@end

