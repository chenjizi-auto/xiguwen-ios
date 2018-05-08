//
//  NewOneTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "peopleDetailModel.h"

@interface NewOneTableViewCell : UITableViewCell
@property (strong, nonatomic) peopleDetailModel *model;

@property (weak, nonatomic) IBOutlet UILabel *shopWords;
@property (weak, nonatomic) IBOutlet UILabel *fuwuWords;
@property (weak, nonatomic) IBOutlet UIView *markView;

@end
