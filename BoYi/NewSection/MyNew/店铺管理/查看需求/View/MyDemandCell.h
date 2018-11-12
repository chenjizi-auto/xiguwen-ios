//
//  MyDemandCell.h
//  BoYi
//
//  Created by Niklaus on 2018/3/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyXuqiuModel.h"

@interface MyDemandCell : UITableViewCell

/**
 更新视图
 */
- (void)updateViewWithModel:(MyXuqiuModel *)model;

@end
