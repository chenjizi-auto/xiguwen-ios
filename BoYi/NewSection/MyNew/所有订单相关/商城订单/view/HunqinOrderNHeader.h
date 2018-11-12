//
//  HunqinOrderNHeader.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/27.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangchengOrderModel.h"
@interface HunqinOrderNHeader : UIView

@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *shangjiaName;
@property (strong,nonatomic) DataShangcheng *model;
@end
