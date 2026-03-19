//
//  AddShiPinViewController.m
//  BoYi
//
//  Created by heng on 2018/1/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddShiPinViewController.h"
#import "MyShipinSubViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AddShiPinViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UITextField *urlTF;

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;// 封面图片
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;// 视频图片


@property (weak, nonatomic) IBOutlet UIView *urlView;// 链接模块
@property (weak, nonatomic) IBOutlet UIView *dateView;// 文件模块

@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, assign) BOOL isUploadingVideo;


@end

@implementation AddShiPinViewController

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
		[_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _saveBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加视频";
    [self addPopBackBtn];
	
	
	[self.switchBtn setOn:NO];
	[self.typeLabel setText: @"外链"];
	[self.urlView setHidden: NO];
	[self.dateView setHidden: YES];
	
	if (self.model) {
		// 修改状态/只显示视频链接
		[self.nameTF setText: self.model.title];
		[self.weightTF setText: [NSString stringWithFormat: @"%ld",self.model.weigh]];
		[self.coverImage sd_setImageWithUrl:self.model.cover];
		[self.videoImage sd_setImageWithUrl:self.model.cover];

		[self.coverImage setHidden: NO];
		[self.videoImage setHidden: NO];
		[self.urlTF setText:self.model.video_url];
	} else {
		// 新建状态
		[self.coverImage setHidden: YES];
		[self.videoImage setHidden: YES];
	}
	
	[self.view addSubview: self.saveBtn];
	self.saveBtn.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(50.0f);
    self.nameTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.weightTF.delegate = self;
    self.weightTF.inputAccessoryView = [self addToolbar];
	self.urlTF.delegate = self;
    self.urlTF.inputAccessoryView = [self addToolbar];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.saveBtn.sd_layout.heightIs(50.0f);
    self.saveBtn.contentEdgeInsets = UIEdgeInsetsZero;
    [self.saveBtn updateLayout];
}

- (IBAction)selectedCover:(id)sender {
	// 更换封面图片
	if (self.model == nil) {
		self.model = [[MyShipinModel alloc] init];
	}
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				self.model.cover = urlStr;
				[weakSelf.coverImage setHidden: NO];
				[weakSelf.coverImage setImage:image];
			}
		}];
	}];
}

- (IBAction)selectedVideo:(id)sender {
	// 更换视频图片
	if (self.model == nil) {
		self.model = [[MyShipinModel alloc] init];
	}
	WeakSelf(self);
	
//	[self chooseVideoWithVc:self block:^(UIImage *coverImage, id asset) {
//		DLog(@"%@--%@",coverImage,asset);
//	}];
	[self showVideoPikerWithActionTitle:@"" imageEditing:NO videoBlock:^(NSURL *str) {
		DLog(@"%@",str);
		
		[weakSelf.videoImage setHidden:NO];
		[weakSelf.videoImage setImage:[weakSelf thumbnailImageForVideo:str atTime:1]];
		weakSelf.isUploadingVideo = YES;
		[NavigateManager showLoadingMessage:@"视频上传中..."];
		
		// 视频地址转date上传服务器
		[UIImage urlWithNSURL:str complete:^(BOOL isSuccess, NSString *urlStr) {
            weakSelf.isUploadingVideo = NO;
			if (isSuccess) {
				// 上传成功（替换模型url并且刷新界面）
				weakSelf.model.video_url = urlStr;
				[weakSelf.urlTF setText:urlStr];
                weakSelf.urlTF.text = urlStr;
                [NavigateManager showMessage:@"视频上传成功"];
			} else {
                [NavigateManager showMessage:@"视频上传失败"];
			}
		}];
	}];
	
}

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
	AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
	NSParameterAssert(asset);
	AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
	assetImageGenerator.appliesPreferredTrackTransform = YES;
	assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
	
	CGImageRef thumbnailImageRef = NULL;
	CFTimeInterval thumbnailImageTime = time;
	NSError *thumbnailImageGenerationError = nil;
	thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
	
	if (!thumbnailImageRef)
		NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
	
	UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
	
	return thumbnailImage;
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
    if (self.model.cover.length <= 0) {
        [NavigateManager showMessage: @"封面图片不能为空"];
        return;
    }
    if (self.isUploadingVideo) {
        [NavigateManager showMessage:@"视频上传中，请稍后"];
        return;
    }
    NSString *videoURL = self.model.video_url.length > 0 ? self.model.video_url : self.urlTF.text;
    if (self.switchBtn.on) {
        if (videoURL.length <= 0) {
            [NavigateManager showMessage: @"视频文件不能为空"];
            return;
        }
    }else {
        if (videoURL.length <= 0) {
            [NavigateManager showMessage: @"视频连接不能为空"];
            return;
        }
    }
    
    
	
	NSDictionary *dic;
	if (self.isEdit) {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"cover":self.model.cover,
				@"id":@(self.model.id),
				@"title":self.nameTF.text,
				@"video_url":videoURL,
				@"weight":self.weightTF.text};
	} else {
		dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
				@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
				@"cover":self.model.cover,
				@"title":self.nameTF.text,
				@"video_url":videoURL,
				@"weigh":self.weightTF.text};
	}
	
	// 提交审核
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:self.isEdit ? URL_editVideo : URL_addVideo
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
	MyShipinSubViewController *jumpVC = nil;
	for (NSInteger i = 0; i < self.navigationController.viewControllers.count;  i ++) {
		WMPageController *vc = self.navigationController.viewControllers[i];
		if ([vc isKindOfClass:[MyShipinSubViewController class]]) {
			jumpVC = (MyShipinSubViewController *)vc;
			break;
		}
	}
	[self.navigationController popToViewController:jumpVC animated:YES];
}

- (IBAction)selectedType:(UISwitch *)sender {
	// 切换视频类型
	[self.typeLabel setText: sender.on ? @"文件" : @"外链"];
	[self.urlView setHidden: sender.on];
	[self.dateView setHidden: !sender.on];
}



@end
