//
//  ShaiXuanAnlie.h
//  BoYi
//
//  Created by heng on 2018/1/28.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShaiXuanAnlie : UIView<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (copy,nonatomic) void(^ block)(NSMutableDictionary *dic);
@property (strong, nonatomic) NSMutableDictionary *dicData;

+ (ShaiXuanAnlie *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block;

@property (weak, nonatomic) IBOutlet UITextField *zuidi;
@property (weak, nonatomic) IBOutlet UITextField *zuigao;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@end
