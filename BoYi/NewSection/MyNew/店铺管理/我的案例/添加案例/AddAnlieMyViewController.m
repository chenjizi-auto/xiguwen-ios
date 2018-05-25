//
//  AddAnlieMyViewController.m
//  BoYi
//
//  Created by heng on 2018/1/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddAnlieMyViewController.h"
#import "MyAnLieSubViewController.h"
#import "TZTestCell.h"
#import "CaiPaiDateSele.h"
#import "MOFSPickerManager.h"
#import "CwDatePiker.h"
@interface AddAnlieMyViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;


@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UITextField *placeTF;
@property (nonatomic, strong) NSMutableArray *typeArray;// 婚礼类型数组
@property (nonatomic, strong) NSMutableArray *placeArray;// 婚礼环境类型


@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UITextView *describeTV;
@property (weak, nonatomic) IBOutlet UIView *container;

@property (nonatomic, strong) UIImageView *coverImgView;
@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation AddAnlieMyViewController

- (NSMutableArray *)typeArray {
	if (!_typeArray) {
		_typeArray = [[NSMutableArray alloc] init];
	}
	return _typeArray;
}

- (NSMutableArray *)placeArray {
	if (!_placeArray) {
		_placeArray = [[NSMutableArray alloc] init];
	}
	return _placeArray;
}

- (UIImageView *)coverImgView {
	if (!_coverImgView) {
		_coverImgView = [[UIImageView alloc] init];
		[_coverImgView setUserInteractionEnabled: YES];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedCoverImg:)];
		[_coverImgView addGestureRecognizer:tap];
	}
	return _coverImgView;
}

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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// 获取婚礼类型与环紧类型
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_weddingType
										method:POST
										loding:@""
										   dic:@{}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   weakSelf.typeArray = response[@"data"];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"获取婚礼类型失败"];
									   }];
	
	[[RequestManager sharedManager] requestUrl:URL_weddingPlaceType
										method:POST
										loding:@""
										   dic:@{}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   weakSelf.placeArray = response[@"data"];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"获取婚礼环境类型失败"];
									   }];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加案例";
    [self addPopBackBtn];
	
	if (self.model) {
		// 添加数据
		[self.nameTF setText: self.model.title];
		[self.timeLabel setText: self.model.weddingtime];
		[self.addressTF setText: self.model.weddingplace];
		[self.priceTF setText: [NSString stringWithFormat: @"%ld",self.model.weddingexpenses]];
		[self.typeTF setText: self.model.weddingtype];
		[self.placeTF setText:self.model.weddingenvironment];
		[self.weightTF setText:[NSString stringWithFormat: @"%ld",self.model.weigh]];
		[self.describeTV setText: self.model.weddingdescribe];
		// 添加婚礼封面
		
		[self.coverImgView setHidden: NO];
		[self.coverImgView sd_setImageWithUrl:self.model.weddingcover];
	} else {
		[self.coverImgView setHidden: YES];
	}
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
	
	self.priceTF.delegate = self;
	self.priceTF.inputAccessoryView = [self addToolbar];
	
    self.weightTF.delegate = self;
    self.weightTF.inputAccessoryView = [self addToolbar];
    self.describeTV.delegate = self;
    self.describeTV.inputAccessoryView = [self addToolbar];
	[self.coverView addSubview: self.coverImgView];
	self.coverImgView.sd_layout
	.centerYEqualToView(self.coverView)
	.rightSpaceToView(self.coverView, 30.0f)
	.widthIs(70.0f)
	.heightIs(70.0f);
	
	[self.view addSubview: self.saveBtn];
	self.saveBtn.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(50.0f);
	
	[self.baseView addSubview: self.collectionView];
	self.collectionView.sd_layout
	.topSpaceToView(self.container, 10.0f)
	.leftSpaceToView(self.baseView, 10.0f)
	.rightSpaceToView(self.baseView, 10.0f)
	.heightIs(ScreenWidth/5*2+30);
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
		self.model = [[MyAnLieVCModel alloc] init];
		self.model.imglist = [[NSMutableArray alloc] init];
	}
	
	[self showImagePikerWithActionTitle: @"" imageEditing:YES imageBlock:^(UIImage *image) {
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


#pragma mark - 选择婚礼时间
- (IBAction)selectedTime:(UIButton *)sender {
//    [CaiPaiDateSele showInView:self.view block:^(NSDate *date) {
//        NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd HH:mm"];
//        [self.timeLabel setText: dateString];
//    }];
    __weak typeof(self) weakSelf = self;
    [CwDatePiker showInView:weakSelf.view issele:NO block:^(NSDate *date) {
        
        
        NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
        [weakSelf.timeLabel setText: dateString];
//        [weakSelf.timeBTN setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];

    }];
}

#pragma mark - 选择婚礼类型
- (IBAction)selectedType:(UIButton *)sender {
	WeakSelf(self);
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (NSInteger index = 0; index < self.typeArray.count; index ++) {
		[array addObject:[self.typeArray[index] objectForKey:@"title"]];
	}
	
	MOFSPickerManager *manager = [MOFSPickerManager shareManger];
	
	[manager showPickerViewWithDataArray:array tag:0 title:@"选择类目" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
		// 选择完成
		[weakSelf.typeTF setText:string];
		// 替换model属性
		weakSelf.model.weddingtypeid = [[weakSelf.typeArray[manager.pickView.selectedRow] objectForKey:@"id"] integerValue];
//		DLog(@"%ld",manager.pickView.selectedRow);
		
	} cancelBlock:nil];
}

#pragma mark - 选择婚礼环境
- (IBAction)selectedPlace:(UIButton *)sender {
	
	WeakSelf(self);
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (NSInteger index = 0; index < self.placeArray.count; index ++) {
		[array addObject:[self.placeArray[index] objectForKey:@"title"]];
	}
	
	MOFSPickerManager *manager = [MOFSPickerManager shareManger];
	[manager showPickerViewWithDataArray:array tag:0 title:@"选择类目" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
		// 选择完成
		[weakSelf.placeTF setText:string];
		// 替换model属性
		weakSelf.model.weddingenvironmentid = [[weakSelf.placeArray[manager.pickView.selectedRow] objectForKey:@"id"] integerValue];
	} cancelBlock:nil];
}


#pragma mark - 选择婚礼封面
- (IBAction)selectedCoverImg:(UIButton *)sender {
	if (self.model == nil) {
		self.model = [[MyAnLieVCModel alloc] init];
		self.model.imglist = [[NSMutableArray alloc] init];
	}
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:YES imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				self.model.weddingcover = urlStr;
				[weakSelf.coverImgView setHidden: NO];
				[weakSelf.coverImgView setImage:image];
			}
		}];
	}];
}

#pragma mark - 保存案例同时上传
- (void)saveBtnClick {
	// 保存添加报价
	if (self.nameTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入名称"];
		return;
	}
	
	if (self.timeLabel.text.length <= 0) {
		[NavigateManager showMessage: @"请选择婚礼时间"];
		return;
	}
	
	if (self.addressTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入婚礼场地"];
		return;
	}
	
	if (self.priceTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入婚礼费用"];
		return;
	}
	
	if (self.typeTF.text.length <= 0) {
		[NavigateManager showMessage: @"请选择婚礼类型"];
		return;
	}
	
	if (self.placeTF.text.length <= 0) {
		[NavigateManager showMessage: @"请选择婚礼环境"];
		return;
	}
	
	if (self.weightTF.text.length <= 0) {
		[NavigateManager showMessage: @"请输入婚礼排序"];
		return;
	}
	
	if (self.coverImgView.image == nil) {
		[NavigateManager showMessage: @"请选择婚礼封面"];
		return;
	}
	
	if (self.describeTV.text.length <= 0) {
		[NavigateManager showMessage: @"请填写婚礼描述"];
		return;
	}
    if (self.model.imglist.count == 0) {
        [NavigateManager showMessage: @"请添加图片"];
        return;
    }
	NSDictionary *dic;
	if (self.isEdit) {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"photourl":[self.model.imglist componentsJoinedByString:@","],
				@"id":@(self.model.id),
				@"title":self.nameTF.text,
				@"weddingcover":self.model.weddingcover,
				@"weddingdescribe":self.describeTV.text,
				@"weddingenvironmentid":@(self.model.weddingenvironmentid),
				@"weddingexpenses":self.priceTF.text,
				@"weddingplace":self.addressTF.text,
				@"weddingtime":self.timeLabel.text,
				@"weddingtypeid":@(self.model.weddingtypeid),
				@"weigh":self.weightTF.text};
	} else {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"photourl":[self.model.imglist componentsJoinedByString:@","],
				@"title":self.nameTF.text,
				@"weddingcover":self.model.weddingcover,
				@"weddingdescribe":self.describeTV.text,
				@"weddingenvironmentid":self.placeTF.text,
				@"weddingexpenses":self.priceTF.text,
				@"weddingplace":self.addressTF.text,
				@"weddingtime":self.timeLabel.text,
				@"weddingtypeid":self.typeTF.text,
				@"weigh":self.weightTF.text};
	}
	
	// 提交审核
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:self.isEdit ? URL_EditCases : URL_casesAdd
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
	MyAnLieSubViewController *jumpVC = nil;
	for (NSInteger i = 0; i < self.navigationController.viewControllers.count;  i ++) {
		WMPageController *vc = self.navigationController.viewControllers[i];
		if ([vc isKindOfClass:[MyAnLieSubViewController class]]) {
			jumpVC = (MyAnLieSubViewController *)vc;
			break;
		}
	}
	[self.navigationController popToViewController:jumpVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
