//
//  ZLActivitiesVoteViewController.h
//  BoYi
//
//  Created by zhaolei on 2018/11/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLActivitiesVoteViewController : UIViewController

///用户主键
@property (nonatomic,strong) NSString *userId;
///用户令牌
@property (nonatomic,strong) NSString *token;

@end

NS_ASSUME_NONNULL_END
