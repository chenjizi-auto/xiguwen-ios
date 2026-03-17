//
//  DongtaiDetilViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "DongtaiDetilViewModel.h"
#import "DongtaiDetilTableViewCell.h"
#import "DongraiDetilHeader.h"
#import "PinglunTableViewCell.h"

@interface DongtaiDetilViewModel ()

@property (nonatomic, strong) UIView *stickyHeaderView;
@property (nonatomic, weak) UILabel *stickyCommentLabel;
@property (nonatomic, weak) UILabel *stickyLikeLabel;
@property (nonatomic, weak) UIView *stickyLineComment;
@property (nonatomic, weak) UIView *stickyLineLike;

@end

@implementation DongtaiDetilViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        //处理正在请求状态
        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        [self.addguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.addguanzhuSubject sendNext:x];
        }];
        [self.deleguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.deleguanzhuSubject sendNext:x];
        }];
        [self.dianzanCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshdateSubject sendNext:@YES];
        }];
        [self.deleteDianzanCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshdateSubject sendNext:@NO];
        }];
    }
    return self;
}

#pragma mark - public
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    
    self.model = [DongtaiDetilModel mj_objectWithKeyValues:object];
    if (![self.model.photourl isKindOfClass:[NSArray class]]) {
        self.model.photourl = @[];
    }
    if (![self.model.commentlist isKindOfClass:[NSArray class]]) {
        self.model.commentlist = @[];
    }
    if (![self.model.zanlist isKindOfClass:[NSArray class]]) {
        self.model.zanlist = @[];
    }
    [self updateStickyHeader];
    
}

#pragma mark - Sticky Header

- (UIView *)buildStickyHeaderIfNeeded {
    if (self.stickyHeaderView) {
        return self.stickyHeaderView;
    }
    CGFloat headerHeight = 50.0;
    CGFloat buttonWidth = 120.0;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headerHeight)];
    header.backgroundColor = UIColor.whiteColor;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.clipsToBounds = YES;
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, headerHeight - 1.0, ScreenWidth, 1.0)];
    bottomLine.backgroundColor = RGBA(236, 236, 236, 1);
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [header addSubview:bottomLine];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(0, 0, buttonWidth, headerHeight);
    commentButton.tag = 1;
    commentButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [commentButton addTarget:self action:@selector(stickyHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:commentButton];
    
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.textColor = RGBA(137, 137, 137, 1);
    [commentButton addSubview:commentLabel];
    
    UIView *commentLine = [[UIView alloc] initWithFrame:CGRectMake((buttonWidth - 50.0) / 2.0, headerHeight - 3.0, 50.0, 3.0)];
    commentLine.backgroundColor = MAINCOLOR;
    [commentButton addSubview:commentLine];
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(ScreenWidth - buttonWidth, 0, buttonWidth, headerHeight);
    likeButton.tag = 2;
    likeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [likeButton addTarget:self action:@selector(stickyHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:likeButton];
    
    UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    likeLabel.font = [UIFont systemFontOfSize:14];
    likeLabel.textColor = RGBA(137, 137, 137, 1);
    [likeButton addSubview:likeLabel];
    
    UIView *likeLine = [[UIView alloc] initWithFrame:CGRectMake((buttonWidth - 50.0) / 2.0, headerHeight - 3.0, 50.0, 3.0)];
    likeLine.backgroundColor = MAINCOLOR;
    likeLine.hidden = YES;
    [likeButton addSubview:likeLine];
    
    self.stickyHeaderView = header;
    self.stickyCommentLabel = commentLabel;
    self.stickyLikeLabel = likeLabel;
    self.stickyLineComment = commentLine;
    self.stickyLineLike = likeLine;
    
    [self updateStickyHeader];
    return header;
}

- (void)stickyHeaderAction:(UIButton *)sender {
    if (sender.tag == 1) {
        self.isPinglun = 1;
    } else if (sender.tag == 2) {
        self.isPinglun = 0;
    }
    [self updateStickyHeader];
    if (self.tableView) {
        [self.tableView setContentOffset:CGPointZero animated:NO];
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)updateStickyHeader {
    if (!self.stickyHeaderView) {
        return;
    }
    NSInteger commentCount = self.model ? self.model.commentnum : 0;
    NSInteger likeCount = self.model ? self.model.zan : 0;
    self.stickyCommentLabel.text = [NSString stringWithFormat:@"评论%ld", (long)commentCount];
    self.stickyLikeLabel.text = [NSString stringWithFormat:@"点赞%ld", (long)likeCount];
    [self.stickyCommentLabel sizeToFit];
    [self.stickyLikeLabel sizeToFit];
    CGFloat buttonWidth = 120.0;
    self.stickyCommentLabel.center = CGPointMake(buttonWidth * 0.5, 25.0);
    self.stickyLikeLabel.center = CGPointMake(buttonWidth * 0.5, 25.0);
    if (self.isPinglun) {
        self.stickyCommentLabel.textColor = MAINCOLOR;
        self.stickyLikeLabel.textColor = RGBA(137, 137, 137, 1);
        self.stickyLineComment.hidden = NO;
        self.stickyLineLike.hidden = YES;
    } else {
        self.stickyCommentLabel.textColor = RGBA(137, 137, 137, 1);
        self.stickyLikeLabel.textColor = MAINCOLOR;
        self.stickyLineComment.hidden = YES;
        self.stickyLineLike.hidden = NO;
    }
}


#pragma mark - private



- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}
- (RACSubject *)addguanzhuSubject {
    
    if (!_addguanzhuSubject) _addguanzhuSubject = [RACSubject subject];
    
    return _addguanzhuSubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)pinglunseleUISubject {
    
    if (!_pinglunseleUISubject) _pinglunseleUISubject = [RACSubject subject];
    
    return _pinglunseleUISubject;
}
- (RACSubject *)refreshdateSubject {
    
    if (!_refreshdateSubject) _refreshdateSubject = [RACSubject subject];
    
    return _refreshdateSubject;
}
- (RACSubject *)deleguanzhuSubject {
    
    if (!_deleguanzhuSubject) _deleguanzhuSubject = [RACSubject subject];
    
    return _deleguanzhuSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_dongtaiDetil
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)deleguanzhuCommand {
    
    if (!_deleguanzhuCommand) {
        @weakify(self);
        _deleguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_deleGuanzhu
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _deleguanzhuCommand;
}
- (RACCommand *)addguanzhuCommand {
    
    if (!_addguanzhuCommand) {
        @weakify(self);
        _addguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:URL_ADDUserFollowById
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _addguanzhuCommand;
}
- (RACCommand *)dianzanCommand {
    
    if (!_dianzanCommand) {
        @weakify(self);
        _dianzanCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_dianzan
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _dianzanCommand;
}
- (RACCommand *)deleteDianzanCommand {
    
    if (!_deleteDianzanCommand) {
        @weakify(self);
        _deleteDianzanCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Found/qxlikes"]
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _deleteDianzanCommand;
}
#pragma mark - 网络请求
- (RACSignal *)requestSignalWithUrl:(NSString *)url
                            loading:(NSString *)loading
                      Authorization:(NSString *)Authorization
                               info:(NSDictionary *)info {
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:POST
                                                                         loding:loading
                                                                            dic:info
                                                                       progress:nil
                                                                        success:^(NSURLSessionDataTask *task, id response) {
                                                                            //
                                                                            [subscriber sendNext:response];
                                                                            [subscriber sendCompleted];
                                                                            
                                                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                            // 如果网络请求出错，则加载数据库中的旧数据
                                                                            
                                                                            [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
                                                                            [subscriber sendCompleted];
                                                                        }];
        // 在信号量作废时，取消网络请求
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return requestSignal;
}
#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isPinglun) {
        NSInteger x = self.model.commentlist.count;
        return x;
    }else {
        NSInteger x = self.model.zanlist.count;
        return x;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isPinglun) {
        CommentlistDongtai *model = self.model.commentlist[indexPath.row];
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"PinglunTableViewCell") contentViewWidth:ScreenWidth] + 8;
    }else {
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *header = [self buildStickyHeaderIfNeeded];
        header.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 50.0);
        return header;
    }
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isPinglun) {
        
        PinglunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PinglunTableViewCell"];
        cell.model = self.model.commentlist[indexPath.row];
        return  cell;
    }
    DongtaiDetilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DongtaiDetilTableViewCell"];
    cell.model = self.model.zanlist[indexPath.row];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"空空如也";
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = RGBA(202, 202, 202, 1);
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return IMAGE_NAME(@"");
}





- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -49.0;
}

//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -49.0;
//}


#pragma mark - DZNEmptyDataSetDelegate Methods


@end
