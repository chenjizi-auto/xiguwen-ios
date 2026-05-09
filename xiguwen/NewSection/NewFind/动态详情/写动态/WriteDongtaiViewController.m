//
//  SetPingjiaViewController.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "WriteDongtaiViewController.h"
#import "TZImagePickerController.h"
#import "TZTestCell.h"
typedef void(^Complete)();

@interface WriteDongtaiViewController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    NSInteger anonymous,score,index;
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    NSMutableArray *_urlImages;
    BOOL _isSelectOriginalPhoto;
    
}
@property (copy, nonatomic) Complete complete;
@property (nonatomic,strong) NSMutableDictionary *dic;
@end

@implementation WriteDongtaiViewController

static const NSInteger kWriteDongtaiMaxImageCount = 9;
static const NSInteger kWriteDongtaiColumnCount = 3;
static const CGFloat kWriteDongtaiGridSpacing = 12.0f;
static const CGFloat kWriteDongtaiGridVerticalInset = 10.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    anonymous = 1;
    score = 0;
    self.navigationItem.title = @"发动态";
    self.content.placeholder = @"分享这一刻的想法…";
    [self addPopBackBtn];
    [self dopac];
    [self configCollectionView];
    [self addRightBtnWithTitle:@"提交" image:nil];
    self.content.delegate = self;
    self.content.inputAccessoryView = [self addToolbar];
}

- (void)respondsToRightBtn{

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
            
            NSData *data = [UIImage cw_uploadImageDataFromImage:_selectedPhotos[i]];
            NSString *str = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
            NSDictionary *dic = @{@"img":[@"data:image/png;base64," stringByAppendingString:str]};
            [[RequestManager sharedManager] requestUrl:URL_base64Upload
                                                method:POST
                                               loding:nil
                                                   dic:dic
                                              progress:nil
                                               success:^(NSURLSessionDataTask *task, id response) {
                                                   if (![response isKindOfClass:[NSDictionary class]]) {
                                                       return;
                                                   }
                                                   index ++;
                                                   if ([response[@"data"] isKindOfClass:[NSString class]] && [response[@"data"] length] > 0) {
                                                       [urlArray addObject: response[@"data"]];
                                                   }
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
//                [dic setValue:@(self.id) forKey:@"id"];
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:self.content.text forKey:@"content"];
                if (urlArray.count != 0) {
                    NSString *tempString = [urlArray componentsJoinedByString:@","];//分隔符逗号
                    [dic setValue:tempString forKey:@"photourl"];
                }
                NSString *url;
                if (self.isHunQin) {
                    url = [HOMEURL stringByAppendingString:@"appapi/ordershq/evaluate"];
                }else {
                    url = [HOMEURL stringByAppendingString:@"appapi/found/publishingdynamics"];
                }
                [[RequestManager sharedManager] requestUrl:url
                                                    method:POST
                                                    loding:nil
                                                       dic:dic
                                                  progress:nil
                                                   success:^(NSURLSessionDataTask *task, id response) {
                                                       if (![response isKindOfClass:[NSDictionary class]]) {
                                                           [NavigateManager showMessage:@"发布失败"];
                                                           return;
                                                       }
                                                       if ([response[@"code"] integerValue] == 0) {
                                                           [NavigateManager showMessage:@"发布成功"];
                                                           [self popViewConDelay];
                                                       }else {
                                                           [NavigateManager showMessage:response[@"message"]];
                                                       }
                                                       
                                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                       
                                                   }];
                
            }
            
        };
    }else {
        [NavigateManager showLoadingMessage:@"正在发布。。。"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setValue:@(self.id) forKey:@"id"];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
//        [dic setValue:@(anonymous) forKey:@"anonymous"];
        [dic setValue:self.content.text forKey:@"content"];
//        [dic setValue:@(score) forKey:@"score"];
        //        [dic setValue:@"" forKey:@"pictures"];
        NSString *url;
        if (self.isHunQin) {
            url = [HOMEURL stringByAppendingString:@"appapi/ordershq/evaluate"];
        }else {
            url = [HOMEURL stringByAppendingString:@"appapi/found/publishingdynamics"];
        }
        [[RequestManager sharedManager] requestUrl:url
                                            method:POST
                                            loding:nil
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if (![response isKindOfClass:[NSDictionary class]]) {
                                                   [NavigateManager showMessage:@"发布失败"];
                                                   return;
                                               }
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager showMessage:@"发布成功"];
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
    
}
- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collection.collectionViewLayout;
    layout.minimumLineSpacing = kWriteDongtaiGridSpacing;
    layout.minimumInteritemSpacing = kWriteDongtaiGridSpacing;
    layout.sectionInset = UIEdgeInsetsMake(kWriteDongtaiGridVerticalInset, 0.0f, kWriteDongtaiGridVerticalInset, 0.0f);
    _collection.dataSource = self;
    _collection.delegate = self;
    [_collection registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    _collection.scrollEnabled = NO;
    [self refreshCollectionHeight];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collection.collectionViewLayout;
    CGFloat totalWidth = CGRectGetWidth(self.collection.bounds);
    CGFloat availableWidth = totalWidth - (kWriteDongtaiColumnCount - 1) * kWriteDongtaiGridSpacing;
    CGFloat itemWidth = floor(availableWidth / kWriteDongtaiColumnCount);
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    [self refreshCollectionHeight];
}
#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count >= kWriteDongtaiMaxImageCount ? kWriteDongtaiMaxImageCount : _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.imageView.layer.cornerRadius = 8.0f;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderWidth = 1.0f;
    cell.imageView.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"评价 上传图片.png"];
        cell.imageView.contentMode = UIViewContentModeCenter;
        cell.imageView.backgroundColor = UIColorFromRGB(0xFAFAFA);
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.backgroundColor = UIColor.clearColor;
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
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
#pragma mark Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collection performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collection deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self refreshCollectionHeight];
        [_collection reloadData];
    }];
}

- (IBAction)pickPhotoButtonClick:(UIButton *)sender {
    [self takePhoto];
}

- (void)takePhoto{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
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
    
    [self refreshCollectionHeight];
    [_collection reloadData];
    //    _collection.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}
- (void)refreshCollectionHeight {
    NSInteger itemCount = [self collectionView:self.collection numberOfItemsInSection:0];
    NSInteger rows = MAX((NSInteger)ceil(itemCount / (CGFloat)kWriteDongtaiColumnCount), 1);
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collection.collectionViewLayout;
    CGFloat itemHeight = layout.itemSize.height > 0.0f ? layout.itemSize.height : 0.0f;
    _collectionHeight.constant = layout.sectionInset.top + rows * itemHeight + (rows - 1) * kWriteDongtaiGridSpacing + layout.sectionInset.bottom;
    [self.view layoutIfNeeded];
}
@end
