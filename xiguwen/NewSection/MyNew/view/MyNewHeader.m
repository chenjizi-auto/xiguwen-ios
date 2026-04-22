//
//  MyNewHeader.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewHeader.h"

@interface MyNewHeader ()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation MyNewHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hunqinImage = @[@"婚庆订单 全部订单",@"婚庆订单 待付款",@"婚庆订单 待接单",@"婚庆订单 待服务",@"婚庆订单 待评价"];
    self.shangchengImage = @[@"商城订单 全部订单1",@"商城订单 待付款1",@"商城订单 待发货1",@"商城订单 待收货1",@"商城订单 待评价1"];
    [self styleHeaderAppearance];
    [self.headerimage sd_setImageWithUrl:[UserDataNew sharedManager].userInfoModel.user.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [UserDataNew sharedManager].userInfoModel.user.nickname;
    self.tuanduiName.text = [UserDataNew sharedManager].userInfoModel.user.association;
    self.fensishuliang.text =[NSString stringWithFormat:@"%ld", [UserDataNew sharedManager].userInfoModel.user.fans];
    self.guanzhushuliang.text =[NSString stringWithFormat:@"%ld", [UserDataNew sharedManager].userInfoModel.user.follownumber];
    self.yuE.text = [UserDataNew sharedManager].userInfoModel.user.money;
    self.zhekouQuan.text = [UserDataNew sharedManager].userInfoModel.user.vouchers;
    self.topInset.constant = [self currentStatusBarHeight];
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadAction)]];
}
- (void)relodata{
  
    [self.headerimage sd_setImageWithUrl:[UserDataNew sharedManager].userInfoModel.user.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [UserDataNew sharedManager].userInfoModel.user.nickname;
    self.tuanduiName.text = [UserDataNew sharedManager].userInfoModel.user.association;
    self.fensishuliang.text = [NSString stringWithFormat:@"%ld", [UserDataNew sharedManager].userInfoModel.user.fans];
    self.guanzhushuliang.text =[NSString stringWithFormat:@"%ld", [UserDataNew sharedManager].userInfoModel.user.follownumber];
    self.yuE.text = [UserDataNew sharedManager].userInfoModel.user.money;
    self.zhekouQuan.text = [UserDataNew sharedManager].userInfoModel.user.vouchers;
}

- (IBAction)action:(UIButton *)sender {
    
    [self.gotoNextVc sendNext:@(sender.tag)];
}

- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}
- (void)clickHeadAction {
    [self.gotoNextVc sendNext:@(0)];
}

- (CGFloat)currentStatusBarHeight {
    CGFloat statusBarHeight = 0.0;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = UIApplication.sharedApplication.connectedScenes.allObjects.firstObject;
        statusBarHeight = windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
#pragma clang diagnostic pop
    }
    return statusBarHeight;
}

- (void)styleHeaderAppearance {
    self.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    self.headerimage.layer.cornerRadius = 25.0;
    self.headerimage.layer.masksToBounds = YES;
    self.headerimage.layer.borderWidth = 3.0;
    self.headerimage.layer.borderColor = UIColor.whiteColor.CGColor;
    self.headImageView.layer.cornerRadius = 18.0;
    self.headImageView.layer.masksToBounds = NO;
    self.headImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.headImageView.layer.shadowOpacity = 0.06;
    self.headImageView.layer.shadowOffset = CGSizeMake(0.0, 8.0);
    self.headImageView.layer.shadowRadius = 18.0;

    self.name.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightSemibold];
    self.name.textColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.15 alpha:1.0];
    self.tuanduiName.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    self.tuanduiName.textColor = [UIColor colorWithWhite:0.48 alpha:1.0];
    self.hunqinDingLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
    self.shangChengDinglabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];

    UIView *statsContainer = self.fensishuliang.superview.superview;
    [self applyCardStyleToView:statsContainer cornerRadius:18.0];
    [self applyCardStyleToView:self.hunqinDingView cornerRadius:18.0];
    [self applyCardStyleToView:self.shangChengDingView cornerRadius:18.0];
}

- (void)applyCardStyleToView:(UIView *)view cornerRadius:(CGFloat)cornerRadius {
    if (!view) {
        return;
    }
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.05;
    view.layer.shadowOffset = CGSizeMake(0.0, 10.0);
    view.layer.shadowRadius = 18.0;
}

@end
