//
//  OrderDetailViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/9/4.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *why;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"订单详情";
    [self addPopBackBtn];
    
    
    @weakify(self);
    
    [[[RequestManager sharedManager] RACRequestUrl:URL_getRefund
                                           method:POST
                                           loding:@"加载中..."
                                              dic:@{@"orderId":@(self.orderId)}] subscribeNext:^(id  _Nullable x) {
     
        @strongify(self);
        OrderDetailModel *model = [OrderDetailModel mj_objectWithKeyValues:x];
        self.shopName.text = model.bizName;
        self.money.text = [NSString stringWithFormat:@"￥%@",@(model.price)];
        self.why.text = model.refund;
        switch (model.status) {
            case 4:
                self.status.text = @"退款中";
                break;
            case 7:
                self.status.text = @"退款完成";
                break;
            case 8:
                self.status.text = @"拒绝退款";
                break;
            default:
                break;
        }
    }];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}


@end
@implementation OrderDetailModel



@end
