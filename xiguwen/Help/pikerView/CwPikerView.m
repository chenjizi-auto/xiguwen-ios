//
//  CwPikerView.m
//  ThreeAsk_New
//
//  Created by Yifei Li on 2017/7/5.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import "CwPikerView.h"

@interface CwPikerView () {
    NSInteger _selectIndex;
}


@end

@implementation CwPikerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (CwPikerView *)showInView:(UIView *)view block:(void (^)(NSString *, NSInteger))block {
    
    CwPikerView *alert = [[[NSBundle mainBundle]loadNibNamed:@"CwPikerView" owner:self options:nil]lastObject];
    alert.frame = view.frame;
    alert.block = block;
    alert.dataSource = @[@"婚庆",@"商城"];
    alert.pikerView.delegate = alert;
    alert.pikerView.dataSource = alert;
    [alert showOnView:view];
    return alert;
}


- (IBAction)cancle:(id)sender {
    [self hidden];
}
- (IBAction)sure:(id)sender {
    
    if (self.block) {
        self.block(self.dataSource[_selectIndex], _selectIndex);
    }
    [self hidden];
}
- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1;
        weakSelf.bgView.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}

- (void) hidden{
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgView.alpha = 0.01;
        //        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.pikerView reloadAllComponents];
}

#pragma mark -piker delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.dataSource.count > 0) {
        if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
            return self.dataSource.count;
        }
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (self.dataSource.count > 0) {
        if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
            return [[self.dataSource objectAtIndex:component] count];
        }
    }
    
    return self.dataSource.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (self.dataSource.count > 0) {
        if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
            return [[self.dataSource objectAtIndex:component] objectAtIndex:row];
        }
    }
    return self.dataSource[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectIndex = row;
}

@end
