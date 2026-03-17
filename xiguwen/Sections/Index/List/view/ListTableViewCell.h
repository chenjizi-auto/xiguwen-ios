//
//  ListTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface ListTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Userlist *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *haopinglv;
@property (weak, nonatomic) IBOutlet UILabel *liulanliang;
@property (weak, nonatomic) IBOutlet UILabel *fensishu;



@property (weak, nonatomic) IBOutlet UIImageView *imageRZOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageRZtwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageRZthree;

@property (weak, nonatomic) IBOutlet UIView *starView;
@end
