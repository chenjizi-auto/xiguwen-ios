//
//  BoyiShiPingDetaileViewModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPingDetaileViewModel.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "BoyiShiPinNavigatinBar.h"
#import "BoyiShiPingPlayBar.h"
@interface BoyiShiPingDetaileViewModel()
@property(nonatomic,strong)BoyiShiPingPlayBar * playBar;
@property(nonatomic,strong)BoyiShiPinNavigatinBar * navigationBar;
@property(nonatomic,copy) NSString * video_url;
@property(nonatomic,weak)id object;
@end

@implementation BoyiShiPingDetaileViewModel
{
    AVPlayer *Player;
    AVPlayerLayer *showVodioLayer;
    dispatch_source_t time;
    AVPlayerItem *PlayerItem;
}
+(BoyiShiPingDetaileViewModel*)shareManager:(NSString*)video_url objc:(id)objc{
    BoyiShiPingDetaileViewModel * DetaileViewModel = [[BoyiShiPingDetaileViewModel alloc]init];
    DetaileViewModel.object = objc;
    DetaileViewModel.video_url = video_url;
    [DetaileViewModel interface];
    return DetaileViewModel;
}
-(void)interface{
    PlayerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.video_url]];
    Player = [AVPlayer playerWithPlayerItem:PlayerItem];
    showVodioLayer = [AVPlayerLayer playerLayerWithPlayer:Player];
    showVodioLayer.backgroundColor = [UIColor blackColor].CGColor;
    showVodioLayer.frame = CGRectMake(0, 0, ScreenWidth, 220);
    self.playerFrame = showVodioLayer.frame;
    [((UIViewController*)self.object).view.layer addSublayer:showVodioLayer];
    [PlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PlayFinshAction) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self playBar];
    [self navigationBar];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    AVPlayerItemStatus status = [change[@"new"] integerValue];
    switch (status) {
        case AVPlayerItemStatusUnknown: {
            break;
        }
        case AVPlayerItemStatusReadyToPlay: {
            //表示可以去点击播放按钮
            [self.playBar StatusReadyToPlay];
            [self showTime];
            break;
        }
        case AVPlayerItemStatusFailed: {
            
            break;
        }
    }
    
    
}
-(void)PlayFinshAction{
    [self.playBar playFinsh];
}
-(NSString *)getMMSSFromSS:(NSInteger)totalTime{
    NSInteger seconds =totalTime;
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
}
- (BoyiShiPingPlayBar *)playBar{
    if (!_playBar) {
        _playBar = [[NSBundle mainBundle]loadNibNamed:@"BoyiShiPingPlayBar" owner:self options:nil].firstObject;
        _playBar.frame = CGRectMake(0, CGRectGetMaxY(showVodioLayer.frame)-60, ScreenWidth, 40);
        
        __weak typeof(self) weakSelf = self;
        _playBar.Mblock = ^(NSInteger INDEXT, id action) {
            
            switch (INDEXT) {
                case 1:
                    [((UIButton*)action).iSPASE isEqualToString:@"播放"]?[weakSelf player]:[weakSelf puase];
                    break;
                default:
                    break;
            }
            
        };
        [((UIViewController*)self.object).view addSubview:_playBar];
    }
    return _playBar;
}
- (BoyiShiPinNavigatinBar *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[NSBundle mainBundle]loadNibNamed:@"BoyiShiPinNavigatinBar" owner:self options:nil].firstObject;
        _navigationBar.frame = CGRectMake(0, 0, ScreenWidth, 60);
        __weak typeof(self) weakSelf = self;
        _navigationBar.Mblock = ^(NSInteger INDEXT, id action) {
            switch (INDEXT) {
                case 1:
                    [((UIViewController*)weakSelf.object).navigationController popViewControllerAnimated:YES];
                    break;
                    
                default:
                    break;
            }
            
        };
        [((UIViewController*)self.object).view addSubview:_navigationBar];
    }
    return _navigationBar;
}
- (BOOL)prefersStatusBarHidden{
    return  YES;
}

- (void)player{
    [Player play];
    
    __weak typeof(self)weakSelf = self;
    [self Timer:^{
        [weakSelf showTime];
        [self.playBar setSliderVolum:CMTimeGetSeconds(Player.currentTime)/CMTimeGetSeconds(Player.currentItem.duration)];
    }];
    [self ResumeTimer];
    
}
/**
 * 显示播放的时间
 */
-(void)showTime{
    [self.playBar showTimeVolum:[NSString stringWithFormat:@"%@/%@",[self getMMSSFromSS:CMTimeGetSeconds(Player.currentTime)],[self getMMSSFromSS:CMTimeGetSeconds(Player.currentItem.duration)]]];
}
- (void)puase{
    [Player pause];
    [self StopTimer];
}



/**
 取消计时器
 */
-(void)StopTimer{
    dispatch_source_cancel(time);
}

/**
 开启计时器
 */
-(void)ResumeTimer{
    dispatch_resume(time);
}

-(void)Timer:(void(^)(void))handle{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(time, DISPATCH_TIME_NOW, 0.1*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(time, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            handle();
        });
    });
}
- (void)PlayReleaseSources{
    [Player setRate:0];
    [PlayerItem removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    Player = nil;
}
- (void)setData:(BoyiShiPinDetailModel *)model
{
    [self.navigationBar setData:model];
}
@end
