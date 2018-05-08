//
//  BoyiYinYueViewController.m
//  BoYi
//
//  Created by heng on 2018/1/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "BoyiYinYueViewController.h"
#import "BoyiYinYueViewModel.h"
#import "BoyiShiPingType.h"
#import "BoyiYinYueListTableView.h"
#import "BOyiShiPinMoreViewController.h"
@interface BoyiYinYueViewController ()
@property (strong,nonatomic)BoyiYinYueViewModel *viewModel;
@property(nonatomic,strong)BoyiShiPingType * typeView;
@property(nonatomic,strong)BoyiYinYueListTableView * TableView;
@end

@implementation BoyiYinYueViewController
{
    /**
     * 请求的参数
     */
    NSInteger  type;//视频类别 id
    NSString *name;//视频名称
    NSInteger isvipsee;//是否是vip查看 1 是 0 不是
    NSInteger dispaly;//是否显示1 显示 0 不显示
    NSInteger userId;
    NSString * token;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"";
    type = -1;
    name = @"";
    userId =[UserDataNew sharedManager].userInfoModel.user.userid;
    token = [UserDataNew sharedManager].userInfoModel.token.token;
    [self addPopBackBtn];
    [self viewModel];
    [self typeView];
    [self TableView];
}
-(void)request{
    [self.viewModel Request:[self NomalParam]];
    [self.TableView.mj_header endRefreshing];
     [self.TableView.mj_footer endRefreshing];

}


#pragma   -------------------  初始化操作---------------------------------
- (BoyiShiPingType *)typeView{
    if (!_typeView) {
        _typeView = [[BoyiShiPingType alloc]init];
        [self.view addSubview:_typeView];
        __weak typeof(self)weakSelf = self;
        /**
         * 类别选择事件
         */
        _typeView.Mblock = ^(UIButton *btn) {
            type = btn.tag - 1000;
            [weakSelf request];
        };
        /**
         * 搜索事件
         */
        _typeView.searchBlock = ^(NSString *text) {
            name = text;
            [weakSelf request];
        };
        
    }
    return _typeView;
}


//初始化viewModel
- (BoyiYinYueViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BoyiYinYueViewModel alloc] init];
        [self request];
        
        __weak typeof(self)weakSelf = self;
        __weak typeof(_viewModel)viewModels = _viewModel;
        _viewModel.Mblock = ^{
            if (type==-1) {
                [weakSelf.typeView SHIpingTypeNumber:viewModels.typeArray];
                weakSelf.typeView.frame = CGRectMake(0, 0,weakSelf.view.bounds.size.width, 28*(viewModels.typeArray.count/4+1)+16*(viewModels.typeArray.count/4+2)+ 50);
                weakSelf.TableView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.typeView.frame), ScreenWidth, weakSelf.view.frame.size.height - CGRectGetMaxY(weakSelf.typeView.frame));
                type = viewModels.typeArray.firstObject.id;
            }
            
            [weakSelf.TableView setTablData:@[viewModels.tuijian,viewModels.zuixin,viewModels.zuire]];
            
        };
    }
    return _viewModel;
}
- (BoyiYinYueListTableView *)TableView
{
    if (!_TableView) {
        _TableView = [[BoyiYinYueListTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.typeView.frame), ScreenWidth, self.view.frame.size.height - CGRectGetMaxY(self.typeView.frame))];
        [self.view addSubview:_TableView];
        
        _TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _viewModel.isfresh = YES;
            [self request];
        }];
        _TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _viewModel.isfresh = NO;
            [self request];
        }];
        __weak typeof(self)weakSelf = self;
        _TableView.Mblock = ^(NSString *title) {
            BOyiShiPinMoreViewController * vc = [[BOyiShiPinMoreViewController alloc]init];
            vc.titletex = title;
            vc.type = type;
            vc.musicOrVideo = MUSIC;
            [((UIViewController*)weakSelf.objc).navigationController pushViewController:vc animated:YES];
        };
    }
    return _TableView;
}
/**
 * 请求的参数
 */
- (NSDictionary*)NomalParam{
     NSInteger page = 0;
    self.viewModel.isfresh?page=0:page++;
    return type!=-1?@{@"p":@(page),@"type":@(type),@"name":name,@"token":token}:@{@"p":@(page),@"name":name,@"userId":@(userId),@"token":token};
}
@end
