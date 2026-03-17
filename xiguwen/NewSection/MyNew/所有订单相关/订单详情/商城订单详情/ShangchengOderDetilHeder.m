//
//  ShangchengOderDetilHeder.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengOderDetilHeder.h"
#import "ShangchengOderDetilTwoTableViewCell.h"
@implementation ShangchengOderDetilHeder

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.table registerNib:[UINib nibWithNibName:@"ShangchengOderDetilTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShangchengOderDetilTwoTableViewCell"];
    self.table.delegate             = self;
    self.table.dataSource           = self;
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
    
    ShangchengOderDetilTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangchengOderDetilTwoTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShangchengOderDetilTwoTableViewCell" owner:nil options:nil].firstObject;
    }
    if (self.model.data.status == 10) {
        cell.actionBtn.hidden = YES;
    }else if (self.model.data.status == 20) {
        cell.actionBtn.hidden = YES;
    }else if (self.model.data.status == 60) {
        cell.actionBtn.hidden = NO;
    }else if (self.model.data.status == 70) {
        cell.actionBtn.hidden = NO;
    }else if (self.model.data.status == 80) {
        cell.actionBtn.hidden = NO;
    }else { //90
        cell.actionBtn.hidden = YES;
    }
    if (self.model.data.goods[indexPath.row].evaluation != 0) {
        [cell.actionBtn setTitle:@"退款详情" forState:UIControlStateNormal];
    }else {
        [cell.actionBtn setTitle:@"申请退款" forState:UIControlStateNormal];
    }
    @weakify(self);
    [[[cell.actionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        [self.selectItemSubject sendNext:self.model.data.goods[indexPath.row]];
    }];
    
    cell.model = self.model.data.goods[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
- (void)setModel:(OrderDetilModelSC *)model{
    _model = model;
    //订单状态 10：待支付 20：已取消 60：已支付 70：已发货 ：80：已收货待评价 90 已评价
    if (model.data.status == 10) {

        self.titleState.text = @"待支付";
        self.timeShengyu.text = @"";
    }else if (model.data.status == 20) {
    
        self.titleState.text = @"已关闭订单";
        self.timeShengyu.text = @"";
    }else if (model.data.status == 60) {
      
        self.titleState.text = @"待发货";
        self.timeShengyu.text = @"";
    }else if (model.data.status == 70) {
       
        self.titleState.text = @"已发货";
        self.timeShengyu.text = @"";

    }else if (model.data.status == 80) {
      
        self.titleState.text = @"交易成功";
        self.timeShengyu.text = @"";
    }else { //90
       
        self.titleState.text = @"交易成功";
        self.timeShengyu.text = @"";
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
    self.height.constant = 155 * model.data.goods.count;
    [self.table reloadData];
}

@end
