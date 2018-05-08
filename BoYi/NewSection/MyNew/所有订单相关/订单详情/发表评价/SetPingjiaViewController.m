//
//  SetPingjiaViewController.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SetPingjiaViewController.h"
#import "TZImagePickerController.h"
#import "TZTestCell.h"
typedef void(^Complete)();

@interface SetPingjiaViewController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    NSInteger anonymous,score,index;
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    NSMutableArray *_urlImages;
    BOOL _isSelectOriginalPhoto;

}
@property (copy, nonatomic) Complete complete;
@property (nonatomic,strong) NSMutableDictionary *dic;
@end

@implementation SetPingjiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    anonymous = 1;
    score = 0;
    self.navigationItem.title = @"发表评价";
    self.content.placeholder = @"分享这一刻的想法…";
    [self addPopBackBtn];
    [self dopac];
    [self configCollectionView];
    [self addRightBtnWithTitle:@"提交" image:nil];
    self.content.delegate = self;
    self.content.inputAccessoryView = [self addToolbar];
}

- (IBAction)action:(UIButton *)sender {
    if (sender.selected) {
        anonymous = 1;
        [self.nimingBtn setImage:[UIImage imageNamed:@"未勾选商品"] forState:UIControlStateNormal];
    }else {
        anonymous = 2;
        [self.nimingBtn setImage:[UIImage imageNamed:@"勾选照片"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
}
- (void)respondsToRightBtn{
    if (score == 0) {
        [NavigateManager showMessage:@"请选择评分"];
        return;
    }
    if (self.content.text.length == 0) {
        [NavigateManager showMessage:@"请填写评价内容"];
        return;
    }
   
    
    @weakify(self);
    [NavigateManager showLoadingMessage:@"保存中..."];

    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    index = 0;
    if (_selectedPhotos.count > 0) {
        for (int i = 0; i< _selectedPhotos.count; i++) {
            
            NSData *data = UIImageJPEGRepresentation(_selectedPhotos[i], 1.0f);
            NSString *str = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
            NSDictionary *dic = @{@"img":[@"data:image/png;base64," stringByAppendingString:str]};
            [[RequestManager sharedManager] requestUrl:URL_base64Upload
                                                method:POST
                                                loding:nil
                                                   dic:dic
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   
                                                   index ++;
                                                   [urlArray addObject: response[@"data"]];
                                                   if (self.complete) {
                                                       self.complete();
                                                   }
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   NSLog(@"%@",error);
                                               }];
            
        }
        
        self.complete = ^{
            
            //请求网络的数量等于3表示三个网络请求已完成
            if (index == _selectedPhotos.count) {
                
                @strongify(self);
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:@(self.id) forKey:@"id"];
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:@(anonymous) forKey:@"anonymous"];
                [dic setValue:self.content.text forKey:@"content"];
                [dic setValue:@(score) forKey:@"score"];
                if (urlArray.count != 0) {
                    NSString *tempString = [urlArray componentsJoinedByString:@","];//分隔符逗号
                    [dic setValue:tempString forKey:@"pictures"];
                }
                NSString *url;
                if (self.isHunQin) {
                    url = [HOMEURL stringByAppendingString:@"appapi/ordershq/evaluate"];
                }else {
                    url = [HOMEURL stringByAppendingString:@"appapi/Orders/evaluate"];
                }
                [[RequestManager sharedManager] requestUrl:url
                                                    method:POST
                                                    loding:nil
                                                       dic:dic
                                                  progress:nil
                                                   success:^(NSURLSessionDataTask *task, id response) {
                                                       if ([response[@"code"] integerValue] == 0) {
                                                           [NavigateManager showMessage:@"评价成功"];
                                                           [self popViewConDelay];
                                                       }else {
                                                           [NavigateManager showMessage:response[@"message"]];
                                                       }
                                                       
                                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                       
                                                   }];
                
            }
            
        };
    }else {
        [NavigateManager showLoadingMessage:@"正在评价。。。"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@(self.id) forKey:@"id"];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:@(anonymous) forKey:@"anonymous"];
        [dic setValue:self.content.text forKey:@"content"];
        [dic setValue:@(score) forKey:@"score"];
//        [dic setValue:@"" forKey:@"pictures"];
        NSString *url;
        if (self.isHunQin) {
            url = [HOMEURL stringByAppendingString:@"appapi/ordershq/evaluate"];
        }else {
            url = [HOMEURL stringByAppendingString:@"appapi/Orders/evaluate"];
        }
        [[RequestManager sharedManager] requestUrl:url
                                            method:POST
                                            loding:nil
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager showMessage:@"评价成功"];
                                                   [self popViewConDelay];
                                               }else {
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                               
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                           }];
    }
}

- (void)dopac{
    UIView *faubView = [self.view viewWithTag:1000];
    for (int i  = 0; i < 5; i++) {
        
        UIButton *btn = (UIButton *)[faubView viewWithTag:100 + i];
        @weakify(self);
        //点击
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            [self getBtnTag:i];
            for (int j  = 0; j < 5; j++) {
                
                UIButton *btnt = (UIButton *)[faubView viewWithTag:100 + j];
                if (j <= i) {
                    [btnt setImage:[UIImage imageNamed:@"星 满"] forState:UIControlStateNormal];

                }else {

                    [btnt setImage:[UIImage imageNamed:@"星 未满"] forState:UIControlStateNormal];
                    
                }
            }
        }];
    }
    
}
- (void)getBtnTag:(NSInteger)integer{
    score = integer + 1;
    self.fenshu.text = [NSString stringWithFormat:@"%ld分",integer + 1];
}
- (void)configCollectionView {
    
    _collection.dataSource = self;
    _collection.delegate = self;
    [_collection registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}
#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    //    cell.frame = CGRectMake(0, 0, 74, 74);
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"评价 上传图片.png"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        [self pickPhotoButtonClick:nil];
    } else { // preview photos / 预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        // imagePickerVc.allowPickingOriginalPhoto = NO;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [_collection reloadData];
//            _collection.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.item >= _selectedPhotos.count || destinationIndexPath.item >= _selectedPhotos.count) return;
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    if (image) {
        [_selectedPhotos exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_selectedAssets exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_collection reloadData];
    }
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(82,82);
}
#pragma mark Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collection performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collection deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collection reloadData];
    }];
}

- (IBAction)pickPhotoButtonClick:(UIButton *)sender {
    [self takePhoto];
}

- (void)takePhoto{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    //    imagePickerVc.allowTakePicture = NO; // 隐藏拍照按钮
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark TZImagePickerControllerDelegate
/// User finish picking photo，if assets are not empty, user picking original photo.
/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collection reloadData];
//    _collection.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}
@end
