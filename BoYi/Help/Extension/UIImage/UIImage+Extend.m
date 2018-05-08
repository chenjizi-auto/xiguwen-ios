//
//  UIImage+Extend.m
//  CDHN
//
//  Created by muxi on 14-10-14.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import "UIImage+Extend.h"
#import <objc/runtime.h>

static const void *CompleteBlockKey = &CompleteBlockKey;
static const void *FailBlockKey = &FailBlockKey;

@interface UIImage ()

@property (nonatomic,copy)  void(^CompleteBlock)();

@property (nonatomic,copy)  void(^FailBlock)();

@end


@implementation UIImage (Extend)

/**
 *  拉伸图片
 */
#pragma mark  拉伸图片:自定义比例
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * leftCap topCapHeight:image.size.height * topCap];
}




#pragma mark  拉伸图片
+(UIImage *)resizeWithImageName:(NSString *)name{
    
    return [self resizeWithImageName:name leftCap:.5f topCap:.5f];

}


//按指定大小压缩图片
+ (UIImage *)compressImage:(UIImage *)imgSrc size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGRect rect = {{0,0}, size};
    [imgSrc drawInRect:rect];
    UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return compressedImg;
}


/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param completeBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock{
    
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
    
    self.CompleteBlock = completeBlock;
    self.FailBlock = failBlock;
}




- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error == nil){
        if(self.CompleteBlock != nil) self.CompleteBlock();
    }else{
        if(self.FailBlock !=nil) self.FailBlock();
    }

}

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name {
    
    return [UIImage sd_animatedGIFWithData:UIImagePNGRepresentation([UIImage imageNamed:name])];
}

/*
 *  模拟成员变量
 */
-(void (^)())FailBlock{
    return objc_getAssociatedObject(self, FailBlockKey);
}
-(void)setFailBlock:(void (^)())FailBlock{
    objc_setAssociatedObject(self, FailBlockKey, FailBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void (^)())CompleteBlock{
    return objc_getAssociatedObject(self, CompleteBlockKey);
}

-(void)setCompleteBlock:(void (^)())CompleteBlock{
    objc_setAssociatedObject(self, CompleteBlockKey, CompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}






//指定宽度按比例缩放
- (UIImage *)imageCompressWithTargetWidth:(CGFloat)defineWidth
{
    
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    //解决模糊失真问题
//    if ([[UIScreen mainScreen] scale] == 2.0) {
//        
//    }else{
//        UIGraphicsBeginImageContext(size);
//    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)addlogoImage:(UIImage *)resizedImage
{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    
    [resizedImage drawInRect:CGRectMake((self.size.width - resizedImage.size.width)/2,
                                        (self.size.height - resizedImage.size.height)/2,
                                        resizedImage.size.width,
                                        resizedImage.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
    
}
@end
