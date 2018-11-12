//
//  ZLElectronicInvitationShareInvitationSelectImage.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationShareInvitationSelectImage.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation ZLElectronicInvitationShareInvitationSelectImageModel

@end

@interface ZLElectronicInvitationShareInvitationSelectImage ()<UINavigationControllerDelegate>

//代理
@property(nonatomic, weak) id <ZLElectronicInvitationShareInvitationSelectImageDelegate>delegate;

@end

@implementation ZLElectronicInvitationShareInvitationSelectImage

static ZLElectronicInvitationShareInvitationSelectImage *manager = nil;

#pragma mark 唤起选择事件
- (void)updateHeadPictureWithDelegate:(id<ZLElectronicInvitationShareInvitationSelectImageDelegate>)delegate{
    self.delegate = delegate;
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* photographAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self photograph];
    }];
    [alertController addAction:photographAction];
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self fromPhotoAlbumSelected];
    }];
    [alertController addAction:defaultAction1];
    UIAlertAction* fromPhotoAlbumSelectedAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    [alertController addAction:fromPhotoAlbumSelectedAction];
    [(UIViewController *)delegate presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 相机
- (void)photograph {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
        imagePickerController.sourceType= UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate=self;
        imagePickerController.allowsEditing = YES;
        [(UIViewController *)self.delegate presentViewController:imagePickerController animated:YES completion:nil];
    }else {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备没有照相机" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:sureAction];
        [(UIViewController *)self.delegate presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 图库
- (void)fromPhotoAlbumSelected {
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [(UIViewController *)self.delegate presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate  选择结果的返回
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEndSelectedImageWithImage:)]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!image) {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有识别该图片格式" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:sureAction];
            [(UIViewController *)self.delegate presentViewController:alertController animated:YES completion:nil];
            return;
        }
        NSData* imageData =nil;
        NSString *imageType=nil;
        NSString *type=nil;
        imageData = UIImageJPEGRepresentation(image, 0.3);
        imageType=@"image/jpeg";
        type=@".jpeg";
        NSString *path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imgDiretory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"CaseImg"]];
        if (![[NSFileManager defaultManager] fileExistsAtPath:imgDiretory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:imgDiretory withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *name=[self MD5:[NSString stringWithFormat:@"%d",arc4random()%((int)MAXFLOAT)]];//得到一个唯一的名称
        NSString *imgPath = [imgDiretory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",name,type]];
        [imageData writeToFile:imgPath atomically:YES];
        ZLElectronicInvitationShareInvitationSelectImageModel *imageModel=[[ZLElectronicInvitationShareInvitationSelectImageModel alloc] init];
        imageModel.image=image;
        imageModel.imageData=imageData;
        imageModel.imagePath=imgPath;
        imageModel.imageType=imageType;
        [self.delegate didEndSelectedImageWithImage:imageModel];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

///加密字符串
- (NSString *)MD5:(NSString *)stirng {
    const char *cStr = [stirng UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

@end
