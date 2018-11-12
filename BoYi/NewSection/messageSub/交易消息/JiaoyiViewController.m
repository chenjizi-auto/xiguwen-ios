//
//  JiaoyiViewController.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "JiaoyiViewController.h"
#import "jiaoyiTableViewCell.h"
#import "jiaoyiModel.h"
#import "OrderDetilNewViewController.h"
#import "OrderDetilNewSCViewController.h"

@interface JiaoyiViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong,nonatomic) NSMutableArray <Contjiaoyi *>*dataArray;
@property (strong,nonatomic) jiaoyiModel *model;
@end

@implementation JiaoyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.table registerNib:[UINib nibWithNibName:@"jiaoyiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jiaoyiTableViewCell"];
    
    self.table.delegate             = self;
    self.table.dataSource           = self;
    self.table.emptyDataSetDelegate = self;
    self.table.emptyDataSetSource   = self;
    [self getdata];
}
- (void)getdata{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"10000" forKey:@"rows"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/information/trading_message"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.dataArray = [NSMutableArray array];

                                               [self.dataArray addObjectsFromArray:[Contjiaoyi mj_objectArrayWithKeyValuesArray:response[@"data"][@"cont"]]];
                                               
//                                               NSArray *array = (NSArray *)self.dataArray;
//                                               NSArray *arrayone = [[array reverseObjectEnumerator] allObjects];
//                                               [self.dataArray removeAllObjects];
//                                               self.dataArray = [NSMutableArray arrayWithArray:arrayone];
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
    
    return 87;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
    
}

-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Contjiaoyi *model = self.dataArray[indexPath.row];
    if (model.type == 1) {
        if (model.types == 1) {
            OrderDetilNewViewController *detil = [[OrderDetilNewViewController alloc] init];
            detil.id = model.sid;
            [self pushToNextVCWithNextVC:detil];
        }else {
            OrderDetilNewSCViewController *vc = [[OrderDetilNewSCViewController alloc] init];
            vc.id = model.sid;
            [self pushToNextVCWithNextVC:vc];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    jiaoyiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jiaoyiTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"jiaoyiTableViewCell" owner:nil options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return  cell;
}

#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"暂无交易信息";
    
    
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
