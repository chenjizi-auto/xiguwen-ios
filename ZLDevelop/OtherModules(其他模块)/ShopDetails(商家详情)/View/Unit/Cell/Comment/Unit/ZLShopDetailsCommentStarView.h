//
//  ZLShopDetailsCommentStarView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLShopDetailsCommentStarView : UIView

//分数
@property (nonatomic,strong) NSString *score;

///重置星星状态
- (void)resetScoreStar;

@end
