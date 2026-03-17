//
//  ShopCarlistTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/9/1.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarListModel.h"


@interface ShopCarlistTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *header;

@property (weak, nonatomic) IBOutlet UIButton *seleBtn;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *xiangmuName;
@property (weak, nonatomic) IBOutlet UILabel *dingjin;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Label *number;

@property (strong, nonatomic) ShopCarListModel  *model;

@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *addBtn;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *jianBtn;


@end
