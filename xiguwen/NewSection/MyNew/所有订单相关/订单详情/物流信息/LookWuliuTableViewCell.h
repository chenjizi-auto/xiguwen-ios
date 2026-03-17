//
//  LookWuliuTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lookModel.h"
@interface LookWuliuTableViewCell : UITableViewCell
@property (strong,nonatomic) Traces *model;
@property (weak, nonatomic) IBOutlet UILabel *ri;
@property (weak, nonatomic) IBOutlet UILabel *shi;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
