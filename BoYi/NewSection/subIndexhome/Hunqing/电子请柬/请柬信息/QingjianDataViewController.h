//
//  QingjianDataViewController.h
//  BoYi
//
//  Created by heng on 2017/12/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "MyInvitationCardModel.h"
#import "InvitationTempModel.h"

@interface QingjianDataViewController : FatherViewController

@property (nonatomic, strong) InvitationTempModel *tempModel;
@property (nonatomic, strong) MyInvitationCardModel *model;
@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic,  copy) void(^onDidReload)(MyInvitationCardModel *model);
@end
