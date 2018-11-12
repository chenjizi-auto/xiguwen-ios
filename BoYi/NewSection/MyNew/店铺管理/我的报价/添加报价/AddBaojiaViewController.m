//
//  AddBaojiaViewController.m
//  BoYi
//
//  Created by heng on 2018/1/19.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddBaojiaViewController.h"
#import "MybaojiaSubViewController.h"
#import "TZTestCell.h"

@interface AddBaojiaViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *depositTF;
@property (weak, nonatomic) IBOutlet UITextField *couponTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UIView *container;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation AddBaojiaViewController

- (UIButton *)saveBtn {
	if (!_saveBtn) {
		_saveBtn = [[UIButton alloc] init];
		[_saveBtn setTitle: @"保存" forState:(UIControlStateNormal)];
		[_saveBtn setBackgroundColor:UIColorFromRGB(0xFFBF56)];
		[_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _saveBtn;
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的报价";
    [self addPopBackBtn];
	
	if (self.model) {
		[self.nameTF setText: self.model.name];
		[self.priceTF setText: self.model.price];
		[self.depositTF setText: self.model.temporarypay];
		[self.couponTF setText: self.model.deductible];
		[self.weightTF setText: [NSString stringWithFormat: @"%ld",(long)self.model.weigh]];
	}
	
	[self.view addSubview: self.saveBtn];
	self.saveBtn.sd_layout
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

    self.nameTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.priceTF.delegate = self;
    self.priceTF.inputAccessoryView = [self addToolbar];
    self.depositTF.delegate = self;
    self.depositTF.inputAccessoryView = [self addToolbar];
    self.couponTF.delegate = self;
    self.couponTF.inputAccessoryView = [self addToolbar];
    self.weightTF.delegate = self;
    self.weightTF.inputAccessoryView = [self addToolbar];
    
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}

#pragma mark - UICollectionView delegate & datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.model.imglist.count + (self.model.imglist.count >= 8 ? 0 : 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	// 判断是否是最后一张占位图片
	if (self.model.imglist.count <= 0) {
		cell.imageView.image = [UIImage imageNamed: @"上传图片"];
		cell.deleteBtn.hidden = YES;
	} else {
		if (indexPath.row <= self.model.imglist.count - 1) {
			[cell.imageView sd_setImageWithUrl:self.model.imglist[indexPath.row]];
			cell.deleteBtn.hidden = NO;
			cell.deleteBtn.tag = indexPath.row;
			[cell.deleteBtn addTarget:self action:@selector(deleteImg:) forControlEvents:(UIControlEventTouchUpInside)];
		} else {
			cell.imageView.image = [UIImage imageNamed: @"上传图片"];
			cell.deleteBtn.hidden = YES;
		}
	}
	
	return cell;
}

- (void)deleteImg:(UIButton *)sender {
	// 删除图片
	[self.model.imglist removeObjectAtIndex:sender.tag];
	[self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	// 更换照片
	WeakSelf(self);
	
	if (self.model == nil) {
		self.model = [[MyBaoJiaModel alloc] init];
		self.model.imglist = [[NSMutableArray alloc] init];
	}
	
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				// 非最后一个实行替换（最后一个实行添加）
				if (weakSelf.model.imglist.count == 0) {
					weakSelf.model.imglist = [[NSMutableArray alloc] init];
					[weakSelf.model.imglist addObject:urlStr];
				} else {
					if (indexPath.row <= self.model.imglist.count - 1) {
						[weakSelf.model.imglist replaceObjectAtIndex:indexPath.row withObject:urlStr];
					} else {
						[weakSelf.model.imglist addObject:urlStr];
					}
				}
				
				[weakSelf.collectionView reloadData];
			}
		}];
	}];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(5.0f, 10.0f, 5.0f, 10.0f);
}

- (void)saveBtnClick {
	// 保存添加报价
	if (self.nameTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入名称"];
		return;
	}
	
	if (self.priceTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入价格"];
		return;
	}
	
	if (self.depositTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入金额"];
		return;
	}
	
	if (self.couponTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入折扣券金额"];
		return;
	}
	
	if (self.weightTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入排序"];
		return;
	}
    if (self.model.imglist.count == 0) {
        [NavigateManager showMessage: @"请选择图片"];
        return;
    }
	
	NSDictionary *dic;
	if (self.isEdit) {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"shopname":self.nameTF.text,
				@"price":self.priceTF.text,
				@"temporarypay":self.depositTF.text,
				@"coupons_price":self.couponTF.text,
				@"weigh":self.weightTF.text,
				@"shopimg":[self.model.imglist componentsJoinedByString:@","],
				@"quotationid":@(self.model.quotationid)};
	} else {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"shopname":self.nameTF.text,
				@"price":self.priceTF.text,
				@"temporarypay":self.depositTF.text,
				@"coupons_price":self.couponTF.text,
				@"shopimg":[self.model.imglist componentsJoinedByString:@","],
				@"weigh":self.weightTF.text};
	}
	
	// 提交审核
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:self.isEdit ? URL_editOffer : URL_addOffer
										method:POST loding:@""
										   dic:dic
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"提交成功"];
											   [weakSelf jump];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"提交失败"];
									   }];
}

- (void)jump {
	MybaojiaSubViewController *jumpVC = nil;
	for (NSInteger i = 0; i < self.navigationController.viewControllers.count;  i ++) {
		WMPageController *vc = self.navigationController.viewControllers[i];
		if ([vc isKindOfClass:[MybaojiaSubViewController class]]) {
			jumpVC = (MybaojiaSubViewController *)vc;
			break;
		}
	}
	[self.navigationController popToViewController:jumpVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
