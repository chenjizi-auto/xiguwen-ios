//
//  hotoneTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "HotModel.h"
@interface hotoneTableViewCell : UITableViewCell<SDCycleScrollViewDelegate>
@property (strong, nonatomic) SDCycleScrollView *adView;
@property (strong, nonatomic) NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet UIView *vieww;

@property (nonatomic, strong) RACSubject *gotoNextVc;
@end
