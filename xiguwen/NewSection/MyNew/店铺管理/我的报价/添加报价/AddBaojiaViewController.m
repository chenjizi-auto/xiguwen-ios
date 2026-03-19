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
#import "ZLTextView.h"

@interface AddBaojiaViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;

@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *depositTF;
@property (weak, nonatomic) IBOutlet UITextField *couponTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *remarksSuperView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) NSString *remarks;

@end

@implementation AddBaojiaViewController

static const NSInteger kAddBaojiaMaxImageCount = 9;
static const NSInteger kAddBaojiaColumnCount = 3;
static const CGFloat kAddBaojiaGridSpacing = 12.0f;
static const CGFloat kAddBaojiaGridHorizontalInset = 16.0f;
static const CGFloat kAddBaojiaSaveButtonHeight = 50.0f;

- (CGFloat)cw_safeBottomInset {
	if (@available(iOS 11.0, *)) {
		return self.view.safeAreaInsets.bottom;
	}
	return 0.0f;
}

- (UIButton *)saveBtn {
	if (!_saveBtn) {
		_saveBtn = [[UIButton alloc] init];
		[_saveBtn setTitle: @"保存" forState:(UIControlStateNormal)];
		[_saveBtn setBackgroundColor:UIColorFromRGB(0xFFBF56)];
		[_saveBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
		_saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
		[_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _saveBtn;
}

- (UICollectionViewFlowLayout *)flowLayout {
	if (!_flowLayout) {
		_flowLayout = [[UICollectionViewFlowLayout alloc] init];
		_flowLayout.minimumLineSpacing = kAddBaojiaGridSpacing;
		_flowLayout.minimumInteritemSpacing = kAddBaojiaGridSpacing;
		_flowLayout.sectionInset = UIEdgeInsetsMake(10.0f, kAddBaojiaGridHorizontalInset, 10.0f, kAddBaojiaGridHorizontalInset);
	}
	return _flowLayout;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
		_collectionView.backgroundColor = [UIColor whiteColor];
		// 注册cell
		[_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"cell"];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.scrollEnabled = NO;
	}
	return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加报价";
    [self addPopBackBtn];
	[self normalizeImageListIfNeeded];
	
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
	.heightIs(kAddBaojiaSaveButtonHeight);
	
	[self.baseView addSubview: self.collectionView];
	self.collectionView.sd_layout
	.topSpaceToView(self.container, 10.0f + 150)
	.leftSpaceToView(self.baseView, 0.0f)
	.rightSpaceToView(self.baseView, 0.0f)
	.heightIs([self collectionViewHeight]);
    
    WeakSelf(self);
    ZLTextView *aTextView = [[ZLTextView alloc] initWithFrame:CGRectMake(15, 10, UIScreen.mainScreen.bounds.size.width - 15 * 2, 130)];
    aTextView.layer.borderWidth = 1.0;
    aTextView.layer.cornerRadius = 10;
    aTextView.layer.masksToBounds = true;
    aTextView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    aTextView.placeholder = @"请输入充值备注~（选填）";
    aTextView.change = ^(NSString *str){
        weakSelf.remarks = str;
    };
    if (self.model) {
        [aTextView setText: self.model.miaoshu];
    }
    [self.remarksSuperView addSubview:aTextView];

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
    
    self.topInset.constant = 0.0f;
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	self.saveBtn.sd_layout.heightIs(kAddBaojiaSaveButtonHeight);
	[self.saveBtn updateLayout];
	[self updateCollectionLayoutWithBottomInset:[self cw_safeBottomInset]];
}

- (void)normalizeImageListIfNeeded {
	if (!self.model || !self.model.imglist) {
		return;
	}
	if (![self.model.imglist isKindOfClass:[NSMutableArray class]]) {
		self.model.imglist = [self.model.imglist mutableCopy];
	}
	if (self.model.imglist.count > kAddBaojiaMaxImageCount) {
		self.model.imglist = [[self.model.imglist subarrayWithRange:NSMakeRange(0, kAddBaojiaMaxImageCount)] mutableCopy];
	}
}

- (NSInteger)displayImageCount {
	return MIN(self.model.imglist.count, kAddBaojiaMaxImageCount);
}

- (BOOL)shouldShowAddCell {
	return [self displayImageCount] < kAddBaojiaMaxImageCount;
}

- (CGFloat)collectionItemWidth {
	CGFloat totalWidth = CGRectGetWidth(self.view.bounds) - self.flowLayout.sectionInset.left - self.flowLayout.sectionInset.right;
	CGFloat availableWidth = totalWidth - (kAddBaojiaColumnCount - 1) * kAddBaojiaGridSpacing;
	return floor(availableWidth / kAddBaojiaColumnCount);
}

- (CGFloat)collectionViewHeight {
	NSInteger itemCount = [self collectionView:self.collectionView numberOfItemsInSection:0];
	NSInteger rows = MAX((NSInteger)ceil(itemCount / (CGFloat)kAddBaojiaColumnCount), 1);
	CGFloat itemWidth = [self collectionItemWidth];
	return self.flowLayout.sectionInset.top + rows * itemWidth + (rows - 1) * kAddBaojiaGridSpacing + self.flowLayout.sectionInset.bottom;
}

- (void)updateCollectionLayoutWithBottomInset:(CGFloat)bottomInset {
	CGFloat itemWidth = [self collectionItemWidth];
	self.flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
	self.collectionView.sd_layout.heightIs([self collectionViewHeight]);
	[self.collectionView updateLayout];
	UIEdgeInsets inset = self.collectionView.contentInset;
	inset.bottom = kAddBaojiaSaveButtonHeight + bottomInset + 16.0f;
	self.collectionView.contentInset = inset;
	self.collectionView.scrollIndicatorInsets = inset;
}

- (void)reloadCollectionViewLayout {
	[self updateCollectionLayoutWithBottomInset:[self cw_safeBottomInset]];
	[self.collectionView.collectionViewLayout invalidateLayout];
	[self.collectionView reloadData];
	[self.view layoutIfNeeded];
}

#pragma mark - UICollectionView delegate & datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSInteger imageCount = [self displayImageCount];
	if (imageCount == 0) {
		return 1;
	}
	return imageCount + ([self shouldShowAddCell] ? 1 : 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	cell.imageView.layer.cornerRadius = 8.0f;
	cell.imageView.layer.masksToBounds = YES;
	cell.imageView.layer.borderWidth = 1.0f;
	cell.imageView.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
	cell.deleteBtn.hidden = YES;
	[cell.deleteBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
	NSInteger imageCount = [self displayImageCount];
	BOOL isImageCell = indexPath.row < imageCount;
	if (!isImageCell) {
		cell.imageView.image = [UIImage imageNamed: @"上传图片"];
		cell.imageView.contentMode = UIViewContentModeCenter;
		cell.imageView.backgroundColor = UIColorFromRGB(0xFAFAFA);
	} else {
		cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
		cell.imageView.backgroundColor = UIColor.clearColor;
		[cell.imageView sd_setImageWithUrl:self.model.imglist[indexPath.row]];
		cell.deleteBtn.hidden = NO;
		cell.deleteBtn.tag = indexPath.row;
		[cell.deleteBtn addTarget:self action:@selector(deleteImg:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	
	return cell;
}

- (void)deleteImg:(UIButton *)sender {
	// 删除图片
	if (sender.tag < self.model.imglist.count) {
		[self.model.imglist removeObjectAtIndex:sender.tag];
	}
	[self reloadCollectionViewLayout];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	// 更换照片
	WeakSelf(self);
	
	if (self.model == nil) {
		self.model = [[MyBaoJiaModel alloc] init];
		self.model.imglist = [[NSMutableArray alloc] init];
	} else if (![self.model.imglist isKindOfClass:[NSMutableArray class]]) {
		self.model.imglist = [self.model.imglist mutableCopy];
	}
	
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				// 非最后一个实行替换（最后一个实行添加）
				if (weakSelf.model.imglist.count == 0) {
					[weakSelf.model.imglist addObject:urlStr];
				} else if (indexPath.row < [weakSelf displayImageCount]) {
					[weakSelf.model.imglist replaceObjectAtIndex:indexPath.row withObject:urlStr];
				} else if (weakSelf.model.imglist.count < kAddBaojiaMaxImageCount) {
					[weakSelf.model.imglist addObject:urlStr];
				}
				[weakSelf normalizeImageListIfNeeded];
				[weakSelf reloadCollectionViewLayout];
			}
		}];
	}];
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
	[self normalizeImageListIfNeeded];
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
                @"miaoshu":self.remarks.length > 0 ? self.remarks : @"",
				@"shopimg":[self.model.imglist componentsJoinedByString:@","],
				@"quotationid":@(self.model.quotationid)};
	} else {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"shopname":self.nameTF.text,
				@"price":self.priceTF.text,
				@"temporarypay":self.depositTF.text,
				@"coupons_price":self.couponTF.text,
                @"miaoshu":self.remarks.length > 0 ? self.remarks : @"",
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
