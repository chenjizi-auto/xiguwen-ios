//
//  ShopWanchengView.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopWanchengView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (copy,nonatomic) void(^ block)(NSMutableDictionary *dic);
+ (ShopWanchengView *)showInView:(UIView *)view orderid:(NSString *)orderid block:(void(^)(NSMutableDictionary *dic))block;

@property (weak, nonatomic) IBOutlet UIButton *shangBtn;
@property (weak, nonatomic) IBOutlet UIButton *xiaBtn;

@property (strong,nonatomic)NSString *isShang;
@property (strong,nonatomic)NSString *orderid;
@end
