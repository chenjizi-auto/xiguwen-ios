//
//  ShopNewCarTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/6.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopNewCarModel.h"

@interface ShopNewCarTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) ShopNewCarModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *noData;

@end
