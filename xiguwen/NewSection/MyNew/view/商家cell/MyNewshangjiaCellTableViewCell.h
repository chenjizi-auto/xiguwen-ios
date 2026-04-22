//
//  MyNewshangjiaCellTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface MyNewshangjiaCellTableViewCell : UITableViewCell

@property (nonatomic, strong)RACSubject *gotoNextVc;
+ (CGFloat)cellHeight;

@end
