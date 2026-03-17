//
//  RemindShowView.h
//  BoYi
//
//  Created by Niklaus on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDangQiModel.h"
#import "RemindCell.h"

@interface RemindShowView : UIView

@property (nonatomic, copy) void(^onDeleteRemind)(NSMutableArray *array); // 每次数据变更之后将提醒数组传回上层刷新页面

@property (nonatomic, copy) void(^onDidSelected)(NSInteger index);

@property (nonatomic, assign) BOOL isDeleteHidden;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) UITableView *tableView;

/**
 更新视图

 @param array 提醒详情模型
 */
- (void)updateViewWithModel:(NSMutableArray *)array;

@end
