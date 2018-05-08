//
//  SureDingdanNewSCViewController.h
//  BoYi
//
//  Created by heng on 2018/3/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface SureDingdanNewSCViewController : FatherViewController
@property (nonatomic,assign)NSInteger type; //1立即2购物车
@property (nonatomic,strong)NSString *idPingjie;
@property (nonatomic,strong)NSDictionary *dic;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UILabel *xiaoji;
@property (weak, nonatomic) IBOutlet UILabel *zongji;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
////////
@end
