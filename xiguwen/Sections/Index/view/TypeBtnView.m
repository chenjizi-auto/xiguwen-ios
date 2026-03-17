//
//  TypeBtnView.m
//  BoYi
//
//  Created by apple on 2017/8/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "TypeBtnView.h"

@interface TypeBtnView () <UIScrollViewDelegate>


@end

@implementation TypeBtnView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.fatherConstrint.constant = 2 * ScreenWidth;
    self.viewConstrint.constant = ScreenWidth;
    self.page.numberOfPages = 2;
    self.scroll.delegate = self;
    self.scroll.showsVerticalScrollIndicator = FALSE;
    self.scroll.showsHorizontalScrollIndicator = FALSE;
    self.scroll.pagingEnabled = YES;
    
    for (int i  = 0; i < 16; i++) {
        
        UIView *btnSubView = [self viewWithTag:100 + i];
        UIButton *btn = (UIButton *)[btnSubView viewWithTag:200];
        @weakify(self);
        //点击
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            
            [self.gotoNextVc sendNext:@(i)];
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        self.page.currentPage = 0;
    }
    if (scrollView.contentOffset.x == ScreenWidth) {
        self.page.currentPage = 1;
    }
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}
@end
