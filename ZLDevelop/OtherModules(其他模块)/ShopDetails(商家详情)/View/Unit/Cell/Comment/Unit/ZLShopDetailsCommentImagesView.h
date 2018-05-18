//
//  ZLShopDetailsCommentImagesView.h
//  BoYi
//
//  Created by zhaolei on 2018/5/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLShopDetailsCommentImagesView : UIView

///设置图片
- (void)setImagesWithArray:(NSArray *)array MaxY:(CGFloat)maxY;
///重置
- (void)resetWithMaxY:(CGFloat)maxY;

@end
