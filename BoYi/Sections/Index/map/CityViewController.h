//
//  CityViewController.h
//  BoYi
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface CityViewController : FatherViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) RACCommand *refreshDataCommand;
@property (weak, nonatomic) IBOutlet UIView *searchview;

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end
