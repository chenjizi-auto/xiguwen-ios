//
//  MandatoryTips.m
//  BoYi
//
//  Created by itzhaolei on 2021/12/29.
//  Copyright © 2021 hengwu. All rights reserved.
//

#import "MandatoryTips.h"
#import <BmobSDK/Bmob.h>

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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (void)registerTips {
    [Bmob registerWithAppKey:@"fd5f7de4ae84da9b7cee546bce1f6495"];
}

+ (void)show {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Admin"];
    NSArray *array =  @[@{@"Bundle_Identifier":@"com.boyi028.app"}];
    [bquery addTheConstraintByAndOperationWithArray:array];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error || array.count < 1) {
            return;
        }
        BmobObject *obj = array.firstObject;
        BOOL isOn = [[obj objectForKey:@"Offline"] boolValue];
        NSString *message = [obj objectForKey:@"Message"];
        [Mandatory.shared.thisView removeFromSuperview];
        if (!isOn) {
            return;
        }
        MandatoryTips *tips = [[MandatoryTips alloc] initWithFrame:UIScreen.mainScreen.bounds];
        tips.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.75];
        [UIApplication.sharedApplication.windows.firstObject addSubview:tips];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, UIScreen.mainScreen.bounds.size.width - 40, 20)];
        label.numberOfLines = 0;
        label.textColor = UIColor.whiteColor;
        label.text = message;
        [label sizeToFit];
        label.center = tips.center;
        [tips addSubview:label];
        Mandatory.shared.thisView = tips;
    }];
}

@end
