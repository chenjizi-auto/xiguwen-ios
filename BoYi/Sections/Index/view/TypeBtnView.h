//
//  TypeBtnView.h
//  BoYi
//
//  Created by apple on 2017/8/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeBtnView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherConstrint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewConstrint;
@property (weak, nonatomic) IBOutlet UIPageControl *page;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) RACSubject *gotoNextVc;
@end

