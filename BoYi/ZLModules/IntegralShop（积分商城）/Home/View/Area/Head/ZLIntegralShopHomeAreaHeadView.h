//
//  ZLIntegralShopHomeAreaHeadView.h
//  ZLDebugProject
//
//  Created by zhaolei on 2018/5/18.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralShopHomeAreaHeadView : UIView

///标题
@property (nonatomic,strong) NSString *title;
///子标题
@property (nonatomic,strong) NSString *subTitle;
///查看全部
@property (nonatomic,copy) void (^lookAll)(void);

@end
