//
//  ZLIntegralGoodsSureOrderTableHeader.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/23.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralGoodsSureOrderTableHeader : UIView

///姓名
@property (nonatomic,strong) NSString *name;
///手机号
@property (nonatomic,strong) NSString *phone;
///地址
@property (nonatomic,strong) NSString *address;
///地址高度
@property (nonatomic,unsafe_unretained) CGFloat addressHeight;
///选择地址
@property (nonatomic,copy) void (^clickAddress)(void);

@end
