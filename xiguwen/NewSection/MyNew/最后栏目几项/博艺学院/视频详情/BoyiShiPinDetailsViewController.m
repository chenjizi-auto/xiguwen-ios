//
//  BoyiShiPinDetailsViewController.m
//  BoYi
//
//  Created by zhoumeineng on 3/20/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPinDetailsViewController.h"
#import "BoyiShiPingPlayDetailsView.h"
#import "BoyiShipinCommentTableView.h"
#import "BoyiShipinOperateView.h"
#import "BoyiShiPingCommentAndSupportSected.h"
#import "BoyiShiPinCommentDetailViewModel.h"
#import "BoyiShiPinNavigatinBar.h"
#if __has_include("xiguwen-Swift.h")
#import "xiguwen-Swift.h"
#endif
@interface BoyiShiPinDetailsViewController ()
@property(nonatomic,strong)BoyiShiPingPlayDetailsView * PlayDetailsView;
@property(nonatomic,strong)BoyiShipinCommentTableView * CommentTableView;
@property(nonatomic,strong)BoyiShipinOperateView * OperateView;
@property(nonatomic,strong)BoyiShiPingCommentAndSupportSected * CommentAndSupportSected;
@property(nonatomic,strong)BoyiShiPinCommentDetailViewModel * CommentDetailViewModel;
@property(nonatomic,strong)CwBMPlayerContainerView *playerContainerView;
@property(nonatomic,strong)BoyiShiPinNavigatinBar *navigationBarView;
@end

@implementation BoyiShiPinDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self playerContainerView];
    [self navigationBarView];
    [self PlayDetailsView];
    [self CommentAndSupportSected];
    [self CommentTableView];
    [self OperateView];
    [self CommentDetailViewModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
    [self.playerContainerView pausePlayback];
}
- (BOOL)prefersStatusBarHidden{
    return  YES;
}

- (CwBMPlayerContainerView *)playerContainerView {
    if (!_playerContainerView) {
        _playerContainerView = [[CwBMPlayerContainerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 220)];
        [self.view addSubview:_playerContainerView];
        [_playerContainerView playWithUrlString:self.model.video_url titleText:self.model.name];
    }
    return _playerContainerView;
}

- (BoyiShiPinNavigatinBar *)navigationBarView {
    if (!_navigationBarView) {
        _navigationBarView = [[NSBundle mainBundle] loadNibNamed:@"BoyiShiPinNavigatinBar" owner:self options:nil].firstObject;
        _navigationBarView.frame = CGRectMake(0, 0, ScreenWidth, 60);
        __weak typeof(self) weakSelf = self;
        _navigationBarView.Mblock = ^(NSInteger INDEXT, id action) {
            if (INDEXT == BackAction) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        };
        [self.view addSubview:_navigationBarView];
    }
    return _navigationBarView;
}

/**
 * 视屏的详情
 */
- (BoyiShiPingPlayDetailsView *)PlayDetailsView{
    if (!_PlayDetailsView) {
        _PlayDetailsView = [[NSBundle mainBundle] loadNibNamed:@"BoyiShiPingPlayDetailsView" owner:self options:nil].firstObject;
        [self.view addSubview:_PlayDetailsView];
        _PlayDetailsView.frame = CGRectMake(0, CGRectGetMaxY(self.playerContainerView.frame), ScreenWidth, 60);
    }
    return _PlayDetailsView;
}

/**
 * 评论 和 点赞 查看按钮
 */
- (BoyiShiPingCommentAndSupportSected *)CommentAndSupportSected{
    if (!_CommentAndSupportSected) {
        _CommentAndSupportSected = [[NSBundle mainBundle] loadNibNamed:@"BoyiShiPingCommentAndSupportSected" owner:self options:nil].firstObject;
        _CommentAndSupportSected.frame = CGRectMake(0, CGRectGetMaxY(self.PlayDetailsView.frame), ScreenWidth, 40);
        [self.view addSubview:_CommentAndSupportSected];
    }
    return _CommentAndSupportSected;
}

/**
 * 评论显示 的Table
 */
- (BoyiShipinCommentTableView *)CommentTableView
{
    if (!_CommentTableView) {
        _CommentTableView = [[BoyiShipinCommentTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.CommentAndSupportSected.frame), ScreenWidth, CGRectGetMinY(self.OperateView.frame)-  CGRectGetMaxY(self.CommentAndSupportSected.frame)) style:UITableViewStylePlain];
        [self.view addSubview:_CommentTableView];
    }
    return _CommentTableView;
}

/**
 *评论 和 点赞 操作按钮
 */
- (BoyiShipinOperateView *)OperateView{
    if (!_OperateView) {
        _OperateView = [[NSBundle mainBundle] loadNibNamed:@"BoyiShipinOperateView" owner:self options:nil].firstObject;
        _OperateView.frame = CGRectMake(0, ScreenHeight-40, ScreenWidth, 40);
        [self.view addSubview:_OperateView];
    }
    return _OperateView;
}

/**
 * 处理请求
 */
- (BoyiShiPinCommentDetailViewModel *)CommentDetailViewModel
{
    if (!_CommentDetailViewModel) {
        _CommentDetailViewModel = [[BoyiShiPinCommentDetailViewModel alloc]init];
        NSInteger userId =[UserDataNew sharedManager].userInfoModel.user.userid;
        NSString * token = [UserDataNew sharedManager].userInfoModel.token.token;
        [_CommentDetailViewModel Request:@{@"id":@(self.model.id),@"token":token,@"userid":@(userId)}];
        
        __weak typeof(self)weakSelf = self;
        _CommentDetailViewModel.Mblock = ^(BoyiShiPinDetailModel *ShiPinDetailModel) {
            [weakSelf UpUiframe:ShiPinDetailModel];
            [weakSelf.navigationBarView setData:ShiPinDetailModel];
            [weakSelf.PlayDetailsView SetData:ShiPinDetailModel];
            [weakSelf.CommentTableView SetDataSources:ShiPinDetailModel];
            [weakSelf.CommentAndSupportSected setData:ShiPinDetailModel];
        };
    }
    return _CommentDetailViewModel;
}
-(void)UpUiframe:(BoyiShiPinDetailModel*)model{
    CGSize size = [model.describe boundingRectWithSize:CGSizeMake(ScreenWidth - 12, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    _PlayDetailsView.frame = CGRectMake(0, CGRectGetMaxY(self.playerContainerView.frame), ScreenWidth, 35+40+size.height);
     _CommentAndSupportSected.frame = CGRectMake(0, CGRectGetMaxY(self.PlayDetailsView.frame), ScreenWidth, 40);
    _CommentTableView.frame = CGRectMake(0, CGRectGetMaxY(self.CommentAndSupportSected.frame), ScreenWidth, CGRectGetMinY(self.OperateView.frame)-  CGRectGetMaxY(self.CommentAndSupportSected.frame));
}
@end
