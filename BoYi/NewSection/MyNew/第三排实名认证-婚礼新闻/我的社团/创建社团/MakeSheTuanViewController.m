//
//  MakeSheTuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MakeSheTuanViewController.h"
#import "ShetuanModel.h"
#import "MOFSPickerManager.h"
#import "MyNewViewController.h"

@interface MakeSheTuanViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;

@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextView *infoTV;

@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *areaArray;
@property (nonatomic, strong) NSArray *areaIdArray;
@property (nonatomic, strong) Shetuan *model;

@end

@implementation MakeSheTuanViewController
- (NSArray *)areaIdArray {
	if (!_areaIdArray) {
		_areaIdArray = [[NSArray alloc] init];
	}
	return _areaIdArray;
}
- (NSMutableArray *)typeArray {
	if (!_typeArray) {
		_typeArray = [[NSMutableArray alloc] init];
	}
	return _typeArray;
}
- (NSMutableArray *)areaArray {
	if (!_areaArray) {
		_areaArray = [[NSMutableArray alloc] init];
	}
	return _areaArray;
}
- (Shetuan *)model {
	if (!_model) {
		_model = [[Shetuan alloc] init];
	}
	return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建社团";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
    self.nameTF.delegate = self;
    self.addressTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.addressTF.inputAccessoryView = [self addToolbar];
	
	self.infoTV.delegate = self;
	self.infoTV.inputAccessoryView = [self addToolbar];
	
	// 图片添加点击事件
	UITapGestureRecognizer *logoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedLogo)];
	[self.logoImg addGestureRecognizer:logoTap];
	
	UITapGestureRecognizer *backgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedBackground)];
	[self.backgroundImg addGestureRecognizer:backgroundTap];
	
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_New_indexfenleilist
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
										   [NavigateManager showMessage:@"社团类请求失败"];
									   }];
}
- (void)respondsToRightBtn {
	if (self.model.logourl.length <= 0) {
		[NavigateManager showMessage:@"请添加社团LOGO图片"];
		return;
	}
	if (self.model.appphotourl.length <= 0) {
		[NavigateManager showMessage:@"请添加社团背景图片"];
		return;
	}
	if (self.nameTF.text.length <= 0) {
		[NavigateManager showMessage:@"请添加社团名称"];
		return;
	} else {
		self.model.name = self.nameTF.text;
	}
	if (self.model.typeid == 0) {
		[NavigateManager showMessage:@"请选择社团类型"];
		return;
	}
	if (self.model.provinceid == 0) {
		[NavigateManager showMessage:@"请选择社团地区"];
		return;
	}
	if (self.addressTF.text.length <= 0) {
		[NavigateManager showMessage:@"请填写社团详细地址"];
		return;
	} else {
		self.model.address = self.addressTF.text;
	}
	if (self.infoTV.text.length <= 0) {
		[NavigateManager showMessage:@"请输入社团简介"];
		return;
	} else {
		self.model.profile = self.infoTV.text;
	}
	
	WeakSelf(self);
    // 创建社团
	[[RequestManager sharedManager] requestUrl:URL_creatAssociations
										method:POST
										loding:@""
										   dic:@{@"address":self.model.address,
												 @"appphotourl":self.model.appphotourl,
												 @"cityid":@(self.model.cityid),
												 @"countyid":@(self.model.countyid),
												 @"logourl":self.model.logourl,
												 @"name":self.model.name,
												 @"profile":self.model.profile,
												 @"provinceid":@(self.model.provinceid),
												 @"type":@(self.model.typeid),
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage:@"创建社团成功"];
											   [weakSelf jump];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"社团创建失败"];
									   }];
}

- (void)selectedLogo {
	// 选择社团logo
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				self.model.logourl = urlStr;
				[weakSelf.logoImg setImage:image];
			}
		}];
	}];
}

- (void)selectedBackground {
	// 选择社团背景
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				self.model.appphotourl = urlStr;
				[weakSelf.backgroundImg setImage:image];
			}
		}];
	}];
}

- (IBAction)selectedType:(UIButton *)sender {
	// 选择社团类型
	WeakSelf(self);
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (NSInteger index = 0; index < self.typeArray.count; index ++) {
		[array addObject:[self.typeArray[index] objectForKey:@"proname"]];
	}
	MOFSPickerManager *manager = [MOFSPickerManager shareManger];
	[manager showPickerViewWithDataArray:array tag:0 title:@"选择社团类型" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
		// 选择完成
		[weakSelf.typeLabel setText:string];
		// 替换model属性
		weakSelf.model.typeid = [[weakSelf.typeArray[manager.pickView.selectedRow] objectForKey:@"occupationid"] integerValue];
	} cancelBlock:nil];
}

- (IBAction)selectedArea:(UIButton *)sender {
	// 选择社团地区
	WeakSelf(self);
	[[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"" title:@"清选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nullable address, NSString * _Nullable zipcode) {
		[weakSelf.areaLabel setText:address];
		weakSelf.areaIdArray = [zipcode componentsSeparatedByString:@"-"];
		weakSelf.model.provinceid = [weakSelf.areaIdArray[0] integerValue];
		weakSelf.model.cityid = [weakSelf.areaIdArray[1] integerValue];
		weakSelf.model.countyid = [weakSelf.areaIdArray[2] integerValue];
	} cancelBlock:nil];
}

- (void)jump {
	for (UIViewController *controller in self.navigationController.viewControllers) {
		if ([controller isKindOfClass:[MyNewViewController class]]) {
			[self.navigationController popToViewController:controller animated:YES];
		}
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
