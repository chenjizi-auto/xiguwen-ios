//
//  ZLElectronicInvitationGuestsReplyViewController.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationGuestsReplyViewController : UIViewController

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;
///下文主键
@property (nonatomic,strong) NSString *keyId;
///查看客人
@property (nonatomic,unsafe_unretained) BOOL lookGuests;

@end
