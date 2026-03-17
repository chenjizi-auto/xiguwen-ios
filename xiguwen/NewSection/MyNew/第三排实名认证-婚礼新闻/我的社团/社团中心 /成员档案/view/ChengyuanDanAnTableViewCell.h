//
//  ChengyuanDanAnTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChengyuanDanAnModel.h"

@interface ChengyuanDanAnTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) ChengyuanDanAnModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
