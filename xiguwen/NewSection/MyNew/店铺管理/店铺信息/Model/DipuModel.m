//
//  DipuModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DipuModel.h"

@implementation DipuModel

- (void)setShopimg:(NSArray<NSString *> *)shopimg {
    if ([shopimg isKindOfClass:[NSArray class]]) {
        NSMutableArray<NSString *> *items = [NSMutableArray array];
        for (id value in shopimg) {
            NSString *string = [NSString stringWithFormat:@"%@", value];
            if (string.length == 0 || [string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"]) {
                continue;
            }
            [items addObject:string];
        }
        _shopimg = [items copy];
        return;
    }
    if ([shopimg isKindOfClass:[NSString class]]) {
        NSString *rawString = (NSString *)shopimg;
        if (rawString.length == 0) {
            _shopimg = @[];
            return;
        }
        NSArray<NSString *> *components = [rawString componentsSeparatedByString:@","];
        NSMutableArray<NSString *> *items = [NSMutableArray array];
        for (NSString *component in components) {
            NSString *trimmed = [component stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (trimmed.length == 0 || [trimmed isEqualToString:@"(null)"] || [trimmed isEqualToString:@"<null>"]) {
                continue;
            }
            [items addObject:trimmed];
        }
        _shopimg = [items copy];
        return;
    }
    _shopimg = @[];
}

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

