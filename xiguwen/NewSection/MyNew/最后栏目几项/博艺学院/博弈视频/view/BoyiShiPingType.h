//
//  BoyiShiPingType.h
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//
typedef void(^MBlock)(UIButton * btn);
typedef void(^SearchBlock)(NSString * text);
#import <UIKit/UIKit.h>
@interface BoyiShiPingType : UIView
-(void)SHIpingTypeNumber:(NSArray*)number;
@property(nonatomic,strong)MBlock Mblock;
@property(nonatomic,strong)SearchBlock searchBlock;
-(void)CanBegcomFouce;
@end
