//
//  MyCertificationAlertView.h
//  BoYi
//
//  Created by Niklaus on 2018/4/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCertificationAlertView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) void(^onConfirmClick)(NSInteger index);

- (void)showWithArray:(NSArray *)array;

- (void)dismiss;

@end
