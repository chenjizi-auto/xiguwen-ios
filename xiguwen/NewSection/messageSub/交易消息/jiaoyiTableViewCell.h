//
//  jiaoyiTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jiaoyiModel.h"
@interface jiaoyiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsimage;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *binahao;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) Contjiaoyi *model;

@end
