//
//  RenZhenXYViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "RenZhenXYViewController.h"
#import "TZImagePickerController.h"
#import "TZTestCell.h"

@interface RenZhenXYViewController () <TZImagePickerControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource> {
}
@property (weak, nonatomic) IBOutlet UITextField *videoLinkTF;
@property (weak, nonatomic) IBOutlet UIView *albumView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation RenZhenXYViewController

- (InstituteAuth *)model {
	if (!_model) {
		_model = [[InstituteAuth alloc] init];
	}
	return _model;
}

- (NSMutableArray *)imageArray {
	if (!_imageArray) {
		_imageArray = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@""]];
	}
	return _imageArray;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, ScreenWidth, 200.0f) collectionViewLayout:self.layout];
		[_collectionView setBackgroundColor:[UIColor whiteColor]];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		[_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier: @"cell"];
	}
	return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
	if (!_layout) {
		_layout = [[UICollectionViewFlowLayout alloc] init];
		_layout.itemSize = CGSizeMake(ScreenWidth/5, ScreenWidth/5);
		_layout.minimumLineSpacing = 2.0f;
		_layout.minimumInteritemSpacing = 2.0f;
	}
	return _layout;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.model.parameter1;
    [self addRightBtnWithTitle:@"提交" image:nil];
    [self addPopBackBtn];
    self.videoLinkTF.delegate = self;
    self.videoLinkTF.inputAccessoryView = [self addToolbar];
	// 循环加载图片显示
	[self.albumView addSubview: self.collectionView];
	self.collectionView.sd_layout
	.topSpaceToView(self.albumView, 10.0f)
	.leftSpaceToView(self.albumView, 10.0f)
	.rightSpaceToView(self.albumView, 10.0f)
	.bottomSpaceToView(self.albumView, 0.0f);
	
    if (self.isChanged) {
        [self loadData];
    }
}
- (void)loadData {
    // 获取认证类型和价格
    WeakSelf(self);
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
                                                                                   @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
                                                                                   @"id":@(self.model.uid)}];
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Authentication/seerenzhen"]
                                        method:POST
                                        loding:@""
                                           dic:dicInfo
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               if (response[@"video_url"]) {
                                                   weakSelf.videoLinkTF.text = response[@"video_url"];
                                               }
                                               if (response[@"r_data"]) {
                                                   NSString *url = response[@"r_data"];
                                                   NSArray *arr = [url componentsSeparatedByString:@","];
                                                   for (int i = 0;i < arr.count;i++) {
                                                       [weakSelf.imageArray replaceObjectAtIndex:i withObject:arr[i]];
                                                       
                                                   }
                                               }
                                               [weakSelf.collectionView reloadData];
                                           }  else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];

}
- (void)respondsToRightBtn {
    
    
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
                                                                                   @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
                                                                                   @"id":@(self.model.uid),
                                                                                   @"did":@(self.model.did)}];
    
    NSInteger count = 0;
    NSMutableArray *picArray = [NSMutableArray array];
    // 判断图片是否完整
    for (NSInteger index = 0; index < self.imageArray.count; index ++) {
        if (![self.imageArray[index] isEqualToString: @""]) {
//            [NavigateManager showMessage: @"请完善图片信息"];
//            return;
            [picArray addObject:self.imageArray[index]];
        } else {
            count = 1;
        }
    }
	// 提交认证资料
	DLog(@"进入下一步");
	if (self.videoLinkTF.text.length != 0) {
        
        [dicInfo setObject:self.videoLinkTF.text forKey:@"video"];
        
//        [NavigateManager showMessage: @"请填写视频地址"];
//        return;
    } else {
        count += 1;
    }
    if (count == 0) {
        
        [NavigateManager showMessage: @"请填写信息"];
        return;
    }
    if (picArray.count > 0) {
        [dicInfo setObject:[picArray componentsJoinedByString:@","] forKey:@"photo"];
    }
	
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_submitCertification
										method:POST
										loding:@""
										   dic:dicInfo
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   [NavigateManager showMessage: @"提交成功"];
										   [weakSelf popViewConDelay];
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"提交失败"];
									   }];
	
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	if ([self.imageArray[indexPath.row]  isEqual: @""]) {
		// 未上传图片
		cell.imageView.image = [UIImage imageNamed: @"评价 上传图片"];
		cell.deleteBtn.hidden = YES;
	} else {
		// 已上传图片
		[cell.imageView sd_setImageWithUrl:self.imageArray[indexPath.row]];
		cell.deleteBtn.hidden = NO;
		cell.deleteBtn.tag = indexPath.row;
		[cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:NO imageBlock:^(UIImage *image) {
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				[weakSelf.imageArray replaceObjectAtIndex:indexPath.row withObject:urlStr];
				[weakSelf.collectionView reloadData];
			}
		}];
	}];
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	return CGSizeMake(ScreenWidth/5,ScreenWidth/5);
}


- (void)deleteBtnClick:(UIButton *)sender {
	// 删除图片
	[self.imageArray replaceObjectAtIndex:sender.tag withObject:@""];
	[self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
