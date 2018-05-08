//
//  BOyiShiPinMoreViewController.h
//  BoYi
//
//  Created by heng on 2018/1/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
typedef NS_ENUM(NSInteger) {
    MUSIC=2,//音乐
    VIDEO=1//视频
}MUSICORVIDEOTYPE;
@interface BOyiShiPinMoreViewController : FatherViewController
@property(nonatomic,copy)NSString * titletex;
@property(nonatomic,assign)NSInteger type;//视频类别id//也表示音乐类别
@property(nonatomic,assign) MUSICORVIDEOTYPE musicOrVideo;
@end
