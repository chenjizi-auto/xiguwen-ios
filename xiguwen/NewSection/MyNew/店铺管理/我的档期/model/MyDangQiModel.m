//
//  MyDangQiModel.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyDangQiModel.h"

@implementation MyDangQiModel

// custom code
//- (void)setA:(NSArray *)a
//{
//    _a = a;
//    self.a = [MyDangQiModel mj_objectArrayWithKeyValuesArray:a];
//}

+ (NSDictionary *)mj_objectClassInArray {
	return @{@"a":[DangQiDetailsModel class]};
}

@end

@implementation DangQiDetailsModel

+ (NSDictionary *)mj_objectClassInArray {
	return @{@"tixing":[RemindDetailsModel class]};
}

@end

@implementation RemindDetailsModel


@end
