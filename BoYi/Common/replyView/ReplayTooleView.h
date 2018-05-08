//
//  ReplayTooleView.h
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/5/8.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UItextViewWithPlaceHloder.h"

@interface ReplayTooleView : UIView

@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *textView;

@property (strong, nonatomic) RACSubject *HeightChangeSubject;
@property (strong, nonatomic) RACSubject *sendSubject;


@end
