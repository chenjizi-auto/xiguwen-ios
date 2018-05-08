//
//  AddLiuchengViewController.h
//  BoYi
//
//  Created by heng on 2018/1/22.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "HunliLiuchengModel.h"

@interface AddLiuchengViewController : FatherViewController

@property (nonatomic, strong) LiuChengArray *model;
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UITextField *personnelTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
