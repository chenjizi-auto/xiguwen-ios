//
//  DipuModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DipuModel.h"

@implementation DipuModel

@end
@implementation DipuIficationObjc

@end
@implementation DipuCityModel
- (void)setCity:(NSArray *)city{
    _city = city;
    self.cityModel = [DipuCityModel mj_objectArrayWithKeyValuesArray:city];
}
- (void)setCounty:(NSArray *)county
{
    _county = county;
    self.countyModel =[DipuCityModel mj_objectArrayWithKeyValuesArray:county];
}
@end


