//
//  ZLShopDetailsHeaderView.m
//  BoYi
//
//  Created by zhaolei on 2018/5/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ZLShopDetailsHeaderView.h"
#import "ZLShopDetailsContactWayBar.h"
#import "ZLShopDetailsArcBgView.h"
#import "ZLShopDetailsDynamicSuspendBar.h"

@interface ZLShopDetailsHeaderView ()

//头部背景大图
@property (nonatomic,weak) UIImageView *iconImageView;
//弧形白色背景
@property (nonatomic,weak) ZLShopDetailsArcBgView *arcBgView;
//联系方式条
@property (nonatomic,weak) ZLShopDetailsContactWayBar *contactWayBar;

/*------------------------------start--------------------------------------*/
//
//此范围内的两个属性是用来控制functionBarDynamicSuspend函数内的有效判断只进行一次，避免多次调用
//
//悬浮：yes悬浮状态  no没悬浮
@property (nonatomic,unsafe_unretained) BOOL isSuspend;
//滑动：yes支持滑动  no不支持滑动
@property (nonatomic,unsafe_unretained) BOOL isScroll;
/*------------------------------end--------------------------------------*/

//
@property (nonatomic,unsafe_unretained) CGRect iconImageOriginalFrame;

@end

@implementation ZLShopDetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubviews];
    }
    return self;
}

#pragma mark - Add
- (void)addSubviews {
    //头部背景大图
    [self iconImageView];
    //弧形白色背景
    [self arcBgView];
    //联系方式条
    [self contactWayBar];
    //动态悬浮条
    [self dynamicSuspendBar];
}

//单元控件高度
CGFloat const iconImageViewHeight = 204.0;
CGFloat const ZLShopDetailsArcBgViewHeight = 154.0;
CGFloat const ZLShopDetailsContactWayBarHeight = 55.0;
CGFloat const ZLShopDetailsDynamicSuspendBarHeight = 45.0;
#pragma mark - Lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, iconImageViewHeight)];
        iconImageView.image = [UIImage imageNamed:@"婚庆商家背景缺省图"];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:iconImageView];
        _iconImageView = iconImageView;
        self.iconImageOriginalFrame = iconImageView.frame;
    }
    return _iconImageView;
}
- (ZLShopDetailsArcBgView *)arcBgView {
    if (!_arcBgView) {
        CGFloat y =  self.frame.size.height - ZLShopDetailsArcBgViewHeight - ZLShopDetailsContactWayBarHeight - ZLShopDetailsDynamicSuspendBarHeight;
        ZLShopDetailsArcBgView *arcBgView = [[ZLShopDetailsArcBgView alloc] initWithFrame:CGRectMake(0, y, UIScreen.mainScreen.bounds.size.width, ZLShopDetailsArcBgViewHeight)];
        
        //测试
        arcBgView.title = @"标题标题标题标题标题标题标题标题";
        arcBgView.honorsArray = @[@"诚信认证1",@"平台认证1",@"实名认证1",@"平台认证1"];
        arcBgView.position = @"队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员队员";
        arcBgView.gradesArray = @[@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1",@"平台认证1"];
        arcBgView.listArray = @[@"浏览   221",@"浏览   221",@"浏览   221"];
        
        [self addSubview:arcBgView];
        _arcBgView = arcBgView;
    }
    return _arcBgView;
}
- (ZLShopDetailsContactWayBar *)contactWayBar {
    if (!_contactWayBar) {
        ZLShopDetailsContactWayBar *contactWayBar = [[ZLShopDetailsContactWayBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.arcBgView.frame), UIScreen.mainScreen.bounds.size.width, ZLShopDetailsContactWayBarHeight)];
        
        contactWayBar.address = @"成都市高新区云华路西部信息安全产业园";
        contactWayBar.phoneNumber = @"10086";
        
        [self addSubview:contactWayBar];
        _contactWayBar = contactWayBar;
    }
    return _contactWayBar;
}
- (ZLShopDetailsDynamicSuspendBar *)dynamicSuspendBar {
    if (!_dynamicSuspendBar) {
        ZLShopDetailsDynamicSuspendBar *dynamicSuspendBar = [[ZLShopDetailsDynamicSuspendBar alloc] initWithFrame:CGRectMake(0, self.frame.size.height - ZLShopDetailsDynamicSuspendBarHeight, UIScreen.mainScreen.bounds.size.width, ZLShopDetailsDynamicSuspendBarHeight)];
        __weak typeof(dynamicSuspendBar)weakDynamicSuspendBar = dynamicSuspendBar;
        dynamicSuspendBar.itemsClick = ^(NSInteger index) {
            
            
//            //置顶
//            [((UITableView *)weakDynamicSuspendBar.superview) scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
            
            
            
            NSLog(@"---------%@--------",weakDynamicSuspendBar.titlesArray[index]);
        };
        dynamicSuspendBar.titlesArray = @[@"首页",@"报价",@"作品",@"评价",@"动态",@"档期",@"资料"];
        [self addSubview:dynamicSuspendBar];
        _dynamicSuspendBar = dynamicSuspendBar;
    }
    return _dynamicSuspendBar;
}

#pragma mark - Public
- (void)functionBarDynamicSuspend {
    CGRect frame = [self convertRect:self.contactWayBar.frame toView:self.superview.superview];
    CGFloat y = frame.origin.y + CGRectGetHeight(self.contactWayBar.frame);
    if (y < 64) {//使其悬浮
        if (!self.isSuspend) {
            self.isScroll = NO;
            [self.superview.superview addSubview:self.dynamicSuspendBar];
            self.dynamicSuspendBar.frame = CGRectMake(0, 64, self.dynamicSuspendBar.frame.size.width, self.dynamicSuspendBar.frame.size.height);
            self.isSuspend = YES;
        }
    }else {//使其滑动
        if (!self.isScroll) {
            self.isSuspend = NO;
            [self addSubview:self.dynamicSuspendBar];
            self.dynamicSuspendBar.frame = CGRectMake(0, CGRectGetMaxY(self.contactWayBar.frame), self.dynamicSuspendBar.frame.size.width, self.dynamicSuspendBar.frame.size.height);
            self.isScroll = YES;
        }
    }
}
- (void)imageZoomWithOffsetY:(CGFloat)offsetY {
    if (offsetY < 0) {
        //水平缩放比例值
        CGFloat horizontalMagnifyValue = -offsetY / self.iconImageView.frame.size.height * self.iconImageView.frame.size.width;
        //更新frame
        self.iconImageView.frame = CGRectMake(-horizontalMagnifyValue, offsetY, self.iconImageOriginalFrame.size.width + horizontalMagnifyValue * 2, self.iconImageOriginalFrame.size.height + (-offsetY) * 2);
    }
}

@end
