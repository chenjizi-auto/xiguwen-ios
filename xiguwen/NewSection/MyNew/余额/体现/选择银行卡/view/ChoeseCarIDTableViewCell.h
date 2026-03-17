//
//  ChoeseCarIDTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ChoeseCarIDModel.h"
#import "BankCardModel.h"

@interface ChoeseCarIDTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) BankCardModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;


@end
