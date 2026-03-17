//
//  CHadangsubViewController.h
//  BoYi
//
//  Created by heng on 2018/2/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <WMPageController/WMPageController.h>
#import "fenLeiModel.h"

@interface CHadangsubViewController : WMPageController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong,nonatomic) NSArray <Fenleiarray *>*fenleiArray;
@end
