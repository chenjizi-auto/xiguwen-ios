//
//  ZLKeyboardPayPassword.m
//  BulgeSeekUserPort
//
//  Created by zhaolei on 2018/8/31.
//  Copyright © 2018年 赵磊. All rights reserved.
//

///齐刘海设备
#define ZL_Discern_Bang_Device(isBangDevice) BOOL isBangDevice = NO;if (@available(iOS 11.0, *)) {isBangDevice = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;}

#import "ZLKeyboardPayPassword.h"
#import <CommonCrypto/CommonCrypto.h>

@interface ZLKeyboardPayPassword ()

///遮盖
@property (nonatomic,weak) UIView *hudView;
///单元视图
@property (nonatomic,weak) UIView *unitView;
///数字控件
@property (nonatomic,strong) NSArray *numberLabels;
///数字控件
@property (nonatomic,strong) NSArray *passwordLabels;
///输入结果
@property (nonatomic,strong) NSMutableArray *importResultsM;
///错序按钮
@property (nonatomic,weak) UIButton *unorderlyButton;
///安全防护按钮
@property (nonatomic,weak) UIButton *securityButton;
///确定按钮
@property (nonatomic,weak) UIButton *doneButton;

@end

@implementation ZLKeyboardPayPassword

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
        [self hudView];
    }
    return self;
}

#pragma mark - Lazy
- (NSMutableArray *)importResultsM {
    if (!_importResultsM) {
        _importResultsM = [NSMutableArray new];
    }
    return _importResultsM;
}
- (UIView *)hudView {
    if (!_hudView) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)]];
        view.backgroundColor = UIColor.blackColor;
        view.alpha = 0.5;
        [self addSubview:view];
        _hudView = view;
    }
    return _hudView;
}
- (UIView *)unitView {
    if (!_unitView) {
        ZL_Discern_Bang_Device(isBangDevice);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, 410.0 + (isBangDevice ? 15.0 : 0))];
        view.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 10.0, UIScreen.mainScreen.bounds.size.width - 30.0, 40.0)];
        titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        titleLabel.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
        titleLabel.text = @"验证支付密码：";
        [view addSubview:titleLabel];
        
        NSMutableArray *passwordLabels = [NSMutableArray new];
        CGFloat width = 50.0;
        CGFloat space = (UIScreen.mainScreen.bounds.size.width - width * 6 - 30.0) / 5;
        for (NSInteger index = 0; index < 6; index++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0 + (width + space) * index, 55.0, width, width)];
            label.backgroundColor = UIColor.whiteColor;
            label.layer.cornerRadius = 6.0;
            label.layer.masksToBounds = YES;
            label.layer.borderWidth = 0.5;
            label.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:18.0];
            label.layer.borderColor = [UIColor colorWithRed:248.0 / 255.0 green:248.0 / 255.0 blue:248.0 / 255.0 alpha:1.0].CGColor;
            
            UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(width / 3, width / 3, width / 3, width / 3)];
            pointView.backgroundColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
            pointView.layer.cornerRadius = width / 6;
            pointView.layer.masksToBounds = YES;
            pointView.hidden = YES;
            pointView.tag = 90;
            [label addSubview:pointView];
            
            [view addSubview:label];
            [passwordLabels addObject:label];
        }
        self.passwordLabels = passwordLabels;
        
        NSMutableArray *numberLabels = [NSMutableArray new];
        NSArray *array = @[@"1",@"2",@"3",@"删除",@"4",@"5",@"6",@"0",@"7",@"8",@"9",@"关闭",@"错序",@"安全",@"确  定"];
        width =  (UIScreen.mainScreen.bounds.size.width - 60.0) / 4;
        for (NSInteger index = 0; index < 15; index++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15.0 + (width + 10.0) * (index % 4), 145.0 + 65.0 * (index / 4), index == 14 ? width * 2 + 10.0 : width, 55.0)];
            button.backgroundColor = UIColor.whiteColor;
            button.layer.cornerRadius = 6.0;
            button.layer.masksToBounds = YES;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor colorWithRed:248.0 / 255.0 green:248.0 / 255.0 blue:248.0 / 255.0 alpha:1.0].CGColor;
            if (index == 3) {
                [button setImage:[UIImage imageNamed:@"清除"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
            }else if (index == 11) {
                [button setImage:[UIImage imageNamed:@"键盘"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
            }else if (index == 12) {
                [button setImage:[UIImage imageNamed:@"错序 未选中"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"错序 选中(1)"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(unorderlyAction:) forControlEvents:UIControlEventTouchUpInside];
            }else if (index == 13) {
                [button setImage:[UIImage imageNamed:@"安全"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"安全选中"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(securityAction:) forControlEvents:UIControlEventTouchUpInside];
                self.securityButton = button;
                [self securityAction:self.securityButton];
            }else if (index == 14) {
                [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
                [button setTitle:array[index] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
                button.enabled = NO;
                button.backgroundColor = UIColor.lightGrayColor;
                self.doneButton = button;
            }else {
                [button setTitle:array[index] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
                [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [button addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
                if (index == 7) {
                    [numberLabels insertObject:button atIndex:0];
                }else {
                    [numberLabels addObject:button];
                }
            }
            
            [view addSubview:button];
            
            self.numberLabels = numberLabels;
        }
        
        [self addSubview:view];
        _unitView = view;
    }
    return _unitView;
}

#pragma mark - Action
- (void)itemAction:(UIButton *)sender {
    if (self.importResultsM.count < 6) {
        [self.importResultsM addObject:sender.titleLabel.text];
        NSInteger index = self.importResultsM.count - 1;
        UILabel *label = self.passwordLabels[index];
        if (!self.securityButton.selected) {
            label.text = self.importResultsM[index];
            [label viewWithTag:90].hidden = YES;
        }else {
            label.text = nil;
            [label viewWithTag:90].hidden = NO;
        }
        sender.backgroundColor = [UIColor colorWithRed:200.0 / 255.0 green:200.0 / 255.0 blue:205.0 / 255.0 alpha:1.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            sender.backgroundColor = UIColor.whiteColor;
        });
        if (self.importResultsM.count == 6) {
            self.doneButton.enabled = YES;
            self.doneButton.backgroundColor = [UIColor colorWithRed:0 green:122/ 255.0 blue:1.0 alpha:1.0];
        }
    }
}
- (void)unorderlyAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSArray *titles = nil;
    if (sender.selected) {
        titles = [@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"] sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
            int seed = arc4random_uniform(2);
            if (seed) {
                return [str1 compare:str2];
            } else {
                return [str2 compare:str1];
            }
        }];
    }
    for (NSInteger index = 0; index < self.numberLabels.count; index++) {
        UIButton *button = self.numberLabels[index];
        if (sender.selected) {
            [button setTitle:titles[index] forState:UIControlStateNormal];
        }else {
            [button setTitle:[NSString stringWithFormat:@"%ld",index] forState:UIControlStateNormal];
        }
    }
}
- (void)securityAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.importResultsM.count) {
        for (NSInteger index = 0; index < self.importResultsM.count; index++) {
            UILabel *label = self.passwordLabels[index];
            if (!self.securityButton.selected) {
                label.text = self.importResultsM[index];
                [label viewWithTag:90].hidden = YES;
            }else {
                label.text = nil;
                [label viewWithTag:90].hidden = NO;
            }
        }
    }
}
- (void)deleteAction:(UIButton *)sender {
    
    if (self.importResultsM.count) {
        NSInteger index = self.importResultsM.count - 1;
        [self.importResultsM removeObjectAtIndex:index];
        
        UILabel *label = self.passwordLabels[index];
        if (!self.securityButton.selected) {
            label.text = nil;
        }else {
            [label viewWithTag:90].hidden = YES;
        }
        self.doneButton.enabled = NO;
        self.doneButton.backgroundColor = UIColor.lightGrayColor;
    }
    sender.backgroundColor = [UIColor colorWithRed:200.0 / 255.0 green:200.0 / 255.0 blue:205.0 / 255.0 alpha:1.0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.backgroundColor = UIColor.whiteColor;
    });
}
- (void)closeAction {
    [UIView animateWithDuration:0.25 animations:^{
        self.unitView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, self.unitView.frame.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
- (void)doneAction {
    if (self.results) {
        NSString *results = [self.importResultsM componentsJoinedByString:@""];
        self.results([self MD5:results]);
        [self close];
    }
}

#pragma mark - Private
- (NSString *)MD5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

#pragma mark - Public
- (void)show {
    [self clearPayPassword];
    self.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.unitView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - self.unitView.frame.size.height, UIScreen.mainScreen.bounds.size.width, self.unitView.frame.size.height);
    }];
}
- (void)close {
    [self closeAction];
}
- (void)clearPayPassword {
    self.importResultsM = nil;
    self.doneButton.enabled = NO;
    self.doneButton.backgroundColor = UIColor.lightGrayColor;
    self.unorderlyButton.selected = NO;
    for (NSInteger index = 0; index < self.passwordLabels.count; index++) {
        UILabel *label = self.passwordLabels[index];
        [label viewWithTag:90].hidden = YES;
        label.text = nil;
    }
}

@end
