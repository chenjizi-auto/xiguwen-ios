//
//  shangchengNewlistTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TebieTuijianModel.h"

@interface shangchengNewlistTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Guanggaoarray *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *tiele;

@property (weak, nonatomic) IBOutlet UILabel *price;
@end
