//
//  NSString+Utils.m
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

//汉字、英语的拼音
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    
    
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    /*多音字处理*/
    if ([self isEqualToString:@"都"]) {
        return @"du";
    }
    if ([self isEqualToString:@"成都"]) {
        return @"chengdu";
    }
    if ([self isEqualToString:@"成都市"]) {
        return @"chengdushi";
    }
    return [[str stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
}



@end
