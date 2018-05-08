//
//  UItextViewWithPlaceHloder.h
//  Sahara
//
//  Created by bodecn on 15/10/28.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UItextViewWithPlaceHloder : UITextView
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat bwidth;
@property (nonatomic, assign)IBInspectable UIColor *bcolor;
/*!
 * @brief 占位符文本,与UITextField的placeholder功能一致
 */
@property (nonatomic, strong) NSString *placeholder;

/*!
 * @brief 占位符文本颜色
 */
@property (nonatomic, strong) UIColor *placeholderTextColor;
@end
