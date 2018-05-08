//
//  XuanzheMusicSubVC.h
//  BoYi
//
//  Created by heng on 2017/12/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <WMPageController/WMPageController.h>
#import "MyInvitationCardModel.h"

@interface XuanzheMusicSubVC : WMPageController

@property (nonatomic, strong) MyInvitationCardModel *model;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,  copy) void(^onDidReload)(void);

@end
