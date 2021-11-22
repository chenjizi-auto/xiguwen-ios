//
//  InstituteAuthCell.h
//  BoYi
//
//  Created by Niklaus on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CertificationDataModel.h"

@interface InstituteAuthCell : UITableViewCell

@property (nonatomic, unsafe_unretained) NSInteger starCount;
@property (nonatomic, strong) UIView *levelView;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, copy) void(^submitClick)(void);// 提交按钮点击事件

/**
 更新视图

 @param model 模型
 */
- (void)updateViewWithModel:(InstituteAuth *)model;

@end
