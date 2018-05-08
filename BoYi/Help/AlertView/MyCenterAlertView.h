//
//  MyCenterAlertView.h
//  CardioCycle
//
//  Created by bodecn on 16/6/24.
//  Copyright © 2016年 酷蜂ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCenterAlertView : UIView


@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *messageLable;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;




- (id)initWithFrame:(CGRect)frame message:(NSString *)contentTitle left:(NSString *)leftContent;
- (void)showInView:(UIView *)view;
- (IBAction)LeftBtnAction:(UIButton *)sender;

@end
