//
//  MyGoodsTableViewCell.h
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyGoodsModel.h"

@interface MyGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) MyGoodsModel *model;

/**
 更新视图

 @param model model
 */
- (void)updateViewWithModel:(MyGoodsModel *)model;

@end
