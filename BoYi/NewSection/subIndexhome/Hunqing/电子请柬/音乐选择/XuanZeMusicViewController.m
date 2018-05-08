//
//  XuanZeMusicViewController.m
//  BoYi
//
//  Created by heng on 2017/12/31.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "XuanZeMusicViewController.h"
#import "XuanZeMusicViewModel.h"
#import "MusicModel.h"
#import <AVFoundation/AVFoundation.h>

@interface XuanZeMusicViewController () {
    NSInteger p;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) XuanZeMusicViewModel *viewModel;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation XuanZeMusicViewController

- (AVPlayer *)player {
	if (!_player) {
		_player = [[AVPlayer alloc] init];
	}
	return _player;
}

//- (AVPlayerItem *)playerItem {
//	if (!_playerItem) {
//		_playerItem = [[AVPlayerItem alloc] init];
//	}
//	return _playerItem;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}

#pragma mark - 点击事件

#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(MusicModel *x) {
        @strongify(self);
		if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MusicID"]) {
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicID"];
		}
        [[NSUserDefaults standardUserDefaults] setObject:@(x.id) forKey:@"MusicID"];
		// 根据用户选择播放音乐
		
		[self playMusic:x.url];
    }];
}

- (void)playMusic:(NSString *)url {
	[self.player pause];
	self.playerItem = nil;
	self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];
	[self.player replaceCurrentItemWithPlayerItem:self.playerItem];
	[self.player play];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self.player pause];
	self.playerItem = nil;
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"XuanZeMusicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XuanZeMusicTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        p = 1;
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{@"tid":@(self.statusFlag),@"p":@(p)}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                p ++;
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    [self.viewModel.refreshDataCommand execute:@{@"tid":@(self.statusFlag),@"p":@(p)}];
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
- (XuanZeMusicViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[XuanZeMusicViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark - delegate






@end
