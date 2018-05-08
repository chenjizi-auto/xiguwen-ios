//
//  KaiTongVIPView.h
//  BoYi
//
//  Created by heng on 2018/1/24.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KaiTongVIPView : UIView
@property (copy,nonatomic) void(^ block)(NSDictionary *dic);
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) NSDictionary *dicData;
+ (KaiTongVIPView *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block;

@end
