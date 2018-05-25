//
//  QingjianHomeViewController.h
//  BoYi
//
//  Created by heng on 2017/12/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "MyInvitationCardModel.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface QingjianHomeViewController : FatherViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *fatherWebView;

@property (nonatomic, strong) MyInvitationCardModel *model;
@property (nonatomic, strong) JSContext *context;  
@end
