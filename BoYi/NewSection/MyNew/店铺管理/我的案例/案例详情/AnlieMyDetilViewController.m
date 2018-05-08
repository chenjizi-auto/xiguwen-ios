//
//  AnlieMyDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/1/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AnlieMyDetilViewController.h"
#import "AddAnlieMyViewController.h"
#import "TZTestCell.h"
#import "MyAnLieVCModel.h"

@interface AnlieMyDetilViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UITextField *placeTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UITextView *describeTV;
@property (weak, nonatomic) IBOutlet UIView *container;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *mergeBtn;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation AnlieMyDetilViewController

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
		[_bottomView setBackgroundColor:[UIColor whiteColor]];
	}
	return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"案例详情";
    [self addPopBackBtn];
	
	// 图片集合
	[self.baseView addSubview: self.collectionView];
	self.collectionView.sd_layout
	.topSpaceToView(self.container, 10.0f)
	.leftSpaceToView(self.baseView, 10.0f)
	.rightSpaceToView(self.baseView, 10.0f)
	.heightIs(ScreenWidth/5*2+30);
	
	// 底部按钮
	[self.view addSubview:self.bottomView];
	self.bottomView.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(50.0f);
	[self.bottomView addSubview: self.editBtn];
	[self.bottomView addSubview: self.deleteBtn];
	[self.bottomView addSubview: self.mergeBtn];

	
	[self loadMainView];
    
    self.nameTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.weightTF.delegate = self;
    self.weightTF.inputAccessoryView = [self addToolbar];
    self.addressTF.delegate = self;
    self.addressTF.inputAccessoryView = [self addToolbar];
    self.typeTF.delegate = self;
    self.typeTF.inputAccessoryView = [self addToolbar];
    self.placeTF.delegate = self;
    self.placeTF.inputAccessoryView = [self addToolbar];
    self.weightTF.delegate = self;
    self.weightTF.inputAccessoryView = [self addToolbar];
    self.describeTV.delegate = self;
    self.describeTV.inputAccessoryView = [self addToolbar];
    
}

- (void)loadMainView {
	[self.nameTF setText: self.model.title];
	[self.timeLabel setText: self.model.weddingtime];
	[self.addressTF setText: self.model.weddingplace];
	[self.priceTF setText: [NSString stringWithFormat: @"%ld",self.model.weddingexpenses]];
	[self.typeTF setText: self.model.weddingtype];
	[self.placeTF setText:self.model.weddingenvironment];
	[self.weightTF setText:[NSString stringWithFormat:@"%ld",self.model.weigh]];
	[self.coverImageView sd_setImageWithUrl:self.model.weddingcover];
	[self.describeTV setText: self.model.weddingdescribe];
	
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

#pragma mark - 底部按钮点击事件
- (void)editBtnClick {
	// 编辑报价情况（跳转编辑）
	AddAnlieMyViewController *add = [[AddAnlieMyViewController alloc] init];
	add.model = self.model;
	add.isEdit = YES;
	[self.navigationController pushViewController:add animated:YES];
}

- (void)deleteBtnClick {
	// 删除报价
	[[RequestManager sharedManager] requestUrl:URL_deleteCases
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
		[[RequestManager sharedManager] requestUrl:URL_casesEditStatus
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
		[[RequestManager sharedManager] requestUrl:URL_casesFailure
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
}

@end
