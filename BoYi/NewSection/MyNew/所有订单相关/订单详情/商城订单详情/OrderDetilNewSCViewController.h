//
//  OrderDetilNewSCViewController.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface OrderDetilNewSCViewController : FatherViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (assign,nonatomic)NSInteger id;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *leftBtn;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *rightBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dibuHeight;
@end
