//
//  XianjingDikouTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XianjingDikouModel.h"

@interface XianjingDikouTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) XianjingDikouModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
