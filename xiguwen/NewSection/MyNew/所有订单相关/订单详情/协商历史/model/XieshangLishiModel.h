//
//  XieshangLishiModel.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Xieshangarray;
@interface XieshangLishiModel : NSObject

// custom code

@property (nonatomic, strong) NSArray<Xieshangarray *> *xieshangArray;

@end
@interface Xieshangarray : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *times;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *head;



@end

