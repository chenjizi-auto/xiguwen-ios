//
//  GuanzhuShangjiaTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/11.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuanzhuShangjiaModel.h"

@interface GuanzhuShangjiaTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) ShangjiaGuanzhuModel *model;

// xib
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
