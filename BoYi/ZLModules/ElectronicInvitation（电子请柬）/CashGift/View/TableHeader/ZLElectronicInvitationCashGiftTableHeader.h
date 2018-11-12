//
//  ZLElectronicInvitationCashGiftTableHeader.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/12.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationCashGiftTableHeader : UIView

///金额
@property (nonatomic,weak) UILabel *amountLabel;

///图片缩放
- (void)imageZoomWithOffsetY:(CGFloat)offsetY;

@end
