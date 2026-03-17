//
//  MyDataNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/9.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDataNewModel.h"

@interface MyDataNewTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MyDataNewModel *model;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

// xib

@end
