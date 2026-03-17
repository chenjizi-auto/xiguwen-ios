//
//  CwPikerView.h
//  ThreeAsk_New
//
//  Created by Yifei Li on 2017/7/5.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CwPikerView : UIView <UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIPickerView *pikerView;
@property (strong, nonatomic) NSArray *dataSource;
@property (copy,nonatomic) void(^ block)(NSString *title,NSInteger index);

+ (CwPikerView *)showInView:(UIView *)view block:(void(^)(NSString *title,NSInteger index))block;
@end
