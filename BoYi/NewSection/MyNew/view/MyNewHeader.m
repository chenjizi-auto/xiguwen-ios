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
    self.shangchengImage = @[@"商城订单 全部订单",@"商城订单 待付款",@"商城订单 待发货",@"商城订单 待收货",@"商城订单 待评价"];
    [self.headerimage sd_setImageWithUrl:[UserDataNew sharedManager].userInfoModel.user.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [UserDataNew sharedManager].userInfoModel.user.nickname;
    self.tuanduiName.text = [UserDataNew sharedManager].userInfoModel.user.association;
    self.fensishuliang.text =[NSString stringWithFormat:@"%ld", [UserDataNew sharedManager].userInfoModel.user.fans];
    self.guanzhushuliang.text =[NSString stringWithFormat:@"%ld", [UserDataNew sharedManager].userInfoModel.user.follownumber];
    self.yuE.text = [UserDataNew sharedManager].userInfoModel.user.money;
    self.zhekouQuan.text = [UserDataNew sharedManager].userInfoModel.user.vouchers;
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height;
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

@end
