//
//  ZhiZuoViewController.h
//  BoYi
//
//  Created by heng on 2017/12/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "InvitationTempModel.h"
#import <WebKit/WebKit.h>
@interface ZhiZuoViewController : FatherViewController <WKNavigationDelegate>

@property (nonatomic, strong) InvitationTempModel *tempModel;

@end
