//
//  BoyiShiPinDetailsViewController.m
//  BoYi
//
//  Created by zhoumeineng on 3/20/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPinDetailsViewController.h"
#import "BoyiShiPingDetaileViewModel.h"
#import "BoyiShiPingPlayDetailsView.h"
#import "BoyiShipinCommentTableView.h"
#import "BoyiShipinOperateView.h"
#import "BoyiShiPingCommentAndSupportSected.h"
#import "BoyiShiPinCommentDetailViewModel.h"
@interface BoyiShiPinDetailsViewController ()
@property(nonatomic,strong)BoyiShiPingDetaileViewModel * DetaileViewModel;
@property(nonatomic,strong)BoyiShiPingPlayDetailsView * PlayDetailsView;
@property(nonatomic,strong)BoyiShipinCommentTableView * CommentTableView;
@property(nonatomic,strong)BoyiShipinOperateView * OperateView;
@property(nonatomic,strong)BoyiShiPingCommentAndSupportSected * CommentAndSupportSected;
@property(nonatomic,strong)BoyiShiPinCommentDetailViewModel * CommentDetailViewModel;
@end

@implementation BoyiShiPinDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self DetaileViewModel];
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
    [self.DetaileViewModel PlayReleaseSources];
}
- (BOOL)prefersStatusBarHidden{
    return  YES;
}



- (BoyiShiPingDetaileViewModel *)DetaileViewModel{
    if (!_DetaileViewModel) {
        _DetaileViewModel = [BoyiShiPingDetaileViewModel shareManager:self.model.video_url objc:self];
    }
    return _DetaileViewModel;
}

/**
 * 视屏的详情
 */
- (BoyiShiPingPlayDetailsView *)PlayDetailsView{
    if (!_PlayDetailsView) {
        _PlayDetailsView = [[NSBundle mainBundle] loadNibNamed:@"BoyiShiPingPlayDetailsView" owner:self options:nil].firstObject;
        [self.view addSubview:_PlayDetailsView];
        _PlayDetailsView.frame = CGRectMake(0, CGRectGetMaxY(self.DetaileViewModel.playerFrame), ScreenWidth, 60);
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
            [weakSelf.DetaileViewModel setData:ShiPinDetailModel];
            [weakSelf.PlayDetailsView SetData:ShiPinDetailModel];
            [weakSelf.CommentTableView SetDataSources:ShiPinDetailModel];
            [weakSelf.CommentAndSupportSected setData:ShiPinDetailModel];
        };
    }
    return _CommentDetailViewModel;
}
-(void)UpUiframe:(BoyiShiPinDetailModel*)model{
    CGSize size = [model.describe boundingRectWithSize:CGSizeMake(ScreenWidth - 12, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    _PlayDetailsView.frame = CGRectMake(0, CGRectGetMaxY(self.DetaileViewModel.playerFrame), ScreenWidth, 35+40+size.height);
     _CommentAndSupportSected.frame = CGRectMake(0, CGRectGetMaxY(self.PlayDetailsView.frame), ScreenWidth, 40);
    _CommentTableView.frame = CGRectMake(0, CGRectGetMaxY(self.CommentAndSupportSected.frame), ScreenWidth, CGRectGetMinY(self.OperateView.frame)-  CGRectGetMaxY(self.CommentAndSupportSected.frame));
}
@end
