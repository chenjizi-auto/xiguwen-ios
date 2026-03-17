//
//  HunliXInwenModel.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HunliXInwenModel : NSObject

// custom code
@property (nonatomic, strong) NSString *columnid;
@property (nonatomic, strong) NSString *content; //详情页URL
@property (nonatomic, assign) NSInteger createtime;
@property (nonatomic, strong) NSString *pv;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updatetime;// 更新时间
@property (nonatomic, strong) NSString *img;

@end
