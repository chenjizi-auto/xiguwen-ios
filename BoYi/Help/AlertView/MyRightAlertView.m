//
//  MyRightAlertView.m
//  CardioCycle
//
//  Created by 酷蜂ios on 15/12/21.
//  Copyright © 2015年 酷蜂ios. All rights reserved.
//

#import "MyRightAlertView.h"

@interface MyRightAlertView ()

@property (weak, nonatomic) IBOutlet UIView *bgView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

/**108 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeightLayout;



@end


@implementation MyRightAlertView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content textOver:(BOOL)isover
{
    self = [super initWithFrame:frame];
    if(self){
        self = [[[NSBundle mainBundle]loadNibNamed:@"MyRightAlertView" owner:self options:nil]lastObject];
        if(isover){
            NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
            // 取得 iPhone 支持的所有语言设置
            NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
            // 获得当前iPhone使用的语言
            NSString* currentLanguage = [languages objectAtIndex:0];
            if([currentLanguage containsString:@"en"]||[currentLanguage containsString:@"EN"]){
               self.bgViewHeightLayout.constant = 150;
                
            }else{
               self.bgViewHeightLayout.constant = 138;
            }
        }
        
        self.titleLabel.text = title;
        self.textLabel.text = content;
    }
    return self;
    
}

- (void)showDeviceStateTo:(UIView*)view
{
    if(view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self exChangeOut:self.bgView dur:0.5];
    [view addSubview:self];
//    [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
       
}

- (IBAction)clickRightView
{
    if([self.delegate respondsToSelector:@selector(didClickMyRightAlertView:)]){
        [self.delegate didClickMyRightAlertView:self];
    }
    
    [self removeFromSuperview];
    
}
- (void)hideSelf
{
    [self removeFromSuperview];
    
}

- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.textLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.textLabel.text.length)];
    self.textLabel.attributedText = attributedString;
}

@end
