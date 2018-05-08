//
//  FindDetailViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/10.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FindDetailViewController.h"
#import "FindDetailViewModel.h"
#import "HeaderView.h"
#import "FindXinXiModel.h"
#import "CostViewController.h"
#import "AskViewController.h"
#import "NewPeopleDetilViewController.h"
#import "AskSuccessViewController.h"
@interface FindDetailViewController (){
    NSString *_isJiazaiMore;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) FindDetailViewModel *viewModel;

@property(nonatomic,assign)NSInteger curPage;

@property(nonatomic,assign)NSInteger curPagePJ;

@end

@implementation FindDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _isJiazaiMore = @"yes";
    self.navigationItem.title = @"案例详情";
    [self addPopBackBtn];
    
    [self setupTableView];
}


#pragma mark - 点击事件



#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"FindDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FindDetailTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    
    [self headerView];
    @weakify(self);
    
    
    //传入参数 进行刷新
    [self.viewModel.refreshDataCommand execute:@{@"id":[NSString stringWithFormat:@"%@",self.idString]}];
    
    [self.viewModel.refreshDataCommandTP execute:@{@"id":[NSString stringWithFormat:@"%@",self.idString],@"curPage":[NSString stringWithFormat:@"%ld",_curPage]}];
    
    [self.viewModel.refreshDataCommandTJ execute:@{@"id":[NSString stringWithFormat:@"%@",self.idString]}];

    
    [self.viewModel.refreshDataCommandPJ execute:@{@"id":[NSString stringWithFormat:@"%@",self.idString],@"curPage":[NSString stringWithFormat:@"%ld",_curPagePJ]}];
    
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
       FindXinXiModel *model = [FindXinXiModel mj_objectWithKeyValues:x[@"r"]];
    
        HeaderView *header = (HeaderView *)self.table.tableHeaderView;
        header.model = model;
        self.viewModel.xinxiModel = model;
//        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.table reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.table reloadData];
    }];
    //请求结束
    [self.viewModel.refreshUISubjectPJ subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    [self.viewModel.refreshDataCommand execute:@{}];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if (self.viewModel.dataArray.count < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
       
        //刷新视图
        [self.table reloadData];
        
    }];
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        NewPeopleDetilViewController *people = [[NewPeopleDetilViewController alloc] init];
        people.userId = x;
        [self pushToNextVCWithNextVC:people];
    }];
 
    
   
    
    
    //信息
    [self.viewModel.lookSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        CostViewController *cost = [[CostViewController alloc] init];
        cost.userId = [NSString stringWithFormat:@"%@",x];
        [self pushToNextVCWithNextVC:cost];
    }];
    //more
    [self.viewModel.moreSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if ([_isJiazaiMore isEqualToString:@"yes"]) {
            [self.viewModel.refreshDataCommandTP execute:@{@"id":[NSString stringWithFormat:@"%@",self.idString],@"curPage":[NSString stringWithFormat:@"%ld",_curPage]}];
        }else {
            [NavigateManager showMessage:@"已加载完毕"];
        }
        
    }];
    //请求结束//图片
    [self.viewModel.refreshUISubjectTP subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObjectTP:x];
        
        //判断，如果item < size 显示已获取完成
        NSMutableArray *array = x[@"r"][@"rows"];
        if (array.count < 10) {
            
            _isJiazaiMore = @"no";
        } else {
            
           _isJiazaiMore = @"yes";
            
        }
        //刷新视图
        [self.table reloadData];
        
    }];

    //推荐
    [self.viewModel.refreshUISubjectTJ subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //数据处理
        [self.viewModel ConvertingToObjectTJ:x];
    
        //刷新视图
        [self.table reloadData];
    }];
    
   
}

- (void)headerView{
    HeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:nil options:nil].firstObject;
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.frame = CGRectMake(0, 0, ScreenWidth, 445);
    self.table.tableHeaderView = header;
    @weakify(self);
    [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
        

        @strongify(self);

        NSString *idStr = x;
        if ([idStr isEqualToString:@""]) {
            return ;
        }
        NewPeopleDetilViewController *peo = [[NewPeopleDetilViewController alloc] init];
        peo.userId = idStr;
        [self pushToNextVCWithNextVC:peo];
       
        
    }];

}

//初始化viewModel
- (FindDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FindDetailViewModel alloc] init];
    }
    return _viewModel;
}
- (IBAction)action:(UIButton *)sender {
  
//    if (sender.tag == 10) {
//        
//        
//        
//    }else {
//        
//        
//    }
    AskViewController *ask = [[AskViewController alloc] init];
    ask.idString = [NSString stringWithFormat:@"%@",self.idString];
    [self pushToNextVCWithNextVC:ask];
}


@end
