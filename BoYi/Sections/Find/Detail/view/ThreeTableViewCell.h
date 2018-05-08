//
//  ThreeTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindPJModel.h"


@interface ThreeTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource
,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (strong,nonatomic) NSMutableArray <EsarraypjPJ *> *dataArrayPJ;
@property (weak, nonatomic) IBOutlet UILabel *PJnumber;
@end
