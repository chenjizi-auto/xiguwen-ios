//
//  SelectPhotoView.m
//  ThreeAsk_New
//
//  Created by Yifei Li on 2017/7/3.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import "SelectPhotoView.h"
#import "SelectPhotoCollectionViewCell.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "MJPhotoBrowser.h"
#import <Photos/Photos.h> // iOS8.0开始,我们最好用这个咯
//#import <MWPhotoBrowser.h>

@interface SelectPhotoView () <UICollectionViewDelegate,UICollectionViewDataSource> {
    NSMutableArray *_photoArray;
    NSMutableArray *_selections;
}

@property (strong,nonatomic) UICollectionView *PhotoSubView;
@property (weak,nonatomic) UIViewController *showVc;
@property (strong,nonatomic) NSMutableArray *assets;

@end

@implementation SelectPhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cellWidth                  = (ScreenWidth - 25 - 30) / 4;
    layout.itemSize                    = CGSizeMake(cellWidth, cellWidth);
    layout.minimumLineSpacing          = 10;
    layout.minimumInteritemSpacing     = 10;
    
    CGFloat oneX = 12.5;
    layout.sectionInset = UIEdgeInsetsMake(oneX, oneX, oneX, oneX);
    
    self.PhotoSubView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.PhotoSubView.dataSource = self;
    self.PhotoSubView.delegate = self;
    self.PhotoSubView.backgroundColor = [UIColor whiteColor];
    [self.PhotoSubView registerNib:[UINib nibWithNibName:@"SelectPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SelectPhotoCollectionViewCell"];
    [self addSubview:self.PhotoSubView];
    
    
    self.imageArray = nil;
    
}

- (void)layoutSubviews {
    
    self.PhotoSubView.frame = self.bounds;
}

//
- (void)setImageArray:(NSMutableArray *)imageArray {
    
    _imageArray = imageArray;
    [self adjustLayout];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.PhotoSubView reloadData];
    });
    
}

//处理高度问题  调整
- (void)adjustLayout {
    
    NSInteger count = self.imageArray.count >= 9 ? self.imageArray.count : self.imageArray.count + 1;
    NSInteger rowCount = ceil((CGFloat)count / 4.0);
    //这里算出视图高度
    CGFloat cellWidth = (ScreenWidth - 25 - 30) / 4;
    CGFloat height = 2 * 12.5 + (cellWidth + 10) * rowCount;
    if (self.adjustFrameBlock) {
        self.adjustFrameBlock(height);
    }
}






- (void)showInVc:(UIViewController *)vc {
    
    self.showVc = vc;
}



#pragma mark-DataSource的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count >= 9 ? self.imageArray.count : self.imageArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectPhotoCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row >= self.imageArray.count) {
        cell.imageView.image = IMAGE_NAME(@"ic_ddgl_camera_line");
    } else {
        if ([self.imageArray[indexPath.row] isKindOfClass:[NSString class]]) {
            [cell.imageView sd_setImageWithUrl:ImageAppendURL(self.imageArray[indexPath.row])];
        } else {
            cell.imageView.image = self.imageArray[indexPath.row];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row >= self.imageArray.count) {
        //如果点到选择图片按钮
        [self showAlert];
        
    } else {
        [self choosePictureWithCheck:YES index:indexPath.row];
    }
}
- (void)showAlert {
    UIAlertController *alert = [[UIAlertController alloc] init];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FatherViewController *vc = (FatherViewController *)self.presentVc;
        __weak typeof(self) weakSelf = self;
        [vc openSystemPhotoAlbum:UIImagePickerControllerSourceTypeCamera imageEditing:NO imageBlock:^(UIImage *image) {
            //保存图片
            [weakSelf saveImage:image];
        }];;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        [self choosePictureWithCheck:NO index:0];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.presentVc presentViewController:alert animated:YES completion:NULL];
}



/**
 查看或选择图片

 @param checked 是否是查看图片
 @param index 查看图标的当前下标
 */
- (void)choosePictureWithCheck:(BOOL)checked index:(NSInteger)index {
    
    
    TZImagePickerController *imagePickerVc;
    if (checked) {
        
        if ([self.imageArray.firstObject isKindOfClass:[UIImage class]]) {
            
            
            imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:self.assets
                                                                     selectedPhotos:self.imageArray
                                                                              index:index];
            
        } else {
            
            if (!_selections) {
                _selections = [[NSMutableArray alloc] init];
            } else {
                [_selections removeAllObjects];
            }
            _photoArray = [[NSMutableArray alloc] initWithCapacity:self.imageArray.count];
            
//            for (id image in self.imageArray) {
//
//                MWPhoto *photo;
//                if ([image isKindOfClass:[UIImage class]]) {
//                    photo = [MWPhoto photoWithImage:image];
//                } else {
//                    photo = [MWPhoto photoWithURL:[NSURL URLWithString:ImageAppendURL(image)]];
//                }
//
//                [_selections addObject:@YES];
//                [_photoArray addObject:photo];
//            }
//
//            // Create browser
//            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
//            browser.displayActionButton = NO;
//            browser.displayNavArrows = NO;
//            browser.displaySelectionButtons = YES;
//            browser.alwaysShowControls = NO;
//            browser.zoomPhotosToFill = NO;
//            browser.enableGrid = YES;
//            browser.startOnGrid = YES;
//            browser.enableSwipeToDismiss = NO;
//            browser.autoPlayOnAppear = NO;
//            [browser setCurrentPhotoIndex:index];
//            // Modal
//            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
//            //        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            [self.showVc presentViewController:nc animated:YES completion:nil];
            return;
        }
    
    
    
    } else {
        imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
        if (self.assets) {
            imagePickerVc.selectedAssets = self.assets;
        }
    }
    
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.maxImagesCount = 9;
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    __weak typeof(self) weakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        
        weakSelf.imageArray = photos.mutableCopy;
        weakSelf.assets = assets.mutableCopy;
    }];
    
    [self.showVc presentViewController:imagePickerVc animated:YES completion:NULL];
}

#pragma mark - 保存图片处理

- (void)save:(UIImage *)image {
    // 0.判断状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        DLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
        [MBProgressHUD showMsg:@"请在”设置-隐私-相机“选项中允许使用相机权限"];
        
    }else if (status == PHAuthorizationStatusRestricted){
        DLog(@"家长控制,不允许访问");
    }else if (status == PHAuthorizationStatusNotDetermined){
        DLog(@"用户还没有做出选择");
        [self saveImage:image];
    }else if (status == PHAuthorizationStatusAuthorized){
        DLog(@"用户允许当前应用访问相册");
        [self saveImage:image];
    }
}

/**
 *  返回相册
 */
- (PHAssetCollection *)collection{
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:@"相机胶卷"]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"相机胶卷"].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}


/**
 *  返回相册,避免重复创建相册引起不必要的错误
 */
- (void)saveImage:(UIImage *)image {
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件,比如一张图片
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    
    __block NSString *assetId = nil;
    __weak typeof(self) weakSelf = self;
    
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{ // 这个block里保存一些"修改"性质的代码
        // 新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"
        // 返回PHAsset(图片)的字符串标识
        assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            DLog(@"保存图片到相机胶卷中失败");
            return;
        }
        
        DLog(@"成功保存图片到相机胶卷中");
        
        // 2. 获得相册对象
        PHAssetCollection *collection = [self collection];
        
        
        // 根据唯一标示获得相片对象
        PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
        // 3. 将“相机胶卷”中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];

            // 添加图片到相册中
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                DLog(@"添加图片到相册中失败");
                return;
            }
            
            DLog(@"成功添加图片到相册中");
            
            //处理数据
            if (!weakSelf.imageArray) weakSelf.imageArray = [NSMutableArray array];
            if (!weakSelf.assets) weakSelf.assets = [NSMutableArray array];
            
            [weakSelf.imageArray addObject:image];
            [weakSelf.assets addObject:asset];
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [MBProgressHUD showMsg:@"保存成功"];
                [weakSelf adjustLayout];
                [weakSelf.PhotoSubView reloadData];
            }];
        }];
    }];
}


#pragma mark - MWPhotoBrowserDelegate

//- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
//    return _photoArray.count;
//}
//
//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
//    if (index < _photoArray.count)
//        return [_photoArray objectAtIndex:index];
//    return nil;
//}

//- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//
//    if (self.isVideo && self.isWebUrl) {
//        //网络图片
//        MWPhoto *photo = [MWPhoto photoWithURL:URL(_imageArray[0])];
//        return photo;
//    }
//    if (index < _photoArray.count)
//        return [_photoArray objectAtIndex:index];
//    return nil;
//}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = _photoArray[index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return captionView;
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
//    DLog(@"Did start viewing photo at index %lu", (unsigned long)index);
//}
//
//- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
//    return [[_selections objectAtIndex:index] boolValue];
//}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
//    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
//    DLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
//}
//
//- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
//    // If we subscribe to this method we must dismiss the view controller ourselves
//    DLog(@"Did finish modal presentation");
//
//    if (_selections) {
//        NSMutableArray *notSelectArray = [[NSMutableArray alloc] init];;
//        for (int i = 0;i < _selections.count;i++) {
//            NSNumber *num = _selections[i];
//            if ([num boolValue]) {
//                [notSelectArray addObject:_imageArray[i]];
//            }
//        }
//        if (notSelectArray.count != _imageArray.count) {
//            self.imageArray = notSelectArray;
//        }
//    }
//
//    [photoBrowser dismissViewControllerAnimated:YES completion:nil];
//}

@end




