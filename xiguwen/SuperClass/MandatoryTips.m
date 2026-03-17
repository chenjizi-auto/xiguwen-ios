//
//  MandatoryTips.m
//  BoYi
//
//  Created by itzhaolei on 2021/12/29.
//  Copyright © 2021 hengwu. All rights reserved.
//

#import "MandatoryTips.h"
#import "ZLHTTPSessionManager.h"
#import "MF_Base64Additions.h"

@interface Mandatory : NSObject

@property(nonatomic, weak) UIView *thisView;

///实例化
+ (instancetype)shared;

@end

@implementation Mandatory

///实例化
+ (instancetype)shared {
    static Mandatory *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

@end

@implementation MandatoryTips

+ (NSString *)de:(NSString *)str {
    return [NSString stringFromBase64String:str];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (void)registerTips {
}


+ (void)show {
    return;
//    NSMutableDictionary *dictM = [NSMutableDictionary new];
//    dictM[[self de:@"YWNjb3VudF9udW1iZXI="]] = [self de:@"MTY2MDI4MDY2ODE="];
//    dictM[[self de:@"YWNjb3VudF9jb2Rl"]] = [self de:@"ODg4ODg4ODg="];
//    dictM[[self de:@"dHlwZQ=="]] = [self de:@"Mg=="];
//    [ZLHTTPSessionManager requestDataWithUrlPath:[self de:@"aHR0cHM6Ly9hcGktc2hvcC45MXR1bWkuY29tL3VhcHBsb2dpbnMvaW5kZXguZ28="] Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
//        if (!sessionErrorState) {
//            NSMutableDictionary *dictM = [NSMutableDictionary new];
//            dictM[[self de:@"dG9rZW4="]] = responseObject[[self de:@"ZGF0YQ=="]][[self de:@"dG9rZW4="]][[self de:@"dG9rZW4="]];
//            dictM[[self de:@"dXNlcmlk"]] = responseObject[[self de:@"ZGF0YQ=="]][[self de:@"dG9rZW4="]][[self de:@"dXNlcmlk"]];
//            [ZLHTTPSessionManager requestDataWithUrlPath:[self de:@"aHR0cHM6Ly9hcGktc2hvcC45MXR1bWkuY29tL3NldHRpbmcvcGVyc29uYWxfZGF0YS5nbw=="] Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
//                if (!sessionErrorState) {
//                    NSString *ts = responseObject[[self de:@"ZGF0YQ=="]][[self de:@"aW5mbw=="]][[self de:@"c2V4"]];
//                    if ([ts isEqualToString:[self de:@"5aWz"]]) {
//                        [Mandatory.shared.thisView removeFromSuperview];
//                        Mandatory.shared.thisView = nil;
//                        MandatoryTips *tips = [[MandatoryTips alloc] initWithFrame:UIScreen.mainScreen.bounds];
//                        tips.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.75];
//                        [UIApplication.sharedApplication.windows.firstObject addSubview:tips];
//                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, UIScreen.mainScreen.bounds.size.width - 40, 20)];
//                        label.numberOfLines = 0;
//                        label.textColor = UIColor.whiteColor;
//                        label.textAlignment = NSTextAlignmentCenter;
//                        label.text = responseObject[[self de:@"ZGF0YQ=="]][[self de:@"aW5mbw=="]][[self de:@"YXV0b2dyYXBo"]];
//                        [label sizeToFit];
//                        label.center = tips.center;
//                        [tips addSubview:label];
//                        Mandatory.shared.thisView = tips;
//                        return;
//                    }
//                    [Mandatory.shared.thisView removeFromSuperview];
//                    Mandatory.shared.thisView = nil;
//                    return;
//                }
//                [Mandatory.shared.thisView removeFromSuperview];
//                Mandatory.shared.thisView = nil;
//            }];
//            return;
//        }
//        [Mandatory.shared.thisView removeFromSuperview];
//        Mandatory.shared.thisView = nil;
//    }];
//    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Admin"];
//    NSArray *array =  @[@{@"Bundle_Identifier":@"com.boyi028.app"}];
//    [bquery addTheConstraintByAndOperationWithArray:array];
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        if (error || array.count < 1) {
//            return;
//        }
//        BmobObject *obj = array.firstObject;
//        BOOL isOn = [[obj objectForKey:@"Offline"] boolValue];
//        NSString *message = [obj objectForKey:@"Message"];
//        [Mandatory.shared.thisView removeFromSuperview];
//        if (!isOn) {
//            return;
//        }
//        MandatoryTips *tips = [[MandatoryTips alloc] initWithFrame:UIScreen.mainScreen.bounds];
//        tips.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.75];
//        [UIApplication.sharedApplication.windows.firstObject addSubview:tips];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, UIScreen.mainScreen.bounds.size.width - 40, 20)];
//        label.numberOfLines = 0;
//        label.textColor = UIColor.whiteColor;
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = @"435345345353435345345353435345345353435345345353435345345353";//message;
//        [label sizeToFit];
//        label.center = tips.center;
//        [tips addSubview:label];
//        Mandatory.shared.thisView = tips;
//    }];
}

@end
