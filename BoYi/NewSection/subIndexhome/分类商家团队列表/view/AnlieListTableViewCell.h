//
//  AnlieListTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/18.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnlieListModel.h"

@interface AnlieListTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Shangjiatuanduilist *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *header;



@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *isHuiyuan;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage1;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage2;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage3;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage4;

@property (weak, nonatomic) IBOutlet UILabel *haopinlv;
@property (weak, nonatomic) IBOutlet UILabel *pinlunshu;
@property (weak, nonatomic) IBOutlet UILabel *fensishu;

@end
