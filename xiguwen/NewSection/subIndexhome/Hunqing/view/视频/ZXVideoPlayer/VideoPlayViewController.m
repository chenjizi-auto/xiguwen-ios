//
//  VideoPlayViewController.m
//  ZXVideoPlayer
//
//  Created by Shawn on 16/4/29.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "VideoPlayViewController.h"
#import "ZXVideo.h"
#if __has_include("xiguwen-Swift.h")
#import "xiguwen-Swift.h"
#endif

@interface VideoPlayViewController ()

@property (nonatomic, strong) UIViewController *playerViewController;

@end

@implementation VideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self playVideo];
}

- (void)playVideo
{
#if __has_include("xiguwen-Swift.h")
    if (!self.playerViewController && self.video.playUrl.length > 0) {
        self.playerViewController = [[CwBMPlayerViewController alloc] initWithUrlString:self.video.playUrl
                                                                              titleText:self.video.title];
        [self addChildViewController:self.playerViewController];
        self.playerViewController.view.frame = self.view.bounds;
        self.playerViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.playerViewController.view];
        [self.playerViewController didMoveToParentViewController:self];
    }
#endif
}
- (void)dealloc{
    NSLog(@"干掉");
}
@end
