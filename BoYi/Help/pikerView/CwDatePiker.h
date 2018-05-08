//
//  CwDatePiker.h
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/5/16.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CwDatePiker : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePiker;
@property (assign, nonatomic) BOOL  isSele;
@property (copy,nonatomic) void(^ block)(NSDate *date);

+ (CwDatePiker *)showInView:(UIView *)view issele:(BOOL)issele block:(void(^)(NSDate *date))block;

@end
