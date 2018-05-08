//
//  XuanZeMusicTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/31.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface XuanZeMusicTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MusicModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *gouImage;
@property (weak, nonatomic) IBOutlet UIImageView *isHOt;

@end
