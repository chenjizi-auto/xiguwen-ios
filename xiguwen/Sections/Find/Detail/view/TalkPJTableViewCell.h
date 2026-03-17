//
//  TalkPJTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindPJModel.h"
#import "HCSStarRatingView.h"
@interface TalkPJTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (strong,nonatomic) EsarraypjPJ  *model;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *star;
@property (weak, nonatomic) IBOutlet UILabel *fenshu;
@end
