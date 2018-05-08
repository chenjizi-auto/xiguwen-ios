//
//  DangqiKaViewController.m
//  BoYi
//
//  Created by heng on 2018/1/19.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "DangqiKaViewController.h"
#import "DangqinewCollectionViewCell.h"

@interface DangqiKaViewController () <UIWebViewDelegate> {
	NSString *url;
}
@property (nonatomic, strong) UIWebView *webView;
@property (strong,nonatomic) ShareNewmodel *sharemodel;
@end

@implementation DangqiKaViewController

#pragma mark - Setters and getters
- (UIWebView *)webView {
	if (!_webView) {
		_webView = [[UIWebView alloc] init];
		_webView.scalesPageToFit = YES;
		_webView.delegate = self;
	}
	return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"我的档期卡";
    [self addPopBackBtn];
    [self shareData];
	[self.view addSubview:self.webView];
	self.webView.sd_layout
	.topSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.bottomSpaceToView(self.view, 0.0f);
	
//    [self addCollectionView];
	
	[self addRightBtnWithTitle:@"" image: @"分享的副本"];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
//	self.navigationController.navigationBarHidden = YES;
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_scheduleCard
										method:POST
										loding:@""
										   dic:@{@"id":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: response[@"data"]]]];
										   url = response[@"data"];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
//	self.navigationController.navigationBarHidden = NO;
}

- (void)respondsToRightBtn {
	
    if (self.sharemodel) {
        [CwShareManager shareWebPageToPlatformWithUrl:self.sharemodel.url
                                                image:self.sharemodel.image
                                                title:self.sharemodel.title
                                                descr:self.sharemodel.descr
                                                   vc:self
                                           completion:^(id data, NSError *error) {
                                               
                                           }];
    }
	
}
- (void)shareData{
    NSDictionary *dic = @{@"id":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxiangdangqi"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.sharemodel = [ShareNewmodel mj_objectWithKeyValues:response[@"data"]];
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];
                                           
                                       }];
}
#pragma mark - webView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[NavigateManager hiddenLoadingMessage];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[NavigateManager showMessage:@"加载失败"];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[NavigateManager showLoadingMessage:@"正在加载..."];
}


/*
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        [self popViewConDelay];
    }else {
        //fenxiang
    }
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=20; //设置每一行的间距
    layout.itemSize=CGSizeMake(45, 45);  //设置每个单元格的大小
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerReferenceSize= CGSizeMake(self.view.frame.size.width -32, 47); //设置collectionView头视图的大小
    layout.footerReferenceSize= CGSizeMake(self.view.frame.size.width -32, 371); //
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(16, 205, ScreenWidth - 32, ScreenHeight - 205) collectionViewLayout:layout];
//    collectionView.frame = self.view.bounds;
    //注册cell单元格
    [collectionView registerNib:[UINib nibWithNibName:@"DangqinewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DangqinewCollectionViewCell"];
    //注册头视图
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewIdentifier"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerViewIdentifier"];
    
    
    collectionView.backgroundColor=[UIColor whiteColor];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    [self.view addSubview:collectionView];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return 18;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerViewIdentifier" forIndexPath:indexPath];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 32, 47)];
        UIView *viewgar = [[UIView alloc] initWithFrame:CGRectMake(0, 46, ScreenWidth - 32, 1)];
        viewgar.backgroundColor = RGBA(240, 240, 240, 1);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(4, 15, 59, 26)];
        label.font = [UIFont systemFontOfSize:16.f];
        label.textColor = MAINCOLOR;
        label.text = @"11月26日";
        [view addSubview:label];
        [view addSubview:viewgar];
        [header addSubview:view];
        return header;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 1) {
            
            UICollectionReusableView *headerview=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerViewIdentifier" forIndexPath:indexPath];
            
            DangqiFooterView *header = [[NSBundle mainBundle]loadNibNamed:@"DangqiFooterView" owner:nil options:nil].firstObject;
            // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
            header.frame = CGRectMake(0, 0, ScreenWidth, 371);
            [headerview addSubview:header];
            return headerview;
        }
    }
    return nil;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row > self.fuwuArray.count - 1) {
    //        return nil;
    //    }
    //重用cell
    DangqinewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DangqinewCollectionViewCell" forIndexPath:indexPath];
    //    cell.city.text = self.fuwuArray[indexPath.row];
    
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(45,45);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 0;
    
}
 */
 
@end
