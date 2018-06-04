//
//  LookWuliuViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/2.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "LookWuliuViewController.h"
#import "lookModel.h"
#import "LooKwuliuHeader.h"
#import "LookWuliuTableViewCell.h"
@interface LookWuliuViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (strong,nonatomic) NSMutableArray <Traces *>*dataArray;
@property (strong,nonatomic) lookModel *model;

@end

@implementation LookWuliuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流信息";
    [self addPopBackBtn];
    [self.table registerNib:[UINib nibWithNibName:@"LookWuliuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LookWuliuTableViewCell"];
    
    self.table.delegate             = self;
    self.table.dataSource           = self;
    self.table.emptyDataSetDelegate = self;
    self.table.emptyDataSetSource   = self;
    [self getdata];
}
- (void)getdata{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setValue:@"134" forKey:@"id"];
    [dic setValue:@(self.id) forKey:@"id"];
    
    NSString *path = self.isIntegral
                   ? @"appapi/integral/chakanwuliu"
                   : @"appapi/orders/chakanwuliu";
    
    
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:path]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.dataArray = [NSMutableArray array];
                            
                                               self.model = [lookModel mj_objectWithKeyValues:response[@"data"]];
                                               [self.dataArray addObjectsFromArray:[Traces mj_objectArrayWithKeyValuesArray:response[@"data"][@"Traces"]]];
                                               
                                               NSArray *array = (NSArray *)self.dataArray;
                                               NSArray *arrayone = [[array reverseObjectEnumerator] allObjects];
                                               [self.dataArray removeAllObjects];
                                               self.dataArray = [NSMutableArray arrayWithArray:arrayone];
                                               [self.table reloadData];
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager showMessage:@"请检查网络"];
                                           
                                       }];
}
#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count == 0 ? 0 : 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 102 + 46;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    LooKwuliuHeader *header = [[NSBundle mainBundle]loadNibNamed:@"LooKwuliuHeader" owner:nil options:nil].firstObject;
    header.frame = CGRectMake(0, 0, ScreenWidth, 81);
    [header.goodsImage sd_setImageWithUrl:self.imageurl placeHolder:[UIImage imageNamed:@"占位图片"]];
    header.danhao.text = self.model.LogisticCode;
    header.name.text = [NSString stringWithFormat:@"%@:",self.model.ShipperCode];
    header.iphone.text = self.model.EBusinessID;
    if ([self.model.State intValue] == 0) {
        header.iphone.text = @"无轨迹";
    }else if ([self.model.State intValue] == 1) {
        header.iphone.text = @"已揽收";
    }else if ([self.model.State intValue] == 2) {
        header.iphone.text = @"在途中";
    }else if ([self.model.State intValue] == 3) {
        header.iphone.text = @"已签收";
    }else {
        header.iphone.text = @"问题件";
    }
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LookWuliuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookWuliuTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LookWuliuTableViewCell" owner:nil options:nil].firstObject;
    }
    if (indexPath.row == 0) {
        cell.shi.textColor = MAINCOLOR;
        cell.ri.textColor = MAINCOLOR;
        cell.content.textColor = MAINCOLOR;
    }else {
        cell.shi.textColor = RGBA(108, 108, 108, 1);
        cell.ri.textColor = RGBA(108, 108, 108, 1);
        cell.content.textColor = RGBA(108, 108, 108, 1);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return  cell;
}

#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"暂无物流信息";
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = RGBA(202, 202, 202, 1);
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return IMAGE_NAME(@"无数据 空状态");
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -49.0;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.dataArray.count == 0  && self.dataArray;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
@end
