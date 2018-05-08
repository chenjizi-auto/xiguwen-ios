//
//  ShangchengSubViewController.h
//  BoYi
//
//  Created by heng on 2018/2/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <WMPageController/WMPageController.h>

@interface ShangchengSubViewController : WMPageController
@property (assign,nonatomic) NSInteger statusFlag;
@property (assign,nonatomic) NSInteger id;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong,nonatomic)NSMutableArray *arrayid;
@end
