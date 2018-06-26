//
//  ZLElectronicInvitationEditTemplateSelectImage.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditTemplateSelectImage.h"

@interface ZLElectronicInvitationEditTemplateSelectImage ()<UINavigationControllerDelegate>

//代理
@property(nonatomic, weak) id <ZLElectronicInvitationEditTemplateSelectImageDelegate>delegate;

@end

@implementation ZLElectronicInvitationEditTemplateSelectImage

static ZLElectronicInvitationEditTemplateSelectImage *manager = nil;

#pragma mark 唤起选择事件
- (void)updateHeadPictureWithDelegate:(id<ZLElectronicInvitationEditTemplateSelectImageDelegate>)delegate{
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
        if (@available(iOS 11.0, *)) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
        }
        UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
        imagePickerController.sourceType= UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate=self;
        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
    }else {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备没有照相机" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:sureAction];
        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 图库
- (void)fromPhotoAlbumSelected {
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate  选择结果的返回
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEndSelectedImageWithImage:)]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        image = [self fixOrientation:image];
        [self.delegate didEndSelectedImageWithImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/** 纠正图片的方向 */
- (UIImage *)fixOrientation:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    
    switch (image.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}



@end
