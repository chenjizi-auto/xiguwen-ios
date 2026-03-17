//
//  CaiPaiDateSele.h
//  BoYi
//
//  Created by heng on 2018/1/19.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaiPaiDateSele : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePiker;
@property (copy,nonatomic) void(^ block)(NSDate *date);

+ (CaiPaiDateSele *)showInView:(UIView *)view  block:(void(^)(NSDate *date))block;
@end
