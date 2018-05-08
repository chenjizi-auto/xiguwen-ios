//
//  MyNewshangjiaCellTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNewshangjiaCellTableViewCell : UITableViewCell

@property (nonatomic, strong)RACSubject *gotoNextVc;

@property (strong, nonatomic) NSArray *hunqinImage;
@property (strong, nonatomic) NSArray *shangchengImage;
@property (weak, nonatomic) IBOutlet UILabel *hunqinDingLabel;
@property (weak, nonatomic) IBOutlet UIView *hunqinDingView;
@property (weak, nonatomic) IBOutlet UILabel *shangChengDinglabel;
@property (weak, nonatomic) IBOutlet UIView *shangChengDingView;

@end
