//
//  ZLShareFaYanGaoView.h
//  BoYi
//
//  Created by zhaolei on 2018/6/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLShareFaYanGaoView : UIView

///图片地址
@property (nonatomic,strong) NSString *imageUrl;
///标题
@property (nonatomic,strong) NSString *titleString;
///内容
@property (nonatomic,strong) NSString *content;

///消失
@property (nonatomic,copy) void (^dismissPage)(void);
///分享
@property (nonatomic,copy) void (^share)(NSInteger index);

///错误日志
@property (nonatomic,strong) NSString *errorMessage;
///展示遮盖
@property (nonatomic,unsafe_unretained) BOOL showHud;

///展示
- (void)show;
///消失
- (void)dismiss;


@end
