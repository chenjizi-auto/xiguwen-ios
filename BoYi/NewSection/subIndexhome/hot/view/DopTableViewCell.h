//
//  DopTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fenLeiModel.h"

@interface DopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *gouxuanImage;
@property (strong,nonatomic) Fenleiarray *model;
@end
