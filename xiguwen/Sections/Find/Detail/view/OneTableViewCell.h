//
//  OneTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindXinXiModel.h"
@interface OneTableViewCell : UITableViewCell


@property (strong,nonatomic) FindXinXiModel *model;

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *piace;

@property (weak, nonatomic) IBOutlet UIButton *lookBtn;


@end
