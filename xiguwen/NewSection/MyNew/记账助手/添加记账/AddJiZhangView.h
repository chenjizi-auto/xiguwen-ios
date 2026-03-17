//
//  AddJiZhangView.h
//  BoYi
//
//  Created by heng on 2018/1/22.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddJiZhangView : UIView <UITextFieldDelegate>

@property (copy,nonatomic) void(^ block)(NSMutableDictionary *dic);
@property (strong, nonatomic) NSMutableDictionary *dicData;
+ (AddJiZhangView *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *ruBtn;
@property (weak, nonatomic) IBOutlet UIButton *chuBtn;
@property (strong, nonatomic) UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UITextField *beizhu;

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (assign,nonatomic) NSInteger time;
@end
