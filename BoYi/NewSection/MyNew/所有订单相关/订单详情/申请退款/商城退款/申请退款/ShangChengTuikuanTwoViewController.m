//
//  ShangChengTuikuanTwoViewController.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangChengTuikuanTwoViewController.h"
#import "ShangchengModelTui.h"
#import "TZImagePickerController.h"
#import "TZTestCell.h"
typedef void(^Complete)();
@interface ShangChengTuikuanTwoViewController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>{
    BOOL isAgree;
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    NSMutableArray *_urlImages;
    BOOL _isSelectOriginalPhoto;
    NSInteger index;
}
@property (copy, nonatomic) Complete complete;
@property (strong, nonatomic) ShangchengModelTui *model;
@end

@implementation ShangChengTuikuanTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请退款";
    [self addRightBtnWithTitle:@"提交" image:nil];
    [self addPopBackBtn];
    self.yuanyin.placeholder = @"请输入退款原因…";
    isAgree = YES;
    if (self.typeStitc == 60) {
        [self weiFahuoAction];
    }else {//70 /80
        if (self.isYiFaHuo) {
            [self yiFahuoAction];
        }else {
            [self weiFahuoAction];
        }
    }
    
    [self configCollectionView];
    self.shijikuquan.delegate = self;
    self.shijikuquan.inputAccessoryView = [self addToolbar];
    self.yuanyin.delegate = self;
    self.yuanyin.inputAccessoryView = [self addToolbar];
}
- (void)configCollectionView {
    
    self.collection.dataSource = self;
    self.collection.delegate = self;
    [self.collection registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}
- (IBAction)xieyiac:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        isAgree = YES;
        [self.xieyi setImage:[UIImage imageNamed:@"勾选商品"] forState:UIControlStateNormal];
    }else {
        isAgree = NO;
        [self.xieyi setImage:[UIImage imageNamed:@"未勾选商品"] forState:UIControlStateNormal];
    }
    
}

- (void)respondsToRightBtn {
    
    if (!isAgree) {
        [NavigateManager showMessage:@"请同意退款协议"];
        return;
    }
    if (self.yuanyin.text.length == 0) {
        [NavigateManager showMessage:@"请填写退款原因"];
        return;
    }
    if (self.shijikuquan.text.length == 0) {
        [NavigateManager showMessage:@"退款额度不能为空"];
        return;
    }
    if ([self.shijikuquan.text floatValue] > [self.model.orderinfo.order_amount floatValue]) {
        [NavigateManager showMessage:@"退款额度不能大于商品金额"];
        return;
    }
    @weakify(self);
    [NavigateManager showLoadingMessage:@"保存中..."];
    
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    index = 0;
    if (_selectedPhotos.count > 0) {
        for (int i = 0; i< _selectedPhotos.count; i++) {
            
            NSData *data = UIImageJPEGRepresentation(_selectedPhotos[i], 0.6f);
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
                [dic setValue:@(self.model.orderinfo.order_id) forKey:@"orderid"];
                [dic setValue:@(self.model.goodsinfo.goods_id) forKey:@"rec_id"];
                [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                [dic setValue:self.shijikuquan.text forKey:@"refund_price"];
                NSInteger isyifu;
                if (self.typeStitc == 60) {
                    isyifu = 1;
                }else {
                    if (self.isYiFaHuo) {
                        isyifu = 2;
                    }else {
                        isyifu = 1;
                    }
                }
                
                [dic setValue:@(isyifu) forKey:@"refund_type"];
                [dic setValue:self.yuanyin.text forKey:@"reason"];
                if (urlArray.count != 0) {
                    NSString *tempString = [urlArray componentsJoinedByString:@","];//分隔符逗号
                    [dic setValue:tempString forKey:@"photu"];
                }
                NSString *url;
                if (self.isYiFaHuo) {
                    url = [HOMEURL stringByAppendingString:@"appapi/orders/tuihuokuanfahuo"];
                }else {
                    url = [HOMEURL stringByAppendingString:@"appapi/orders/tuihuokuan"];
                }
                [[RequestManager sharedManager] requestUrl:url
                                                    method:POST
                                                    loding:nil
                                                       dic:dic
                                                  progress:nil
                                                   success:^(NSURLSessionDataTask *task, id response) {
                                                       if ([response[@"code"] integerValue] == 0) {
                                                           [NavigateManager showMessage:@"s申请成功"];
                                                           
                                                           int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                                                           [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
                                                       }else {
                                                           [NavigateManager showMessage:response[@"message"]];
                                                       }
                                                       
                                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                       [NavigateManager hiddenLoadingMessage];
                                                   }];
                
            }
            
        };
    }else {
        [NavigateManager showLoadingMessage:@"正在申请。。。"];

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@(self.model.orderinfo.order_id) forKey:@"orderid"];
        [dic setValue:@(self.model.goodsinfo.rec_id) forKey:@"rec_id"];
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setValue:self.shijikuquan.text forKey:@"refund_price"];
        [dic setValue:@"" forKey:@"photu"];
        NSInteger isyifu;
        if (self.typeStitc == 60) {
            isyifu = 1;
        }else {
            if (self.isYiFaHuo) {
                isyifu = 2;
            }else {
                isyifu = 1;
            }
        }
        [dic setValue:@(isyifu) forKey:@"refund_type"];
        [dic setValue:self.yuanyin.text forKey:@"reason"];
        NSString *url;
        if (self.isYiFaHuo) {
            url = [HOMEURL stringByAppendingString:@"appapi/orders/tuihuokuanfahuo"];
        }else {
            url = [HOMEURL stringByAppendingString:@"appapi/orders/tuihuokuan"];
        }
        [[RequestManager sharedManager] requestUrl:url
                                            method:POST
                                            loding:nil
                                               dic:dic
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               if ([response[@"code"] integerValue] == 0) {
                                                   [NavigateManager showMessage:@"申请成功"];
                                                   [self popViewControllerAtLastIndex:2];
                                               }else {
                                                   [NavigateManager showMessage:response[@"message"]];
                                               }
                                               
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               [NavigateManager hiddenLoadingMessage];
                                           }];
    }

}

- (void)yiFahuoAction{
    [self setFirst:[HOMEURL stringByAppendingString:@"appapi/orders/spyhtuikuansh"]];
}
- (void)weiFahuoAction{
    [self setFirst:[HOMEURL stringByAppendingString:@"appapi/orders/spyhtuikuan"]];
}
- (void)setFirst:(NSString *)url{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@(self.id) forKey:@"rec_id"];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [[RequestManager sharedManager] requestUrl:url
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.model = [ShangchengModelTui mj_objectWithKeyValues:response[@"data"]];
                                               [self.goodsImage sd_setImageWithUrl:self.model.goodsinfo.goods_image placeHolder:[UIImage imageNamed:@"占位图片"]];
                                               self.name.text = self.model.goodsinfo.goods_name;
                                               self.priceD.text = [NSString stringWithFormat:@"¥ %@",self.model.goodsinfo.price];
                                               self.number.text = [NSString stringWithFormat:@"x %ld",self.model.goodsinfo.quantity];
                                               self.yanseChima.text = self.model.goodsinfo.specification;
                                               self.shijikuquan.text = [NSString stringWithFormat:@" %@",self.model.goodsinfo.price];
                                               self.tuikuanDetil.text = [NSString stringWithFormat:@"最多可退退%@元",self.model.goodsinfo.price];
                                           }else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       }];
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
