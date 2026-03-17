//
//  TuCeDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/1/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "TuCeDetilViewController.h"
#import "AddTuCeViewController.h"
#import "TZTestCell.h"
#import "MyTuceModel.h"

@interface TuCeDetilViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIView *container;

@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *mergeBtn;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


@end

@implementation TuCeDetilViewController

#pragma mark - Setters and getters
- (UICollectionViewFlowLayout *)flowLayout {
	if (!_flowLayout) {
		_flowLayout = [[UICollectionViewFlowLayout alloc] init];
		_flowLayout.itemSize = CGSizeMake(ScreenWidth/5, ScreenWidth/5);
	}
	return _flowLayout;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWidth, 150.0f) collectionViewLayout:self.flowLayout];
		_collectionView.backgroundColor = [UIColor whiteColor];
		// 注册cell
		[_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"cell"];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
	}
	return _collectionView;
}

- (UIButton *)editBtn {
	if (!_editBtn) {
		_editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
		[_editBtn setImage:[UIImage imageNamed: @"编辑-报价"] forState:(UIControlStateNormal)];
		[_editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _editBtn;
}

- (UIButton *)deleteBtn {
	if (!_deleteBtn) {
		_deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
		[_deleteBtn setImage:[UIImage imageNamed: @"删除字"] forState:(UIControlStateNormal)];
		[_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _deleteBtn;
}

- (UIButton *)mergeBtn {
	if (!_mergeBtn) {
		_mergeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
		[_mergeBtn addTarget:self action:@selector(mergeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _mergeBtn;
}

- (UIView *)bottomView {
	if (!_bottomView) {
		_bottomView = [[UIView alloc] init];
	}
	return _bottomView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图册详情";
    [self addPopBackBtn];
	
	[self.view addSubview:self.bottomView];
	self.bottomView.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(50.0f);
	
	[self.baseView addSubview: self.collectionView];
	self.collectionView.sd_layout
	.topSpaceToView(self.container, 10.0f)
	.leftSpaceToView(self.baseView, 0.0f)
	.rightSpaceToView(self.baseView, 0.0f)
	.heightIs(ScreenWidth/5*2+30);
	
	// 添加底部按钮
	[self.bottomView addSubview: self.editBtn];
	[self.bottomView addSubview: self.deleteBtn];
	[self.bottomView addSubview: self.mergeBtn];
	
	[self loadMainView];
    self.nameTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.weightTF.delegate = self;
    self.weightTF.inputAccessoryView = [self addToolbar];
}

- (void)loadMainView {
	[self.nameTF setText: self.model.name];
	[self.weightTF setText: [NSString stringWithFormat: @"%ld",self.model.weight]];
	[self.coverImageView sd_setImageWithUrl:self.model.cover];
	
	[self.editBtn setHidden: NO];
	[self.deleteBtn setHidden: NO];
	[self.mergeBtn setHidden: NO];
	
	if (self.model.status == 4) {
		// 待提交
		[self.editBtn setCenter:CGPointMake(ScreenWidth/6, 25.0f)];
		[self.deleteBtn setCenter:CGPointMake(ScreenWidth/2, 25.0f)];
		[self.mergeBtn setCenter:CGPointMake(ScreenWidth/6*5, 25.0f)];
		[self.mergeBtn setImage:[UIImage imageNamed: @"提交审核-报价"] forState:(UIControlStateNormal)];
	} else
	if (self.model.status == 1) {
		// 审核中
		[self.editBtn setCenter:CGPointMake(ScreenWidth/4, 25.0f)];
		[self.deleteBtn setCenter:CGPointMake(ScreenWidth/4*3, 25.0f)];
		[self.mergeBtn setHidden: YES];
	} else if (self.model.status == 2) {
		// 已通过（分两种状态）
		if (self.model.putaway == 0) {
			// 下架状态（显示上架按钮）
			[self.editBtn setCenter:CGPointMake(ScreenWidth/6, 25.0f)];
			[self.deleteBtn setCenter:CGPointMake(ScreenWidth/2, 25.0f)];
			[self.mergeBtn setCenter:CGPointMake(ScreenWidth/6*5, 25.0f)];
			[self.mergeBtn setImage:[UIImage imageNamed: @"上架-报价"] forState:(UIControlStateNormal)];
		} else {
			// 上架状态（显示下架按钮）
			[self.editBtn setHidden: YES];
			[self.deleteBtn setHidden: YES];
			[self.mergeBtn setCenter:CGPointMake(ScreenWidth/2, 25.0f)];
			[self.mergeBtn setImage:[UIImage imageNamed: @"下架"] forState:(UIControlStateNormal)];
		}
	} else if (self.model.status == 3) {
		// 未通过
		[self.editBtn setCenter:CGPointMake(ScreenWidth/6, 25.0f)];
		[self.deleteBtn setCenter:CGPointMake(ScreenWidth/2, 25.0f)];
		[self.mergeBtn setCenter:CGPointMake(ScreenWidth/6*5, 25.0f)];
		[self.mergeBtn setImage:[UIImage imageNamed: @"查看原因-报价"] forState:(UIControlStateNormal)];
	}
}

#pragma mark - UICollectionView delegate & datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.model.imglist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	[cell.imageView sd_setImageWithUrl:self.model.imglist[indexPath.row]];
	cell.deleteBtn.hidden = YES;
	
	return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(5.0f, 10.0f, 5.0f, 10.0f);
}

#pragma mark - 底部按钮
- (void)editBtnClick {
	// 编辑报价情况（跳转编辑）
	AddTuCeViewController *add = [[AddTuCeViewController alloc] init];
	add.model = self.model;
	add.isEdit = YES;
	[self.navigationController pushViewController:add animated:YES];
}

- (void)deleteBtnClick {
	// 删除报价
	[[RequestManager sharedManager] requestUrl:URL_deleteAtlas
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"id":@(self.model.id),
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"删除成功"];
											   [self popViewConDelay];;
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"删除失败"];
									   }];
}

- (void)mergeBtnClick {
	WeakSelf(self);
	// 合并多功能按钮
	if (self.model.status == 2) {
		// 上下架
		self.model.putaway = self.model.putaway == 0 ? 1 : 0;
		[[RequestManager sharedManager] requestUrl:URL_editAtlasStatus
											method:POST loding:@""
											   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"id":@(self.model.id),
													 @"status":@(self.model.putaway),
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   if ([response[@"code"] integerValue] == 0) {
												   [NavigateManager showMessage: self.model.status == 0 ? @"下架成功" : @"上架成功"];
												   [weakSelf loadMainView];
											   } else {
												   [NavigateManager showMessage: response[@"message"]];
											   }
										   } failure:^(NSURLSessionDataTask *task, NSError *error) {
											   [NavigateManager showMessage:@"请求失败"];
										   }];
	} else if (self.model.status == 3) {
		// 查看未通过原因
		[[RequestManager sharedManager] requestUrl:URL_checkAtlasReason
											method:POST
											loding:@""
											   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
													 @"id":@(self.model.id),
													 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
										  progress:nil
										   success:^(NSURLSessionDataTask *task, id response) {
											   // 弹窗提示
											   [weakSelf alertView:response[@"data"]];
										   }
										   failure:^(NSURLSessionDataTask *task, NSError *error) {
											   
										   }];
	}
}

- (void)alertView:(NSString *)message {
	UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
	UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		// 取消弹窗
	}];
	[alertC addAction:sureAction];
	[self presentViewController:alertC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
