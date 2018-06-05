//
//  ShangchengOderDetilJDViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengOderDetilJDViewController.h"
#import "ShangchengOderDetilTwoTableViewCell.h"
#import "OrderDetilModelSC.h"
#import "SCchangeJIageViewController.h"
#import "WritewuliuViewController.h"
#import "LookWuliuViewController.h"
#import "SCtuikuanDetilViewController.h"
#import "shangchengOderThreeTableViewCell.h"

@interface ShangchengOderDetilJDViewController ()

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ShangchengOderDetilJDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [kCountDownManager start];
    [self addPopBackBtn];
    [self.table registerNib:[UINib nibWithNibName:@"ShangchengOderDetilTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShangchengOderDetilTwoTableViewCell"];
    self.table.delegate             = self;
    self.table.dataSource           = self;
    [self getdata];

}
- (IBAction)all:(IB_DESIGN_Button *)sender {
    if (sender.tag == 0) {
        
    }else {//right
        //订单状态 10：待支付 20：已取消 60：已支付 70：已发货 ：80：已收货待评价 90 已评价
         DataSCDetil *model = self.model.data;
        if (model.status == 10) {
            
            SCchangeJIageViewController *shou = [[SCchangeJIageViewController alloc] init];
            shou.id = model.order_id;
            
            DataShangcheng *model = [[DataShangcheng alloc] init];
            
            Goodsshangcheng *goodsmodel = [[Goodsshangcheng alloc] init];
            goodsmodel.goods_image = self.model.data.goods[0].goods_image;
            goodsmodel.goods_name = self.model.data.goods[0].goods_name;
            goodsmodel.specification = self.model.data.goods[0].specification;
            goodsmodel.price = self.model.data.goods[0].price;
            goodsmodel.quantity = self.model.data.goods[0].quantity;
            goodsmodel.goods_image = self.model.data.goods[0].goods_image;
            
            model.goods = @[goodsmodel];
            model.order_id = self.model.data.order_id;
            shou.model = model;
            [self pushToNextVCWithNextVC:shou];
        }else if (model.status == 20) {//取消
            //无
        }else if (model.status == 60) {//已支付
            //发货
            WritewuliuViewController *Write = [[WritewuliuViewController alloc] init];
            Write.id = model.order_id;
            [self pushToNextVCWithNextVC:Write];
        }else if (model.status == 70 || model.status == 80 || model.status == 90) {//已发货
            LookWuliuViewController *look = [[LookWuliuViewController alloc] init];
            look.id = model.order_id;
            if (model.goods.count > 0) {
                look.imageurl = model.goods[0].goods_image;
            }
            [self pushToNextVCWithNextVC:look];
            
        }else if (model.status == 100) {
            //
     
        }
    }
}

- (IBAction)boac:(UIButton *)sender {
    if (sender.tag == 0) {
        //im
        NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.data.user_id] type:NIMSessionTypeP2P];
        NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.model.data.user_mobile];
        CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (version >= 10.0) {
            /// 大于等于10.0系统使用此openURL方法
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }
}


- (void)handleTimer {
    if (self.model.data.fukuantime == 0) {
        [self.timer invalidate];
        [self getdata];
        
    } else {
        NSInteger  countDown = self.model.data.fukuantime;
        
        self.timeshengyunumber = [NSString stringWithFormat:@"还剩余%02zd小时%02zd分%02zd秒", countDown/3600, (countDown/60)%60, countDown%60];
        
    }
    self.model.data.fukuantime --;
}
- (void)getdata{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.id) forKey:@"id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/orders/getorderbyid"]
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.model = [OrderDetilModelSC mj_objectWithKeyValues:response];
                                               [self configDataForHeaderSentCode];
                                               
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
}
- (void)setTimeshengyunumber:(NSString *)timeshengyunumber{
    _timeshengyunumber = timeshengyunumber;
    self.timeShengyu.text = timeshengyunumber;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
#pragma mark -  tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.data.goods.count == 0 ? 0 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.model.data.goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 155;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.model.data.goods[indexPath.row].evaluation == 0) {
        shangchengOderThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shangchengOderThreeTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"shangchengOderThreeTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.model = self.model.data.goods[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else {
        ShangchengOderDetilTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangchengOderDetilTwoTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ShangchengOderDetilTwoTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        
        [[[cell.actionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            
            GoodsSCDetil *model = self.model.data.goods[indexPath.row];
            
            SCtuikuanDetilViewController *vc = [[SCtuikuanDetilViewController alloc] init];
            vc.id = model.rec_id;
            [self pushToNextVCWithNextVC:vc];
        }];
        [cell.actionBtn setTitle:@"退款处理" forState:UIControlStateNormal];
        cell.model = self.model.data.goods[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
    
}
- (void)configDataForHeaderSentCode{
    OrderDetilModelSC *model = self.model;

    //订单状态 10：待支付 20：已取消 60：已支付 70：已发货 ：80：已收货待评价 90 已评价
    if (model.data.status == 10) {
        
        self.titleState.text = @"待支付";
        self.timeShengyu.text = @"";
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        [self.rightBtn setTitle:@"修改价格" forState:UIControlStateNormal];

    }else if (model.data.status == 20) {
        
        self.titleState.text = @"已取消订单";
        self.timeShengyu.text = @"";
        self.rightBtn.hidden = YES;
        self.leftBtn.hidden = YES;
    }else if (model.data.status == 60) {
        
        self.titleState.text = @"待发货";
        self.timeShengyu.text = @"";
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        [self.rightBtn setTitle:@"发货" forState:UIControlStateNormal];
    }else if (model.data.status == 70) {
        
        self.titleState.text = @"已发货";
        self.timeShengyu.text = @"";
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        [self.rightBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    }else if (model.data.status == 80) {
        
        self.titleState.text = @"已收货";
        self.timeShengyu.text = @"";
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        [self.rightBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    }else { //90
        
        self.titleState.text = @"已评价";
        self.timeShengyu.text = @"";
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = YES;
        [self.rightBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    }
    self.yonghuName.text = model.data.postname;
    self.address.text = model.data.postaddress;
    self.iphone.text = model.data.postmobile;
    
    self.shangjianame.text = model.data.seller_name;
    self.zongjia.text = [NSString stringWithFormat:@"¥ %@",model.data.goods_amount];
    self.dikou.text = [NSString stringWithFormat:@"¥ %@",model.data.discount];
    
    self.jiangli.text = [NSString stringWithFormat:@"%@",model.data.fanjifen];
    
    
    self.yinfuzonge.text = [NSString stringWithFormat:@"¥ %@",model.data.goods_amount];
    self.yinfujine.text = [NSString stringWithFormat:@"¥ %@",model.data.goods_amount];
    
    self.bianhao.text = [NSString stringWithFormat:@"订单编号：%@",model.data.order_sn];
    self.xiadantime.text = [NSString stringWithFormat:@"下单时间：%@",model.data.published];
    self.fukuantime.text = [NSString stringWithFormat:@"付款时间：%@",model.data.pay_time];
    self.wanchengtime.text = [NSString stringWithFormat:@"完成时间：%@",model.data.received_time];
    int x = 0;
    int y = 0;
    for (int i = 0; i < model.data.goods.count; i ++) {
        if (model.data.goods[i].evaluation == 0) {
            x = x + 1;
        }else {
            y = y + 1;
        }
    }
    self.height.constant = 155 * y + 122 * x;
    self.zongheight.constant = 650 + 155 * y + 122 * x;
    [self.table reloadData];
}
@end
