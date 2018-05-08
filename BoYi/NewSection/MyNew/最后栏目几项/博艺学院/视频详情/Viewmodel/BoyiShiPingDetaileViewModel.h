//
//  BoyiShiPingDetaileViewModel.h
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoyiShiPinDetailModel.h"
@interface BoyiShiPingDetaileViewModel : NSObject
+(BoyiShiPingDetaileViewModel*)shareManager:(NSString*)video_url objc:(id)objc;
-(void)PlayReleaseSources;
@property(nonatomic,assign)CGRect playerFrame;
-(void)setData:(BoyiShiPinDetailModel*)model;
@end
