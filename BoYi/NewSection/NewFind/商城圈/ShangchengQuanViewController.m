//
//  ShangchengQuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengQuanViewController.h"
#import "ShangchengQuanViewModel.h"
#import "ShangchengQuanModel.h"
#import "DongtaiDetilViewController.h"
#import "CXHunqingquanTableViewCell.h"
#import "FindReportViewController.h"
#import "WriteDongtaiViewController.h"
#import "MJPhotoBrowser.h"

static NSString *CXHunqingquanTableViewCellIndentifier = @"CXHunqingquanTableViewCellIndentifier";
@interface ShangchengQuanViewController (){
    NSInteger follow,p;
    NSString *hot,*newest;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) ShangchengQuanViewModel *viewModel;

@end

@implementation ShangchengQuanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    follow = 0;
    hot = @"";
    newest = @"";
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}
- (IBAction)actionall:(UIButton *)sender {
    
    if (sender.tag == 1) {//最新
        if (sender.selected) {
            [self seleZuixinGao];
        }else {
            [self seleZuixinDi];
        }
        sender.selected = !sender.selected;
    }else if (sender.tag == 2){//热门
        if (sender.selected) {
            [self seleRemenGao];
        }else {
            [self seleRemenDi];
        }
        sender.selected = !sender.selected;
    }else {
        [self seleguanzhu];
    }
    [self.table.mj_header beginRefreshing];
}

- (void)seleguanzhu{
    follow = 1;
    hot = @"";//desc asc
    newest = @"";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = NO;
    self.zuixinImage.hidden = YES;
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
}
- (void)seleZuixinGao{
    follow = 0;
    hot = @"";//desc asc
    newest = @"desc";
    self.view1.hidden = NO;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.zuixinImage.hidden = NO;
    self.zuixinImage.image = [UIImage imageNamed:@"价格从高到低"];
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
}
- (void)seleZuixinDi{
    follow = 0;
    hot = @"";//desc asc
    newest = @"asc";
    self.view1.hidden = NO;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.zuixinImage.hidden = NO;
    self.zuixinImage.image = [UIImage imageNamed:@"价格从低到高"];
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
}
- (void)seleRemenGao{
    follow = 0;
    hot = @"";//desc asc
    newest = @"desc";
    self.view1.hidden = YES;
    self.view2.hidden = NO;
    self.view3.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.image = [UIImage imageNamed:@"价格从高到低"];
    self.remenImage.hidden = NO;
    [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
}
- (void)seleRemenDi{
    follow = 0;
    hot = @"";//desc asc
    newest = @"asc";
    self.view1.hidden = YES;
    self.view2.hidden = NO;
    self.view3.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.image = [UIImage imageNamed:@"价格从低到高"];
    self.remenImage.hidden = NO;
    [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
}

#pragma mark - 点击事件

- (IBAction)writeDongtai:(id)sender {
    WriteDongtaiViewController *vc = [[WriteDongtaiViewController alloc] init];
    [self pushToNextVCWithNextVC:vc];
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Hunqinnewarray *x) {
        @strongify(self);
        DongtaiDetilViewController *dongtai = [[DongtaiDetilViewController alloc] init];
        dongtai.id = x.id;
        dongtai.superModel = x;
        
        [self pushToNextVCWithNextVC:dongtai];
        @weakify(self);
        [dongtai.refreshDataSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.table reloadData];
        }];
    }];
   
    //评论
    [self.viewModel.pinglunseleUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger i = [x integerValue];
        [HuifuiPL showInView:self.view setid:i block:^(NSString *date) {
            [self.table.mj_header beginRefreshing];
        }];
    }];
    
    [self.viewModel.dianzanSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.table reloadData];
    }];
    [self.viewModel.refreshdateSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.table reloadData];
    }];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"HunqinQuanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunqinQuanTableViewCell"];
    [self.table registerClass:[CXHunqingquanTableViewCell class] forCellReuseIdentifier:CXHunqingquanTableViewCellIndentifier];
    //    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        p = 1;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (follow != 0) {
            [dic setObject:@(follow) forKey:@"follow"];
        }
        if (![hot isEqualToString:@""]) {
            [dic setObject:hot forKey:@"hot"];
        }
        if (![newest isEqualToString:@""]) {
            [dic setObject:newest forKey:@"newest"];
        }
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setObject:@(p) forKey:@"p"];
        
        
        
        [self.viewModel.refreshDataCommand execute:dic];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    p ++;
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    if (follow != 0) {
                        [dic setObject:@(follow) forKey:@"follow"];
                    }
                    if (![hot isEqualToString:@""]) {
                        [dic setObject:hot forKey:@"hot"];
                    }
                    if (![newest isEqualToString:@""]) {
                        [dic setObject:newest forKey:@"newest"];
                    }
                    
                    [dic setObject:@(p) forKey:@"p"];
                    
                    
                    
                    [self.viewModel.refreshDataCommand execute:dic];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
    }];
}

//初始化viewModel
- (ShangchengQuanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShangchengQuanViewModel alloc] init];
        WeakSelf(self);
        [_viewModel setOnSelectedImage:^(NSArray *array, NSInteger index) {
            //            weakSelf.imageArray = array;
            [weakSelf tapImage:array];
        }];
        [_viewModel setOnSelectedHeader:^(NSInteger index) {
            
            ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
            vc.id = index;
            [weakSelf pushToNextVCWithNextVC:vc];
        }];
        [_viewModel setOnJubao:^(NSInteger dyid) {
            FindReportViewController *vc = [[FindReportViewController alloc] init];
            vc.dyid = dyid;
            [weakSelf pushToNextVCWithNextVC:vc];
        }];
        
    }
    return _viewModel;
}

- (void)tapImage:(NSArray *)urls
{
    NSInteger count = urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        
        // 替换为中等尺寸图片
        NSString *url = urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = nil;//self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;//tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
@end

