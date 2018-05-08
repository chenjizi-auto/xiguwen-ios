//
//  FansTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansModel.h"

@interface FansTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Fansarrayw *model;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;

// xib

@end
