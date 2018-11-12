//
//  shangpinHeaderView.h
//  BoYi
//
//  Created by heng on 2018/4/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shangpinnewModel.h"
@interface shangpinHeaderView : UIView
@property (strong, nonatomic) shangpinnewModel *model;
@property (nonatomic, strong) RACSubject *selectItemSubject;

@property (weak, nonatomic) IBOutlet UIImageView *bigimage;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yishou;
@property (weak, nonatomic) IBOutlet UILabel *zhifuqingkuang;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIImageView *headerimage;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *haopinlv;
@property (weak, nonatomic) IBOutlet UILabel *quanbushangshu;
@property (weak, nonatomic) IBOutlet UILabel *fensishu;

@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage1;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage2;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage3;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage4;
@end
