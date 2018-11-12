//
//  ZLElectronicInvitationPreviewTemplateView.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationPreviewTemplateView : UIView

///链接地址
@property (nonatomic,strong) NSString *htmlUrl;
///开始制作
@property (nonatomic,copy) void (^startedMaking)(void);
///返回
@property (nonatomic,copy) void (^goBack)(void);

//关闭音乐（进入下个页面时）
- (void)closeMusic;

@end
