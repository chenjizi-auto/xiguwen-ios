//
//  ZLElectronicInvitationEditTemplateNeaten.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

//父控件比例值 float_value:将要进行比例变动的值
#define ZL_SCALE(float_value) UIScreen.mainScreen.bounds.size.width / 320.0 * float_value
//单元上的子控件比例值 float_width:动态的单元宽度  float_value:将要进行比例变动的值
#define ZL_SUB_SCALE(float_width,float_value) float_width / 320.0 * float_value

#import "ZLElectronicInvitationEditTemplateNeaten.h"
#import <UIButton+AFNetworking.h>
#import "ZLElectronicInvitationEditTemplateButton.h"
#import "ZLElectronicInvitationEditTemplateTextView.h"

@implementation ZLElectronicInvitationEditTemplateNeaten

#pragma mark - 将json字符串转换为容器，并进行数据整理
+ (void)editTemplateDataWithJsonString:(NSString *)jsonString InfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel {
    if (![jsonString isKindOfClass:[NSString class]]) {
        return;
    }
    if (!jsonString.length) {
        return;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingMutableContainers) error:nil];
    
    dataDict = [self screeningNullWithDictionary:dataDict];
    
    if (![dataDict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if (!dataDict.count) {
        return;
    }
    
    //生产一个可变的对象，供修改内容的时候使用
    NSMutableDictionary *invitationDatasM = [NSMutableDictionary dictionaryWithDictionary:dataDict];
    
    
    
    NSArray *dataArray = dataDict[@"bean"];
    //页数
    if ([dataArray isKindOfClass:[NSArray class]]) {
        if (dataArray.count) {
            CGSize size = UIScreen.mainScreen.bounds.size;
            NSMutableArray *arrayM = [NSMutableArray new];
            NSMutableArray *sectionArrayM = [NSMutableArray new];
            for (NSInteger index = 0; index < dataArray.count; index++) {
                NSDictionary *dict = dataArray[index];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    if (dict.count) {
                        NSMutableDictionary *sectionDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                        //单元控件
                        NSArray *units = dict[@"unitbean"];
                        if ([units isKindOfClass:[NSArray class]]) {
                            NSMutableArray *rowsArrayM = [[NSMutableArray alloc] init];
                            if (units.count) {
                                
                                NSMutableArray *imagesArrayM = [NSMutableArray new];
                                NSMutableArray *bgArrayM = [NSMutableArray new];
                                NSMutableArray *textArrayM = [NSMutableArray new];
                                
                                NSMutableArray *unitArrayM = [NSMutableArray new];
                                //后台宽高值
                                CGFloat width = [dataDict[@"zwidth"] floatValue];
                                CGFloat height = [dataDict[@"zheight"] floatValue];
                                //屏幕的宽高原比例
                                CGFloat originalScale = width / height;
                                //max时单元宽高
                                CGFloat maxUnitWidth = size.width - ZL_SCALE(70.0);
                                CGFloat maxUnitHeight = maxUnitWidth / originalScale;
                                //计算
                                CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
                                CGFloat navHeight = statusBarHeight + 44.0;
                                CGFloat y = navHeight + (size.height - navHeight - 50.0 - ZL_SCALE(12.0) - maxUnitHeight) / 2;
                                infoModel.frame = CGRectMake(0, y, size.width, maxUnitHeight);
                                infoModel.pageSize = CGSizeMake(maxUnitWidth, maxUnitHeight);
                                infoModel.space = ZL_SCALE(8);
                                for (NSInteger value = 0; value < units.count; value++) {
                                    NSDictionary *unitDict = units[value];
                                    [rowsArrayM addObject:[NSMutableDictionary dictionaryWithDictionary:unitDict]];
                                    NSInteger type = [unitDict[@"type"] integerValue];
                                    CGFloat x = [unitDict[@"left"] floatValue];
                                    CGFloat y = [unitDict[@"top"] floatValue];
                                    CGFloat unitWidth = [unitDict[@"width"] floatValue];
                                    CGFloat unitHeight = [unitDict[@"height"] floatValue];
                                    NSString *text = unitDict[@"value"];
                                    if (type == 2) {//文字控件
                                        NSString *color = unitDict[@"color"];
                                        NSString *textAlignStirng = unitDict[@"textAlign"];
                                        NSTextAlignment textAlign = NSTextAlignmentLeft;
                                        if ([textAlignStirng isEqualToString:@"center"]) {
                                            textAlign = NSTextAlignmentCenter;
                                        }else if ([textAlignStirng isEqualToString:@"right"]) {
                                            textAlign = NSTextAlignmentRight;
                                        }
                                        CGFloat topPaddingHeight = 0;
                                        NSString *padding = unitDict[@"padding"];
                                        if (![padding isKindOfClass:[NSNull class]]) {
                                            if ([padding floatValue]) {
                                                topPaddingHeight = ZL_SUB_SCALE(maxUnitWidth, [padding floatValue]);
                                            }
                                        }
                                        ZLElectronicInvitationEditTemplateTextView *textView = [[ZLElectronicInvitationEditTemplateTextView alloc] initWithFrame:CGRectMake(ZL_SUB_SCALE(maxUnitWidth, x), ZL_SUB_SCALE(maxUnitWidth, y), ZL_SUB_SCALE(maxUnitWidth, unitWidth), ZL_SUB_SCALE(maxUnitWidth, unitHeight))];
                                        textView.text = text;
                                        textView.placeholderImageButton.hidden = NO;
                                        textView.textContainer.lineFragmentPadding = 0;
                                        textView.textContainerInset = UIEdgeInsetsMake(topPaddingHeight, 0, 0, 0);
                                        textView.font = [UIFont systemFontOfSize:ZL_SUB_SCALE(maxUnitWidth, [unitDict[@"size"] floatValue])];
                                        textView.backgroundColor = UIColor.clearColor;
                                        if ([color isKindOfClass:[NSString class]]) {
                                            if (color.length) {
                                                textView.textColor = [self colorHexString:color];
                                            }
                                        }
                                        textView.textAlignment = textAlign;
                                        [textArrayM addObject:textView];
                                    }else if (type == 3 || type == 1) {//图片控件
                                        if (type == 1) {//背景图
                                            if ([text isKindOfClass:[NSString class]]) {
                                                if (text.length) {
                                                    NSString *banckgroundImageUrl = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                                                    ZLElectronicInvitationEditTemplateButton *bgSender = [[ZLElectronicInvitationEditTemplateButton alloc] initWithFrame:CGRectMake(0, 0, infoModel.pageSize.width, infoModel.pageSize.height)];
                                                    bgSender.backgroundPage = YES;
                                                    bgSender.tag = bgTag;
                                                    bgSender.userInteractionEnabled = NO;
                                                    [bgSender setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:banckgroundImageUrl] placeholderImage:[UIImage imageNamed:@"加载页"]];
                                                    [bgArrayM addObject:bgSender];
                                                }
                                            }
                                        }else {//图片
                                            ZLElectronicInvitationEditTemplateButton *sender = [[ZLElectronicInvitationEditTemplateButton alloc] initWithFrame:CGRectMake( ZL_SUB_SCALE(maxUnitWidth, x), ZL_SUB_SCALE(maxUnitWidth, y), ZL_SUB_SCALE(maxUnitWidth, unitWidth), ZL_SUB_SCALE(maxUnitWidth, unitHeight))];
                                            sender.placeholderImageButton.hidden = NO;
                                            [sender setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
                                            [imagesArrayM addObject:sender];
                                        }
                                    }
                                }
                                //打上索引
                                CGFloat numberCount = imagesArrayM.count + bgArrayM.count + textArrayM.count;
                                for (NSInteger number = 0; number < numberCount; number++) {
                                    ZLElectronicInvitationEditTemplateButton *sender = nil;
                                    if (number < imagesArrayM.count) {
                                        sender = imagesArrayM[number];
                                    }else if (number < imagesArrayM.count + bgArrayM.count) {
                                        sender = bgArrayM[number - imagesArrayM.count];
                                    }else {
                                        sender = textArrayM[number - imagesArrayM.count - bgArrayM.count];
                                    }
                                    sender.indexPath = [NSIndexPath indexPathForRow:number inSection:index];
                                    [unitArrayM addObject:sender];
                                }
                                [arrayM addObject:unitArrayM];
                                sectionDict[@"unitbean"] = rowsArrayM;
                            }
                        }
                        [sectionArrayM addObject:sectionDict];
                    }
                }
                
            }
            infoModel.units = arrayM;
            invitationDatasM[@"bean"] = sectionArrayM;
        }
    }
    //引用数据
    infoModel.invitationDatas = invitationDatasM;
}

#pragma mark - 色值转颜色
+ (UIColor *)colorHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark - 替换空值
+ (NSMutableDictionary *)screeningNullWithDictionary:(NSDictionary *)dict{
    NSArray *dictArray = dict.allKeys;
    NSInteger count = dictArray.count;
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        NSString *string = dictArray[index];
        NSObject *obj = dict[string];
        if ([obj isKindOfClass:[NSNull class]]) {
            [dictM setObject:@"" forKey:string];
            continue;
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dictM2 = [self screeningNullWithDictionary:(NSDictionary *)obj];
            [dictM setObject:dictM2 forKey:string];
            continue;
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *objArrayM = [self screeningNullWithArray:(NSArray *)obj];
            [dictM setObject:objArrayM forKey:string];
            continue;
        }
        [dictM setObject:obj forKey:string];
    }
    return dictM;
}
+ (NSMutableArray *)screeningNullWithArray:(NSArray *)array{
    NSArray *objArray = (NSArray *)array;
    NSInteger count = objArray.count;
    NSMutableArray *objArrayM = [[NSMutableArray alloc]initWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        NSObject *obj = objArray[index];
        if ([obj isKindOfClass:[NSNull class]]) {
            [objArrayM addObject:@""];
            continue;
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dictM = [self screeningNullWithDictionary:(NSDictionary *)obj];
            [objArrayM addObject:dictM];
            continue;
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *objArrayM2 = [self screeningNullWithArray:(NSArray *)obj];
            [objArrayM addObject:objArrayM2];
            continue;
        }
        [objArrayM addObject:obj];
    }
    return objArrayM;
}

@end
