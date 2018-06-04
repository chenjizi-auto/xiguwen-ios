//
//  LookWuliuViewController.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "ShangchengOrderModel.h"

@interface LookWuliuViewController : FatherViewController
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSString *imageurl;

@property (assign, nonatomic) NSInteger id;

///是否是积分商品物流 
@property (nonatomic,unsafe_unretained) BOOL isIntegral;

@end
