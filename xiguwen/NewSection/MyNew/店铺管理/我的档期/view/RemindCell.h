//
//  RemindCell.h
//  BoYi
//
//  Created by Niklaus on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDangQiModel.h"

@interface RemindCell : UITableViewCell

@property (nonatomic, copy) void(^onDidSelected)(void);
@property (nonatomic, strong) UIButton *deleteBtn;

/**
 更新视图

 @param model model
 */
- (void)updateViewWithModel:(RemindDetailsModel *)model;

@end
