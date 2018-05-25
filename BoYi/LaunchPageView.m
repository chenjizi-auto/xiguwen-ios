//
//  LaunchPageView.m
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/28.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "LaunchPageView.h"



@interface LaunchPageView() <UIScrollViewDelegate>{
    UIScrollView *_scroll;
    UIPageControl *_pageControll;
}

@end

@implementation LaunchPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





- (instancetype)initWithFrame:(CGRect)frame isAd:(BOOL)isAd
{
    self = [super initWithFrame:frame];
    if (self) {
        if (isAd) {
            [self showAd];
        } else {
            [self setup];
        }
        
    }
    return self;
}
- (void)showAd {
    
    NSString *adViewUrl = URL_welcome;
    [[SDWebImageManager sharedManager].imageCache diskImageExistsWithKey:adViewUrl completion:^(BOOL isInCache) {
        if (isInCache) {
            //如果有，加载
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.frame];
            [imageView sd_setImageWithURL:[NSURL URLWithString:adViewUrl]];
            [self addSubview:imageView];
            [self bringSubviewToFront:imageView];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self hidden];
            });
            
        }
    }];
    
    //没有有，都加载到本地
    [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:adViewUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
    }];
}














- (void)setup {
    
    [self address];
    _scroll = [[UIScrollView alloc] initWithFrame:self.frame];
    _scroll.bounces = NO;
    [self addSubview:_scroll];
    
    
    NSArray *imageArray = @[@"引导页背景1",@"引导页背景2",@"引导页背景3"];
    
    _scroll.contentSize = CGSizeMake(self.size.width * imageArray.count, self.size.height);
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.size.width, 0, self.size.width, self.size.height)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [_scroll addSubview:imageView];
        
        
//        if (i == imageArray.count - 1)
//        {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame        = CGRectMake(i*ScreenWidth+(ScreenWidth-150)/2, ScreenHeight- 60, 150, 60);
//            [button setImage:[UIImage imageNamed:@"but"] forState:UIControlStateNormal];
//            button.layer.masksToBounds = YES;
//            button.layer.cornerRadius   = 3;
//            [button addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
//            //            button.layer.borderColor  = [UIColor blackColor].CGColor;
//            //            button.layer.borderWidth  = 0.5;
//            [_scroll addSubview:button];
//        }
//        else {
//            UIButton *clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth * i + (ScreenWidth - 90), ScreenHeight - 58, 70, 30)];
//            [clickBtn setImage:[UIImage imageNamed:@"跳过"] forState:UIControlStateNormal];
//            [clickBtn addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
//            //            [_scrollview addSubview:clickBtn];
//            [clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            clickBtn.layer.borderColor  = [UIColor blackColor].CGColor;
//            clickBtn.layer.borderWidth  = 0.5;
//        }
        UIButton *clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth * i, ScreenHeight - 100, ScreenWidth, 100)];
//        [clickBtn setImage:[UIImage imageNamed:@"跳过"] forState:UIControlStateNormal];
        clickBtn.backgroundColor = [UIColor clearColor];
        [clickBtn addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        //            [_scrollview addSubview:clickBtn];
//        [clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        clickBtn.backgroundColor = [UIColor redColor];
        [_scroll addSubview:clickBtn];
    }
    
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    
    CGFloat pageWidth = 100;
    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake((self.size.width - pageWidth) / 2, self.size.height - 50, pageWidth, 20)];
    _pageControll.numberOfPages = imageArray.count;
    [self addSubview:_pageControll];
    
    
}

- (void)hidden {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLaunched"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformScale(self.transform, 1.4, 1.4);
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


+ (void)showInView:(UIView *)view isAd:(BOOL)isAd {
    LaunchPageView *launchView = [[LaunchPageView alloc] initWithFrame:[UIScreen mainScreen].bounds isAd:isAd];
    [view addSubview:launchView];
}

- (void)address{
    [[CwLocationManager sharedManager] startWithGeoSearch:YES complete:^(BOOL success, NSString *province, NSString *city) {
        
        if (success) {
            
            [self save:city];
        }
    }];
}
-(void)save:(NSString *)string{
    if ([string isBlankString]){
        return;
    }
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"cityname"] = string;
    [[RequestManager sharedManager] requestUrl:URL_New_citychange
                                        method:POST
                                        loding:nil
                                           dic:dictM
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               [UserData UserDefaults:string key:@"cityName"];
                                               [UserData UserDefaults:response[@"data"][@"id"] key:@"cityCityid"];
                                               [UserDataNew reWriteUserInfo:response[@"data"][@"id"] ForKey:@"cityid"];
                                               
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       }];
}
#pragma mark - scroll代理


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    _pageControll.currentPage = scrollView.contentOffset.x / self.size.width;
}



@end
