//
//  AddMyGoodsViewController.m
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddMyGoodsViewController.h"
#import "MyGoodsListViewController.h"
#import "TZTestCell.h"
#import "AttributeSettingViewController.h"
#import "StockSettingViewController.h"
#import "MOFSPickerManager.h"

@interface AddMyGoodsViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
	NSInteger pid;// 上一级id
}

@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *subclassArray;
@property (nonatomic, strong) NSMutableArray *templateArray;
@property (nonatomic, strong) NSMutableArray *regionalArray;

@property (nonatomic, strong) UIScrollView *scrollView;
// 输入模块
@property (nonatomic, strong) UIButton *categoryBtn;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UIButton *subclassBtn;
@property (nonatomic, strong) UILabel *subclassLabel;

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *unitTF;
@property (nonatomic, strong) UITextField *couponTF;
@property (nonatomic, strong) UITextField *sortingTF;

@property (nonatomic, strong) UIButton *templateBtn;
@property (nonatomic, strong) UILabel *templateLabel;
@property (nonatomic, strong) UIButton *regionalBtn;
@property (nonatomic, strong) UILabel *regionalLabel;
// 传图模块
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
// 底部按钮模块
@property (nonatomic, strong) UIButton *attributeBtn;
@property (nonatomic, strong) UIButton *stockBtn;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation AddMyGoodsViewController

- (NSMutableArray *)categoryArray {
	if (!_categoryArray) {
		_categoryArray = [[NSMutableArray alloc] init];
	}
	return _categoryArray;
}
- (NSMutableArray *)subclassArray {
	if (!_subclassArray) {
		_subclassArray = [[NSMutableArray alloc] init];
	}
	return _subclassArray;
}
- (NSMutableArray *)templateArray {
	if (!_templateArray) {
		_templateArray = [[NSMutableArray alloc] init];
	}
	return _templateArray;
}
- (NSMutableArray *)regionalArray {
	if (!_regionalArray) {
		_regionalArray = [[NSMutableArray alloc] init];
	}
	return _regionalArray;
}

#pragma mark - Setters and getters
- (UIScrollView *)scrollView {
	if (!_scrollView) {
		_scrollView = [[UIScrollView alloc] init];
	}
	return _scrollView;
}
- (UIButton *)categoryBtn {
	if (!_categoryBtn) {
		_categoryBtn = [[UIButton alloc] init];
		[_categoryBtn addTarget:self action:@selector(categoryBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _categoryBtn;
}
- (UILabel *)categoryLabel {
	if (!_categoryLabel) {
		_categoryLabel = [[UILabel alloc] init];
		[_categoryLabel setTextColor:UIColorFromRGB(0x898989)];
		[_categoryLabel setFont:[UIFont systemFontOfSize:15.0f]];
		[_categoryLabel setTextAlignment:NSTextAlignmentRight];
	}
	return _categoryLabel;
}
- (UIButton *)subclassBtn {
	if (!_subclassBtn) {
		_subclassBtn = [[UIButton alloc] init];
		[_subclassBtn addTarget:self action:@selector(subclassBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _subclassBtn;
}
- (UILabel *)subclassLabel {
	if (!_subclassLabel) {
		_subclassLabel = [[UILabel alloc] init];
		[_subclassLabel setTextColor:UIColorFromRGB(0x898989)];
		[_subclassLabel setFont:[UIFont systemFontOfSize:15.0f]];
		[_subclassLabel setTextAlignment:NSTextAlignmentRight];
	}
	return _subclassLabel;
}

- (UITextField *)nameTF {
	if (!_nameTF) {
		_nameTF = [[UITextField alloc] init];
		[_nameTF setPlaceholder: @"请输入商品名称"];
		[_nameTF setTextAlignment:(NSTextAlignment)NSTextAlignmentRight];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"商品名称";
		label.font = [UIFont systemFontOfSize:16.0f];
		_nameTF.leftView = label;
		_nameTF.leftViewMode = UITextFieldViewModeAlways;
	}
	return _nameTF;
}
- (UITextField *)unitTF {
	if (!_unitTF) {
		_unitTF = [[UITextField alloc] init];
		[_unitTF setPlaceholder: @"请输入单位"];
		[_unitTF setTextAlignment:(NSTextAlignment)NSTextAlignmentRight];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"商品单位";
		label.font = [UIFont systemFontOfSize:16.0f];
		_unitTF.leftView = label;
		_unitTF.leftViewMode = UITextFieldViewModeAlways;
	}
	return _unitTF;
}
- (UITextField *)couponTF {
	if (!_couponTF) {
		_couponTF = [[UITextField alloc] init];
		[_couponTF setPlaceholder: @"请输入可抵扣金额"];
		[_couponTF setTextAlignment:(NSTextAlignment)NSTextAlignmentRight];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"现金券抵扣";
		label.font = [UIFont systemFontOfSize:16.0f];
		_couponTF.leftView = label;
		_couponTF.leftViewMode = UITextFieldViewModeAlways;
	}
	return _couponTF;
}
- (UITextField *)sortingTF {
	if (!_sortingTF) {
		_sortingTF = [[UITextField alloc] init];
		[_sortingTF setPlaceholder: @"请输入排序"];
		[_sortingTF setTextAlignment:(NSTextAlignment)NSTextAlignmentRight];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 16.0f, 90.0f, 20.0f)];
		label.text = @"商品排序";
		label.font = [UIFont systemFontOfSize:16.0f];
		_sortingTF.leftView = label;
		_sortingTF.leftViewMode = UITextFieldViewModeAlways;
	}
	return _sortingTF;
}

- (UIButton *)templateBtn {
	if (!_templateBtn) {
		_templateBtn = [[UIButton alloc] init];
		[_templateBtn addTarget:self action:@selector(templateBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _templateBtn;
}
- (UILabel *)templateLabel {
	if (!_templateLabel) {
		_templateLabel = [[UILabel alloc] init];
		[_templateLabel setTextColor:UIColorFromRGB(0x898989)];
		[_templateLabel setFont:[UIFont systemFontOfSize:15.0f]];
		[_templateLabel setTextAlignment:NSTextAlignmentRight];
	}
	return _templateLabel;
}
- (UIButton *)regionalBtn {
	if (!_regionalBtn) {
		_regionalBtn = [[UIButton alloc] init];
		[_regionalBtn addTarget:self action:@selector(regionalBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _regionalBtn;
}
- (UILabel *)regionalLabel {
	if (!_regionalLabel) {
		_regionalLabel = [[UILabel alloc] init];
		[_regionalLabel setTextColor:UIColorFromRGB(0x898989)];
		[_regionalLabel setFont:[UIFont systemFontOfSize:15.0f]];
		[_regionalLabel setTextAlignment:NSTextAlignmentRight];
	}
	return _regionalLabel;
}

- (UICollectionViewFlowLayout *)layout {
	if (!_layout) {
		_layout = [[UICollectionViewFlowLayout alloc] init];
		_layout.itemSize = CGSizeMake(ScreenWidth/5, ScreenWidth/5);
	}
	return _layout;
}
- (UICollectionView *)collection {
	if (!_collection) {
		_collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWidth, 150.0f) collectionViewLayout:self.layout];
		_collection.backgroundColor = [UIColor whiteColor];
		// 注册cell
		[_collection registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"cell"];
		_collection.delegate = self;
		_collection.dataSource = self;
	}
	return _collection;
}

- (UIButton *)attributeBtn {
	if (!_attributeBtn) {
		_attributeBtn = [[UIButton alloc] init];
		[_attributeBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
		[_attributeBtn setTitle:@"属性设置" forState:(UIControlStateNormal)];
		[_attributeBtn addTarget:self action:@selector(attributeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _attributeBtn;
}
- (UIButton *)stockBtn {
	if (!_stockBtn) {
		_stockBtn = [[UIButton alloc] init];
		[_stockBtn setBackgroundColor:UIColorFromRGB(0xFF5E5E)];
		[_stockBtn setTitle:@"库存设置" forState:(UIControlStateNormal)];
		[_stockBtn addTarget:self action:@selector(stockBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _stockBtn;
}
- (UIButton *)saveBtn {
	if (!_saveBtn) {
		_saveBtn = [[UIButton alloc] init];
		[_saveBtn setBackgroundColor:UIColorFromRGB(0xFFBF56)];
		[_saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
		[_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _saveBtn;
}

#pragma mark - viewLoad
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	self.navigationItem.title = @"添加商品";
	[self addPopBackBtn];
	
	[self.view addSubview:self.scrollView];
	self.scrollView.sd_layout
	.topSpaceToView(self.view, 64.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.bottomSpaceToView(self.view, 50.0f);
	[self.scrollView setContentSize:CGSizeMake(ScreenWidth, 400+170)];
	
	// 添加头部输入
	[self loadHeader];
	// 添加中间图片输入
	[self loadBody];
	// 添加底部视图
	[self loadBottom];
}

- (void)loadHeader {
	// 商品类目
	UILabel *oneLabel = [[UILabel alloc] init];
	[oneLabel setText:@"商品类目"];
	[oneLabel setFont:[UIFont systemFontOfSize:16.0f]];
	[self.scrollView addSubview: oneLabel];
	oneLabel.sd_layout
	.topSpaceToView(self.scrollView, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.widthIs(90.0f)
	.heightIs(50.0f);
	
	[self.scrollView addSubview: self.categoryBtn];
	self.categoryBtn.sd_layout
	.centerYEqualToView(oneLabel)
	.leftSpaceToView(oneLabel, 10.0f)
	.rightSpaceToView(self.scrollView, 0.0f)
	.heightIs(50.0f);
	
	UIImageView *oneImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"进入 收货地址"]];
	[self.categoryBtn addSubview: oneImg];
	oneImg.sd_layout
	.centerYEqualToView(self.categoryBtn)
	.rightSpaceToView(self.categoryBtn, 10.0f)
	.widthIs(10.0f)
	.heightIs(15.0f);
	
	[self.categoryBtn addSubview: self.categoryLabel];
	self.categoryLabel.sd_layout
	.centerYEqualToView(self.categoryBtn)
	.leftSpaceToView(self.categoryBtn, 5.0f)
	.rightSpaceToView(oneImg, 15.0f)
	.heightIs(20.0f);
	
	// 商品子类
	UILabel *twoLabel = [[UILabel alloc] init];
	[twoLabel setText:@"商品子类"];
	[twoLabel setFont:[UIFont systemFontOfSize:16.0f]];
	[self.scrollView addSubview: twoLabel];
	twoLabel.sd_layout
	.topSpaceToView(oneLabel, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.widthIs(90.0f)
	.heightIs(50.0f);
	
	[self.scrollView addSubview: self.subclassBtn];
	self.subclassBtn.sd_layout
	.centerYEqualToView(twoLabel)
	.leftSpaceToView(twoLabel, 10.0f)
	.rightSpaceToView(self.scrollView, 0.0f)
	.heightIs(50.0f);
	
	UIImageView *twoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"进入 收货地址"]];
	[self.subclassBtn addSubview: twoImg];
	twoImg.sd_layout
	.centerYEqualToView(self.subclassBtn)
	.rightSpaceToView(self.subclassBtn, 10.0f)
	.widthIs(10.0f)
	.heightIs(15.0f);
	
	[self.subclassBtn addSubview: self.subclassLabel];
	self.subclassLabel.sd_layout
	.centerYEqualToView(self.subclassBtn)
	.leftSpaceToView(self.subclassBtn, 5.0f)
	.rightSpaceToView(twoImg, 15.0f)
	.heightIs(20.0f);
	
	// 商品名称
	[self.scrollView addSubview:self.nameTF];
	self.nameTF.sd_layout
	.topSpaceToView(twoLabel, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 15.0f)
	.heightIs(50.0f);
	
	// 商品单位
	[self.scrollView addSubview:self.unitTF];
	self.unitTF.sd_layout
	.topSpaceToView(self.nameTF, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 15.0f)
	.heightIs(50.0f);
	
	// 现金券抵扣
	[self.scrollView addSubview: self.couponTF];
	self.couponTF.sd_layout
	.topSpaceToView(self.unitTF, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 15.0f)
	.heightIs(50.0f);
	
	// 商品排序
	[self.scrollView addSubview: self.sortingTF];
	self.sortingTF.sd_layout
	.topSpaceToView(self.couponTF, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.rightSpaceToView(self.scrollView, 15.0f)
	.heightIs(50.0f);
	
	// 运费模版
	UILabel *threeLabel = [[UILabel alloc] init];
	[threeLabel setText:@"运费模版"];
	[threeLabel setFont:[UIFont systemFontOfSize:16.0f]];
	[self.scrollView addSubview: threeLabel];
	threeLabel.sd_layout
	.topSpaceToView(self.sortingTF, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.widthIs(90.0f)
	.heightIs(50.0f);
	
	[self.scrollView addSubview: self.templateBtn];
	self.templateBtn.sd_layout
	.centerYEqualToView(threeLabel)
	.leftSpaceToView(threeLabel, 10.0f)
	.rightSpaceToView(self.scrollView, 0.0f)
	.heightIs(50.0f);
	
	UIImageView *threeImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"进入 收货地址"]];
	[self.templateBtn addSubview: threeImg];
	threeImg.sd_layout
	.centerYEqualToView(self.templateBtn)
	.rightSpaceToView(self.templateBtn, 10.0f)
	.widthIs(10.0f)
	.heightIs(15.0f);
	
	[self.templateBtn addSubview: self.templateLabel];
	self.templateLabel.sd_layout
	.centerYEqualToView(self.templateBtn)
	.leftSpaceToView(self.templateBtn, 5.0f)
	.rightSpaceToView(threeImg, 15.0f)
	.heightIs(20.0f);
	
	// 商品地区
	UILabel *fourLabel = [[UILabel alloc] init];
	[fourLabel setText:@"商品地区"];
	[fourLabel setFont:[UIFont systemFontOfSize:16.0f]];
	[self.scrollView addSubview: fourLabel];
	fourLabel.sd_layout
	.topSpaceToView(threeLabel, 0.0f)
	.leftSpaceToView(self.scrollView, 15.0f)
	.widthIs(90.0f)
	.heightIs(50.0f);

	[self.scrollView addSubview: self.regionalBtn];
	self.regionalBtn.sd_layout
	.centerYEqualToView(fourLabel)
	.leftSpaceToView(fourLabel, 10.0f)
	.rightSpaceToView(self.scrollView, 0.0f)
	.heightIs(50.0f);

	UIImageView *fourImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"进入 收货地址"]];
	[self.regionalBtn addSubview: fourImg];
	fourImg.sd_layout
	.centerYEqualToView(self.regionalBtn)
	.rightSpaceToView(self.regionalBtn, 10.0f)
	.widthIs(10.0f)
	.heightIs(15.0f);

	[self.regionalBtn addSubview: self.regionalLabel];
	self.regionalLabel.sd_layout
	.centerYEqualToView(self.regionalBtn)
	.leftSpaceToView(self.regionalBtn, 5.0f)
	.rightSpaceToView(fourImg, 15.0f)
	.heightIs(20.0f);
	
	// 循环加载横线
	for (NSInteger index = 0; index < 8; index ++) {
		UIView *lineView = [[UIView alloc] init];
		[lineView setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
		[self.scrollView addSubview:lineView];
		lineView.sd_layout
		.topSpaceToView(self.scrollView, 50.0f*(index + 1))
		.leftSpaceToView(self.scrollView, 0.0f)
		.rightSpaceToView(self.scrollView, 0.0f)
		.heightIs(1.0f);
	}
	
	// 绑定数据
	if (self.model) {
		[self.categoryLabel setText:self.model.columnname];
		[self.subclassLabel setText:self.model.pcolumnname];
		[self.nameTF setText: self.model.shopname];
		[self.unitTF setText: self.model.company];
		[self.couponTF setText: self.model.coupons_price];
		[self.sortingTF setText: [NSString stringWithFormat: @"%ld",self.model.weigh]];
		[self.templateLabel setText:self.model.expressname];
		[self.regionalLabel setText:[NSString stringWithFormat:@"%@%@%@",self.model.province,self.model.city,self.model.county]];
	} else {
		[self.categoryLabel setText:@"请选择"];
		[self.subclassLabel setText:@"请选择"];
		[self.templateLabel setText:@"请选择"];
		[self.regionalLabel setText:@"请选择"];
	}
	
	self.nameTF.delegate = self;
	self.nameTF.inputAccessoryView = [self addToolbar];
	
	self.unitTF.delegate = self;
	self.unitTF.inputAccessoryView = [self addToolbar];
	
	self.couponTF.delegate = self;
	self.couponTF.inputAccessoryView = [self addToolbar];
	
	self.sortingTF.delegate = self;
	self.sortingTF.inputAccessoryView = [self addToolbar];
}

- (void)loadBody {
	// 加载collectionView部分
	[self.scrollView addSubview: self.collection];
	self.collection.sd_layout
	.topSpaceToView(self.regionalBtn, 10.0f)
	.leftSpaceToView(self.scrollView, 10.0f)
	.rightSpaceToView(self.scrollView, 10.0f)
	.heightIs(ScreenWidth/5*2+30);
}

- (void)loadBottom {
	// 底部按钮视图添加
	[self.view addSubview:self.attributeBtn];
	self.attributeBtn.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.widthIs(ScreenWidth/3)
	.heightIs(50.0f);
	
	[self.view addSubview:self.stockBtn];
	self.stockBtn.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.attributeBtn, 0.0f)
	.widthIs(ScreenWidth/3)
	.heightIs(50.0f);
	
	[self.view addSubview: self.saveBtn];
	self.saveBtn.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.stockBtn, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(50.0f);
}

- (void)viewWillAppear:(BOOL)animated {
	if (!self.model) {
		self.model = [[MyGoodsModel alloc] init];
		self.model.sku = [[NSMutableArray alloc] init];
	}
	
	
	WeakSelf(self);
	// 提前请求所需列表数据
	// 父类类目
	[[RequestManager sharedManager] requestUrl:URL_goodsCategory
										method:POST
										loding:@""
										   dic:@{}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   weakSelf.categoryArray = response[@"data"];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   
									   }];

	[[RequestManager sharedManager] requestUrl:URL_goodsTemplate
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   weakSelf.templateArray = response[@"data"];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {

									   }];

//	[[RequestManager sharedManager] requestUrl:@""
//										method:POST
//										loding:@""
//										   dic:@{}
//									  progress:nil
//									   success:^(NSURLSessionDataTask *task, id response) {
//
//									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//									   }];
}

- (void)getSubcalssArray {
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_goodsSubclass
										method:POST
										loding:@""
										   dic:@{@"pid":@(pid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   weakSelf.subclassArray = response[@"data"];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
									   }];
}

#pragma mark - UICollectionView delegate & datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.model.shopimg.count + (self.model.shopimg.count >= 8 ? 0 : 1);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	// 判断是否是最后一张占位图片
	if (self.model.shopimg.count <= 0) {
		cell.imageView.image = [UIImage imageNamed: @"上传图片"];
		cell.deleteBtn.hidden = YES;
	} else {
		if (indexPath.row <= self.model.shopimg.count - 1) {
			[cell.imageView sd_setImageWithUrl:self.model.shopimg[indexPath.row]];
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
	[self.model.shopimg removeObjectAtIndex:sender.tag];
	[self.collection reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	// 更换照片
	WeakSelf(self);
	
	if (self.model == nil) {
		self.model = [[MyGoodsModel alloc] init];
		self.model.shopimg = [[NSMutableArray alloc] init];
	}
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				// 非最后一个实行替换（最后一个实行添加）
				if (weakSelf.model.shopimg.count == 0) {
					weakSelf.model.shopimg = [[NSMutableArray alloc] init];
					[weakSelf.model.shopimg addObject:urlStr];
				} else {
					if (indexPath.row <= self.model.shopimg.count - 1) {
						[weakSelf.model.shopimg replaceObjectAtIndex:indexPath.row withObject:urlStr];
					} else {
						[weakSelf.model.shopimg addObject:urlStr];
					}
				}
				[weakSelf.collection reloadData];
			}
		}];
	}];
}

#pragma mark - 点击事件
- (void)attributeBtnClick {
	// 跳转属性设置页面
	WeakSelf(self);
	AttributeSettingViewController *vc = [[AttributeSettingViewController alloc] init];
	vc.model = self.model;
	[self pushToNextVCWithNextVC:vc];
	[vc setOnDidReturn:^(MyGoodsModel *model) {
		weakSelf.model = model;
	}];
}
- (void)stockBtnClick {
	// 跳转库存设置页面
	WeakSelf(self);
	StockSettingViewController *vc = [[StockSettingViewController alloc] init];
	vc.model = self.model;
	[self pushToNextVCWithNextVC:vc];
	[vc setOnDidReturn:^(MyGoodsModel *model) {
		weakSelf.model = model;
	}];
}
- (void)saveBtnClick {
	
	// 将模型数组替换为字典数组
	NSMutableArray *array = [[NSMutableArray array] init];
	for (NSInteger i = 0; i < self.model.sku.count; i ++) {
		NSDictionary *dic = self.model.sku[i].mj_keyValues;
		[array addObject:dic];
	}
	
	if (self.categoryLabel.text.length <= 0 || [self.categoryLabel.text isEqualToString:@"请选择"] ) {
		[NavigateManager showMessage:@"请选择商品类目"];
		return;
	}
	if (self.subclassLabel.text.length <= 0 || [self.subclassLabel.text isEqualToString:@"请选择"]) {
		[NavigateManager showMessage:@"请选择商品子类目"];
		return;
	}
	if (self.nameTF.text.length <= 0) {
		[NavigateManager showMessage:@"请填写商品名称"];
		return;
	}
	if (self.unitTF.text.length <= 0) {
		[NavigateManager showMessage:@"请填写商品单位"];
		return;
	}
	if (self.couponTF.text.length <= 0) {
		[NavigateManager showMessage:@"请填写商品现金券折扣"];
		return;
	}
	if (self.sortingTF.text.length <= 0) {
		[NavigateManager showMessage:@"请填写商品排序"];
		return;
	}
	if (self.templateLabel.text.length <= 0 || [self.templateLabel.text isEqualToString:@"请选择"]) {
		[NavigateManager showMessage:@"请选择运费模版"];
		return;
	}
	if (self.regionalLabel.text.length <= 0 || [self.regionalLabel.text isEqualToString:@"请选择"]) {
		[NavigateManager showMessage:@"请选择商品地区"];
		return;
	}
	if (self.model.shopimg.count <= 0) {
		[NavigateManager showMessage:@"请上传商品图片"];
		return;
	}
	
	if (self.model.sku1.length <= 0 && self.model.sku2.length <= 0) {
		[NavigateManager showMessage: @"请必须填写一个属性"];
		return;
	}
	
	if (self.model.sku.count <= 0) {
		[NavigateManager showMessage:@"请必须填写一款库存设置"];
		return;
	}
	
	NSString *str = [self arrayToJSONString:array];
	
	NSDictionary *dic;
	if (self.isEdit) {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"columnid":@(self.model.columnid),
				@"company":self.unitTF.text,
				@"coupons_price":self.couponTF.text,
				@"expressid":@(self.model.expressid),
				@"sku":str,
				@"pcolumnid":@(self.model.pcolumnid),
				@"shopimg":[self.model.shopimg componentsJoinedByString:@","],
				@"price":self.model.sku[0].prices,
				@"shopname":self.nameTF.text,
				@"site":self.model.siteid,
				@"sku1":self.model.sku1,
				@"sku2":self.model.sku2,
				@"shopid":@(self.model.shopid),
				@"weigh":@([self.sortingTF.text integerValue])};
	} else {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"columnid":@(self.model.columnid),
				@"company":self.unitTF.text,
				@"coupons_price":self.couponTF.text,
				@"expressid":@(self.model.expressid),
				@"sku":str,
				@"pcolumnid":@(self.model.pcolumnid),
				@"shopimg":[self.model.shopimg componentsJoinedByString:@","],
				@"price":self.model.sku[0].prices,
				@"shopname":self.nameTF.text,
				@"site":self.model.siteid,
				@"sku1":self.model.sku1,
				@"sku2":self.model.sku2,
				@"weigh":@([self.sortingTF.text integerValue])};
	}
	
	
	// 保存点击事件
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:self.isEdit ? URL_editMyGoods : URL_submitMyGoods
										method:POST
										loding:@""
										   dic:dic
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"保存成功"];
											   [weakSelf popViewConDelay];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"保存失败"];
									   }];
	
}

#pragma mark - Array转Json
- (NSString *)arrayToJSONString:(NSArray *)array {
	NSError *error = nil;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
	NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	return jsonString;
}

- (void)categoryBtnClick {
	// 选择类目点击事件
	WeakSelf(self);
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (NSInteger index = 0; index < self.categoryArray.count; index ++) {
		[array addObject:[self.categoryArray[index] objectForKey:@"name"]];
	}
	
	MOFSPickerManager *manager = [MOFSPickerManager shareManger];
	
	[manager showPickerViewWithDataArray:array tag:0 title:@"选择类目" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
		// 选择完成
		[weakSelf.categoryLabel setText:string];
		pid = [[self.categoryArray[manager.pickView.selectedRow] objectForKey:@"id"] integerValue];
		[weakSelf getSubcalssArray];
		// 替换model属性
		weakSelf.model.pcolumnid = [[weakSelf.categoryArray[manager.pickView.selectedRow] objectForKey:@"id"] integerValue];
	} cancelBlock:nil];
}
- (void)subclassBtnClick {
	// 选择商品子类
	if (self.subclassArray.count <= 0) {
		[NavigateManager showMessage: @"请先选择一级类目"];
		return;
	}
	
	WeakSelf(self);
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (NSInteger index = 0; index < self.subclassArray.count; index ++) {
		[array addObject:[self.subclassArray[index] objectForKey:@"name"]];
	}
	MOFSPickerManager *manager = [MOFSPickerManager shareManger];
	[manager showPickerViewWithDataArray:array tag:0 title:@"选择类目" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
		// 选择完成
		[weakSelf.subclassLabel setText:string];
		// 替换model属性
		weakSelf.model.columnid = [[weakSelf.subclassArray[manager.pickView.selectedRow] objectForKey:@"id"] integerValue];
	} cancelBlock:nil];
}

- (void)templateBtnClick {
	// 运费模版点击事件
	WeakSelf(self);
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (NSInteger index = 0; index < self.templateArray.count; index ++) {
		[array addObject:[self.templateArray[index] objectForKey:@"title"]];
	}
	MOFSPickerManager *manager = [MOFSPickerManager shareManger];
	[manager showPickerViewWithDataArray:array tag:0 title:@"选择类目" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
		// 选择完成
		[weakSelf.templateLabel setText:string];
		// 替换model属性
		weakSelf.model.expressid = [[weakSelf.templateArray[manager.pickView.selectedRow] objectForKey:@"id"] integerValue];
	} cancelBlock:nil];
}
- (void)regionalBtnClick {
	// 商品地区点击事件
	WeakSelf(self);
	
	[[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"" title:@"清选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nullable address, NSString * _Nullable zipcode) {
		[weakSelf.regionalLabel setText:address];
		weakSelf.model.siteid = zipcode;
		
	} cancelBlock:nil];
	
	
//	[[MOFSPickerManager shareManger] showPickerViewWithDataArray:array tag:0 title:@"选择类目" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
//		// 选择完成
//		[weakSelf.regionalLabel setText:string];
//		// 替换model属性
//		weakSelf.model.columnid = [[weakSelf.subclassArray[manager.pickView.selectedRow] objectForKey:@"id"] integerValue];
//	} cancelBlock:nil];
}

#pragma mark - 提前请求列表所需数据



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
