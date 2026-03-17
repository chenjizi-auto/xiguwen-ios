//
//  MyAnLieVCTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/20.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnLieVCModel.h"

@interface MyAnLieVCTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MyAnLieVCModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;

@end
