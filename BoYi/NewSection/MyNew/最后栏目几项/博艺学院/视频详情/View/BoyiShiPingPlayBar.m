//
//  BoyiShiPingPlayBar.m
//  BoYi
//
//  Created by zhoumeineng on 3/20/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPingPlayBar.h"
#import <objc/runtime.h>
@interface BoyiShiPingPlayBar()
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *playVideoBtn;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end
@implementation BoyiShiPingPlayBar
{
    BOOL iSPASE;
}
// 播放视频
- (IBAction)playAction:(id)sender {
    iSPASE=!iSPASE;
    [((UIButton*)sender) setImage:[UIImage imageNamed:iSPASE?@"暂停视频":@"播放视频"] forState:UIControlStateNormal];
    ((UIButton*)sender).iSPASE = iSPASE?@"播放":@"暂停";
     self.Mblock(playAction, sender);
}
- (IBAction)sliderAction:(id)sender {
     self.Mblock(sliderAction, sender);
}
- (IBAction)PantographAcyion:(id)sender {
    
    self.Mblock(PantographAcyion, sender);
}
- (void)StatusReadyToPlay{
    self.playVideoBtn.userInteractionEnabled = YES;
}
- (void)setSliderVolum:(float)Volum{
    self.slider.value = Volum;
}
- (void)playFinsh{
    iSPASE = NO;
    [self.playVideoBtn setImage:[UIImage imageNamed:@"播放视频"] forState:UIControlStateNormal];
}
- (void)showTimeVolum:(NSString *)time
{
    self.timeLable.text = time;
}
@end

@implementation UIButton (BaceButtonCatory)
@dynamic iSPASE;
- (void)setISPASE:(NSString*)iSPASE{
    objc_setAssociatedObject(self, @"iSPASE", iSPASE, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)iSPASE{
    return objc_getAssociatedObject(self, @"iSPASE");
}
@end
