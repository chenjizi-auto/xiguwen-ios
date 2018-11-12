//
//  HunqinOrderNFooter.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangchengOrderModel.h"
@interface HunqinOrderNFooter : UITableViewHeaderFooterView

@property (strong,nonatomic) DataShangcheng *model;

@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *rightBtn;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *leftBtn;



@property (weak, nonatomic) IBOutlet UILabel *gongjiNumber;
@property (weak, nonatomic) IBOutlet UILabel *xiaoji;
@property (weak, nonatomic) IBOutlet UILabel *shifukuan;
@property (weak, nonatomic) IBOutlet UILabel *shengyuTime;
@property (weak, nonatomic) IBOutlet UILabel *timeTitle;


@end
