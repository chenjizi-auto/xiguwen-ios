//
//  HunQinThreeTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/7.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HunQinThreeTableViewCell : UITableViewCell

@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (weak, nonatomic) IBOutlet UIView *fourView;

@property (weak, nonatomic) IBOutlet UIView *fiveView;

@end
