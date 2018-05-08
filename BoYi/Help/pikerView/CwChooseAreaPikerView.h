//
//  CwChooseAreaPikerView.h
//  BoYi
//
//  Created by Chen on 2017/8/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CwChooseAreaPikerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIPickerView *pikerView;
@property (strong, nonatomic) NSArray *dataSource;
@property (copy,nonatomic) void(^ block)(NSString *province,NSString *city,NSString *area);

+ (CwChooseAreaPikerView *)showInView:(UIView *)view block:(void(^)(NSString *province,NSString *city,NSString *area))block;

@end
