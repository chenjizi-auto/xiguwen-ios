//
//  HunqinOrderNFooterTwo.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangchengOrderModel.h"
@interface HunqinOrderNFooterTwo : UIView
@property (strong,nonatomic) DataShangcheng *model;

@property (weak, nonatomic) IBOutlet UILabel *gongjiNumber;
@property (weak, nonatomic) IBOutlet UILabel *xiaoji;
@property (weak, nonatomic) IBOutlet UILabel *shifukuan;
@end
