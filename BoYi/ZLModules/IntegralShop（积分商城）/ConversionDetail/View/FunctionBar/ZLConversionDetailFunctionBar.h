//
//  ZLConversionDetailFunctionBar.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/25.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLConversionDetailFunctionBar : UIView

///标题
@property (nonatomic,strong) NSArray *titles;
///点击事件(index is from 1 start)
@property (nonatomic,copy) void (^clickItem)(NSInteger index);

@end
