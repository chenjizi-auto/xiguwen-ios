//
//  ShaiXuanHot.h
//  BoYi
//
//  Created by heng on 2017/12/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShaiXuanHot : UIView<UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (copy,nonatomic) void(^ block)(NSMutableDictionary *dic);
@property (strong, nonatomic) NSMutableDictionary *dicData;

+ (ShaiXuanHot *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block;



@property (weak, nonatomic) IBOutlet UIImageView *i1;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIImageView *i2;
@property (weak, nonatomic) IBOutlet UIButton *btn2;


@property (weak, nonatomic) IBOutlet UIImageView *i3;
@property (weak, nonatomic) IBOutlet UIButton *btn3;


@property (weak, nonatomic) IBOutlet UIImageView *i11;
@property (weak, nonatomic) IBOutlet UIButton *btn11;



@property (weak, nonatomic) IBOutlet UIImageView *i12;
@property (weak, nonatomic) IBOutlet UIButton *btn12;



@property (weak, nonatomic) IBOutlet UIImageView *i111;
@property (weak, nonatomic) IBOutlet UIButton *btn111;


@property (weak, nonatomic) IBOutlet UIImageView *i112;
@property (weak, nonatomic) IBOutlet UIButton *btn112;
@property (weak, nonatomic) IBOutlet UITextField *zuidi;
@property (weak, nonatomic) IBOutlet UITextField *zuigao;
@property (weak, nonatomic) IBOutlet UIView *tagView;


@end
