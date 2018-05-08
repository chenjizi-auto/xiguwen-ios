//
//  MapTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewmapModel.h"

@interface MapTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) NewmapModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *city;

@end
