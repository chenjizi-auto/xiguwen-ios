//
//  SixTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTalkTableViewCell.h"
#import "EvaluationManagementModel.h"
@interface SixTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tablePL;
@property (strong,nonatomic) NSMutableArray *dataArray;
@end
