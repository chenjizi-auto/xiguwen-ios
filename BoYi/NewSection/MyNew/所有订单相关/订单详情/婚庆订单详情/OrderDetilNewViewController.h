//
//  OrderDetilNewViewController.h
//  BoYi
//
//  Created by heng on 2018/1/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface OrderDetilNewViewController : FatherViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (assign,nonatomic)NSInteger id;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *leftBtn;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *rightBtn;
@end
