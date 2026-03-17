//
//  AddIDThreeTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddIDThreeModel.h"
#import "BankCardModel.h"

@interface AddIDThreeTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) BankCardModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
