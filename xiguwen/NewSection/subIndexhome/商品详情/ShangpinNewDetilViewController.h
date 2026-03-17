//
//  ShangpinNewDetilViewController.h
//  BoYi
//
//  Created by heng on 2018/2/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface ShangpinNewDetilViewController : FatherViewController
@property (assign,nonatomic)NSInteger shangpinID;

@property (weak, nonatomic) IBOutlet UIImageView *isguanzhu;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
