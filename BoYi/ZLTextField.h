//
//  ZLTextField.h
//  BasisProject
//
//  Created by zhaolei on 2019/1/1.
//  Copyright © 2019 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLTextField : UITextField

///确定按钮
@property (nonatomic,weak,readonly) UIButton *doneButton;
///确定
@property (nonatomic,copy) void (^done)(NSString *text);

@end

NS_ASSUME_NONNULL_END
