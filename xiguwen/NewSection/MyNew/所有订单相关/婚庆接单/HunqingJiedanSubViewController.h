//
//  HunqingJiedanSubViewController.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <WMPageController/WMPageController.h>

@interface HunqingJiedanSubViewController : WMPageController
@property (assign,nonatomic) NSInteger statusFlag;

///搜索
@property (nonatomic,strong) NSString *searchString;

@end
