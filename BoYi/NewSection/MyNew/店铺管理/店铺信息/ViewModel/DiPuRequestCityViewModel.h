//
//  DiPuRequestCityViewModel.h
//  BoYi
//
//  Created by zhoumeineng on 3/24/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiPuRequestCityViewModel : NSObject
/**
 * 获取数据
 */
@property(nonatomic,strong)RACCommand *DataCommand;


@property (nonatomic, strong) RACSubject *Subject;
@end
