//
//  ShangchengOderDetilHeder.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetilModelSC.h"
@interface ShangchengOderDetilHeder : UITableViewHeaderFooterView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (strong, nonatomic) NSString *timeshengyunumber;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong)OrderDetilModelSC *model;
@property (weak, nonatomic) IBOutlet UILabel *titleState;
@property (weak, nonatomic) IBOutlet UILabel *timeShengyu;


@property (weak, nonatomic) IBOutlet UILabel *yonghuName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *iphone;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;


@property (weak, nonatomic) IBOutlet UILabel *shangjianame;

@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *IphoneBtn;


@property (weak, nonatomic) IBOutlet UILabel *zongjia;
@property (weak, nonatomic) IBOutlet UILabel *dikou;


@property (weak, nonatomic) IBOutlet UILabel *yinfuzonge;
@property (weak, nonatomic) IBOutlet UILabel *yinfujine;




@property (weak, nonatomic) IBOutlet UILabel *bianhao;
@property (weak, nonatomic) IBOutlet UILabel *xiadantime;
@property (weak, nonatomic) IBOutlet UILabel *fukuantime;
@property (weak, nonatomic) IBOutlet UILabel *wanchengtime;

@end
