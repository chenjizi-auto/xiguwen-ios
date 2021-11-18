//
//  ShenqingTuiQianViewController.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShenqingTuiQianViewController.h"

@interface ShenqingTuiQianViewController ()

@end

@implementation ShenqingTuiQianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请退款";
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 84;
    }
    self.yuanyin.placeholder = @"请填写退款原因";
    [self addRightBtnWithTitle:@"提交" image:nil];
    [self addPopBackBtn];
    self.xiangtuijinge.text = [NSString stringWithFormat:@"%@",self.model.order_amount];
    self.shijifukuan.text = [NSString stringWithFormat:@"%@",self.model.order_amount];
    [self.goodsImage sd_setImageWithUrl:self.model.baojia_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = self.model.baojia_name;
    self.time.text = self.model.specification;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",self.model.baojia_price];
    self.priceDing.text = [NSString stringWithFormat:@"¥ %@",self.model.order_amount];
    self.number.text = [NSString stringWithFormat:@"x %ld",self.model.quantity];
    if (self.model.paytype == 1) {
        self.isMoneyType.text = @"全款";
    }else if (self.model.paytype == 2) {
        self.isMoneyType.text = @"定金+尾款";
    }else {
        self.isMoneyType.text = @"定金+线下";
    }
    self.yuanyin.delegate = self;
    self.yuanyin.inputAccessoryView = [self addToolbar];
    self.xiangtuijinge.delegate = self;
     self.xiangtuijinge.inputAccessoryView = [self addToolbar];
    
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
    }
    return YES;
    
}
- (void)respondsToRightBtn {
    if ([self.xiangtuijinge.text floatValue] > [self.model.order_amount floatValue]) {
        [NavigateManager showMessage:@"退款金额不能大于实付金额"];
        return;
    }
    if ([self.xiangtuijinge.text floatValue] == 0.00) {
        [NavigateManager showMessage:@"退款金额不为0"];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.model.order_id) forKey:@"orderid"];
    [dic setValue:self.yuanyin.text forKey:@"reason"];
    [dic setValue:self.xiangtuijinge.text forKey:@"price"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/ordershq/tuikuantijiao"]
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"已提交退款申请"];
                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   [self popViewConDelay];
                                                   
                                               });
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"请检查网络"];
                                           
                                       }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
