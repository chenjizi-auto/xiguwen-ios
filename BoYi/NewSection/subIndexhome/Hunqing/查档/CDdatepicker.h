//
//  CDdatepicker.h
//  BoYi
//
//  Created by heng on 2017/12/1.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDdatepicker : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePiker;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (assign, nonatomic) BOOL  isSele;
@property (copy,nonatomic) void(^ block)(NSMutableDictionary *dic);

+ (CDdatepicker *)showInView:(UIView *)view issele:(BOOL)issele block:(void(^)(NSMutableDictionary *dic))block;
@end
