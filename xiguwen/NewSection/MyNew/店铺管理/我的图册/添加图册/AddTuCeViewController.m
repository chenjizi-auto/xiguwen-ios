//
//  AddTuCeViewController.m
//  BoYi
//
//  Created by heng on 2018/1/19.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddTuCeViewController.h"
#import "MyTuceSubViewController.h"
#import "TZTestCell.h"

@interface AddTuCeViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;
@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@property (weak, nonatomic) IBOutlet UIView *container;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIImageView *coverImagewView;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation AddTuCeViewController

static const NSInteger kAddTuCeMaxImageCount = 9;
static const NSInteger kAddTuCeColumnCount = 3;
static const CGFloat kAddTuCeGridSpacing = 12.0f;
static const CGFloat kAddTuCeGridHorizontalInset = 16.0f;
static const CGFloat kAddTuCeSaveButtonHeight = 50.0f;

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
		_flowLayout.minimumLineSpacing = kAddTuCeGridSpacing;
		_flowLayout.minimumInteritemSpacing = kAddTuCeGridSpacing;
		_flowLayout.sectionInset = UIEdgeInsetsMake(10.0f, kAddTuCeGridHorizontalInset, 10.0f, kAddTuCeGridHorizontalInset);
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

- (UIImageView *)coverImagewView {
	if (!_coverImagewView) {
		_coverImagewView = [[UIImageView alloc] init];
		[_coverImagewView setUserInteractionEnabled: YES];
		_coverImagewView.contentMode = UIViewContentModeScaleAspectFill;
		_coverImagewView.layer.cornerRadius = 8.0f;
		_coverImagewView.layer.masksToBounds = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedCoverImage)];
		[_coverImagewView addGestureRecognizer:tap];
	}
	return _coverImagewView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加图册";
    [self addPopBackBtn];
	[self normalizeImageListIfNeeded];
	
	if (self.model) {
		[self.nameTF setText: self.model.name];
		[self.weightTF setText: [NSString stringWithFormat: @"%ld",(long)self.model.weight]];
		[self.coverImagewView setHidden: NO];
		[self.coverImagewView sd_setImageWithUrl:self.model.cover];
	} else {
		[self.coverImagewView setHidden: YES];
	}
    self.nameTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.weightTF.delegate = self;
    self.weightTF.inputAccessoryView = [self addToolbar];
	[self.container addSubview: self.coverImagewView];
	self.coverImagewView.sd_layout
	.centerYEqualToView(self.container)
	.rightSpaceToView(self.container, 30.0f)
	.widthIs(70.0f)
	.heightIs(70.0f);
	
	[self.view addSubview: self.saveBtn];
	self.saveBtn.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(kAddTuCeSaveButtonHeight);
	
	[self.baseView addSubview: self.collectionView];
	self.collectionView.sd_layout
	.topSpaceToView(self.container, 10.0f)
	.leftSpaceToView(self.baseView, 0.0f)
	.rightSpaceToView(self.baseView, 0.0f)
	.heightIs([self collectionViewHeight]);
    
    self.topInset.constant = 0.0f;
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	CGFloat bottomInset = [self cw_safeBottomInset];
	self.saveBtn.sd_layout.heightIs(kAddTuCeSaveButtonHeight);
	self.saveBtn.contentEdgeInsets = UIEdgeInsetsZero;
	[self.saveBtn updateLayout];
	[self updateCollectionLayoutWithBottomInset:bottomInset];
}

- (void)normalizeImageListIfNeeded {
	if (!self.model || !self.model.imglist) {
		return;
	}
	if (![self.model.imglist isKindOfClass:[NSMutableArray class]]) {
		self.model.imglist = [self.model.imglist mutableCopy];
	}
	if (self.model.imglist.count > kAddTuCeMaxImageCount) {
		self.model.imglist = [[self.model.imglist subarrayWithRange:NSMakeRange(0, kAddTuCeMaxImageCount)] mutableCopy];
	}
}

- (NSInteger)displayImageCount {
	return MIN(self.model.imglist.count, kAddTuCeMaxImageCount);
}

- (BOOL)shouldShowAddCell {
	return [self displayImageCount] < kAddTuCeMaxImageCount;
}

- (CGFloat)collectionItemWidth {
	CGFloat totalWidth = CGRectGetWidth(self.view.bounds) - self.flowLayout.sectionInset.left - self.flowLayout.sectionInset.right;
	CGFloat availableWidth = totalWidth - (kAddTuCeColumnCount - 1) * kAddTuCeGridSpacing;
	return floor(availableWidth / kAddTuCeColumnCount);
}

- (CGFloat)collectionViewHeight {
	NSInteger itemCount = [self collectionView:self.collectionView numberOfItemsInSection:0];
	NSInteger rows = MAX((NSInteger)ceil(itemCount / (CGFloat)kAddTuCeColumnCount), 1);
	CGFloat itemWidth = [self collectionItemWidth];
	return self.flowLayout.sectionInset.top + rows * itemWidth + (rows - 1) * kAddTuCeGridSpacing + self.flowLayout.sectionInset.bottom;
}

- (void)updateCollectionLayoutWithBottomInset:(CGFloat)bottomInset {
	CGFloat itemWidth = [self collectionItemWidth];
	self.flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
	self.collectionView.sd_layout.heightIs([self collectionViewHeight]);
	[self.collectionView updateLayout];
	UIEdgeInsets inset = self.collectionView.contentInset;
	inset.bottom = kAddTuCeSaveButtonHeight + bottomInset + 16.0f;
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
		self.model = [[MyTuceModel alloc] init];
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
				} else if (weakSelf.model.imglist.count < kAddTuCeMaxImageCount) {
					[weakSelf.model.imglist addObject:urlStr];
				}
				[weakSelf normalizeImageListIfNeeded];
				[weakSelf reloadCollectionViewLayout];
			}
		}];
	}];
}

#pragma mark - 更换图册封面
- (void)selectedCoverImage {
	if (self.model == nil) {
		self.model = [[MyTuceModel alloc] init];
		self.model.imglist = [[NSMutableArray alloc] init];
	} else if (![self.model.imglist isKindOfClass:[NSMutableArray class]]) {
		self.model.imglist = [self.model.imglist mutableCopy];
	}
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				self.model.cover = urlStr;
				[weakSelf.coverImagewView setHidden: NO];
				[weakSelf.coverImagewView setImage:image];
			}
		}];
	}];
}
- (IBAction)selectedCoverImage:(UIButton *)sender {
	if (self.model == nil) {
		self.model = [[MyTuceModel alloc] init];
		self.model.imglist = [[NSMutableArray alloc] init];
	} else if (![self.model.imglist isKindOfClass:[NSMutableArray class]]) {
		self.model.imglist = [self.model.imglist mutableCopy];
	}
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				self.model.cover = urlStr;
				[weakSelf.coverImagewView setHidden: NO];
				[weakSelf.coverImagewView setImage:image];
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
	
	if (self.weightTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入排序"];
		return;
	}
	
	if (self.coverImagewView.image == nil) {
		[NavigateManager showMessage: @"请选择图册封面"];
		return;
	}
	[self normalizeImageListIfNeeded];
    if (self.model.imglist.count == 0) {
        [NavigateManager showMessage: @"请添加图片"];
        return;
    }
    
	
	NSDictionary *dic;
	if (self.isEdit) {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"cover":self.model.cover,
				@"id":@(self.model.id),
				@"name":self.nameTF.text,
				@"photo":[self.model.imglist componentsJoinedByString:@","],
				@"photoid":self.model.imglist,
//				@"synopsis":self.model.synopsis,
				@"weight":self.weightTF.text};
	} else {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"cover":self.model.cover,
				@"name":self.nameTF.text,
				@"photo":[self.model.imglist componentsJoinedByString:@","],
//				@"synopsis":self.model.synopsis,
				@"weight":self.weightTF.text};
	}
	
	// 提交审核
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:self.isEdit ? URL_editTuce : URL_addTuce
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
	MyTuceSubViewController *jumpVC = nil;
	for (NSInteger i = 0; i < self.navigationController.viewControllers.count;  i ++) {
		WMPageController *vc = self.navigationController.viewControllers[i];
		if ([vc isKindOfClass:[MyTuceSubViewController class]]) {
			jumpVC = (MyTuceSubViewController *)vc;
			break;
		}
	}
	[self.navigationController popToViewController:jumpVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
