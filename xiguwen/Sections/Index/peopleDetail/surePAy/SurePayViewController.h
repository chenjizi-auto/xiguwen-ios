//
//  SurePayViewController.h
//  BoYi
//
//  Created by apple on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface SurePayViewController : FatherViewController
@property (weak, nonatomic) IBOutlet UILabel *dingjin;
@property (weak, nonatomic) IBOutlet UILabel *quankuan;
@property (weak, nonatomic) IBOutlet UILabel *hejiJine;
@property (weak, nonatomic) IBOutlet UIButton *dingjinBtn;

@property (weak, nonatomic) IBOutlet UIButton *quankuanBtn;

@property (strong, nonatomic)NSMutableDictionary *dic;


@end
