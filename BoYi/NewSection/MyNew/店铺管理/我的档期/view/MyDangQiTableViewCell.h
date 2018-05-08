//
//  MyDangQiTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/18.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDangQiModel.h"

@interface MyDangQiTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) DangQiDetailsModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *remindBtn;
@property (weak, nonatomic) IBOutlet UIButton *systemBtn;

@end
