//
//  BaojiaDetilTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/23.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaojiaDetilModel.h"

@interface BaojiaDetilTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) BaojiaDetilModel *model;

// xib

@property (weak, nonatomic) IBOutlet UIImageView *fengmianImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yishou;
@property (weak, nonatomic) IBOutlet UILabel *dingjianxiangqing;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiqwei;



@property (weak, nonatomic) IBOutlet UILabel *pinglunshuliang;
@property (weak, nonatomic) IBOutlet UILabel *fensishuliang;
@property (weak, nonatomic) IBOutlet UILabel *haopinshuliang;

@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage1;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage2;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage3;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage4;
@property (weak, nonatomic) IBOutlet UIButton *lookbtn;

@end
