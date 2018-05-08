//
//  BoyiShiPingPlayBar.h
//  BoYi
//
//  Created by zhoumeineng on 3/20/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger) {
    playAction=1,
    sliderAction=2,
    PantographAcyion=3,
}PLAYBAR;
typedef void(^PlayBarBlock)(NSInteger INDEXT,id action);
@interface BoyiShiPingPlayBar : UIView
@property(nonatomic,strong)PlayBarBlock Mblock;
-(void)StatusReadyToPlay;//表示项目预加载完成才能播放

-(void)setSliderVolum:(float)Volum;//slider进度

-(void)showTimeVolum:(NSString*)time;
-(void)playFinsh;
@end

@interface UIButton (BaceButtonCatory)
@property(nonatomic,copy)NSString * iSPASE;//判断是否暂停还是播放
@end
