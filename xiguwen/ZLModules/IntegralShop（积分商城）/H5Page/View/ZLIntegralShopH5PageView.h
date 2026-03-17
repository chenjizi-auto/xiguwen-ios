//
//  ZLIntegralShopH5PageView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/28.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralShopH5PageView : UIView

///加载数据
@property (nonatomic,copy) void (^loadData)(void);
///资源地址
@property (nonatomic,strong) NSString *srcPath;
///单元格高度
@property (nonatomic,unsafe_unretained) CGFloat cellHeight;

///h5是否可以返回上级
- (BOOL)canGoBack;
///h5返回上级
- (void)goBack;

@end
