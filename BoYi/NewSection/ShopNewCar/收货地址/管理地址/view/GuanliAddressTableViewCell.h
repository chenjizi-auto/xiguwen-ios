//
//  GuanliAddressTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouHuodizhiModel.h"

@interface GuanliAddressTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Addressarray *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *iphone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *isSeleBtn;
@property (weak, nonatomic) IBOutlet UIButton *bianjiBtm;
@property (weak, nonatomic) IBOutlet UIButton *shanchuBtn;

@end
