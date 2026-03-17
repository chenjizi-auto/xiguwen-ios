//
//  ZLElectronicInvitationCashGiftView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/12.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLElectronicInvitationCashGiftModel.h"

@interface ZLElectronicInvitationCashGiftView : UIView

///弱引用数据
@property (nonatomic,weak) ZLElectronicInvitationCashGiftModel *infoModel;
///加载数据
@property (nonatomic,copy) void (^loadData)(void);

@end
