//
//  UIImageView+Extra.m
//  XinxunIOS
//
//  Created by sunny on 14-10-29.
//  Copyright (c) 2014年 zy168. All rights reserved.
//

#import "UIImageView+Extra.h"
//#import <UIImageView+AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <objc/runtime.h>

static UIImage *NTESPlaceholderImage(UIImage *image) {
    return image ?: IMAGE_NAME(@"占位图片");
}

static NSString *NTESNormalizedImageURLString(NSString *url) {
    if (![url isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSString *trimmed = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimmed.length == 0) {
        return nil;
    }
    if (![trimmed hasPrefix:@"http://"] && ![trimmed hasPrefix:@"https://"]) {
        trimmed = [NSString stringWithFormat:@"http://oss.40yue.com/%@", trimmed];
    }
    return [trimmed stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@implementation UIImageView (Extra)

- (void)setRadius {
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.height/2;
}

- (void)setImage9Grid:(UIImage*)image {
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [self setImage:image];
}

- (void)loadImageURL:(NSString *)url
{
    //    if (![url isKindOfClass:[NSNull class]]) {
    //        [self sd_setImageWithURL:[NSURL URLWithString:url]
    //                placeholderImage:[UIImage imageNamed:@"默认头像"]
    //                         options:SDWebImageRetryFailed];
    //    } else {
    //        [self sd_setImageWithURL:[NSURL URLWithString:@""]
    //                placeholderImage:[UIImage imageNamed:@"默认头像"]
    //                         options:SDWebImageRetryFailed];
    //    }
}


- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)sd_setImageWithActivityAndURL:(NSString *)url PlaceHolder:(UIImage *)image {
    
    //    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeHolder"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    __weak typeof(self) weakSelf = self;;
    [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            weakSelf.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                
                weakSelf.alpha = 1.0f;
                
            }];
        }
        else
        {
            weakSelf.alpha = 1.0f;
        }
        
        
        if (!image) {
            dispatch_main_async_safe(^{
                weakSelf.image = BANNERPLACEHOLDERIMAGE;//[UIImage imageNamed:@"placeHolder"];
                //                [[SDImageCache sharedImageCache] clearMemory];
            });
        }
    }];
}

- (void)sd_setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image {
    UIImage *placeholder = NTESPlaceholderImage(image);
    NSString *urlString = NTESNormalizedImageURLString(url);
    if (urlString.length == 0) {
        self.image = placeholder;
        return;
    }

    SDWebImageOptions options = SDWebImageRetryFailed;
    if ([urlString hasPrefix:@"https://"]) {
        options |= SDWebImageAllowInvalidSSLCertificates;
    }

    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:urlString]
            placeholderImage:placeholder
                     options:options
                   completed:^(UIImage * _Nullable loadedImage, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!loadedImage || error) {
            weakSelf.image = placeholder;
        }
    }];
}
- (void)sd_setImageWithUrl:(NSString *)url {
    [self sd_setImageWithUrl:url placeHolder:IMAGE_NAME(@"占位图片")];
}


- (void)sd_setImageWithActivityAndURLStringForProduct:(NSString *)url {
    
    //    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeHolder"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    __weak typeof(self) weakSelf = self;;
    [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (!image) {
            dispatch_main_async_safe(^{
                weakSelf.image = [UIImage imageNamed:@"placeHolder"];
                //                [[SDImageCache sharedImageCache] clearMemory];
            });
        }
    }];
}

- (void)sd_setImageWithActivityAndURLString:(NSString *)url complete:(void(^)())loadImageFilish {
    
    //    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeHolder"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    __weak typeof(self) weakSelf = self;;
    [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) {
            dispatch_main_async_safe(^{
                weakSelf.image = [UIImage imageNamed:@"placeHolder"];
                //                [[SDImageCache sharedImageCache] clearMemory];
            });
        }
        loadImageFilish();
    }];
}
- (void)sd_setImageWithActivityAndURLStringForProduct:(NSString *)url complete:(void(^)())loadImageFilish {
    
    //    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    __weak typeof(self) weakSelf = self;;
    [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) {
            dispatch_main_async_safe(^{
                weakSelf.image = [UIImage imageNamed:@"default"];
                //                [[SDImageCache sharedImageCache] clearMemory];
            });
        }
        loadImageFilish();
    }];
}
- (void)sd_setImageWithActivityAndURLString:(NSString *)url width:(CGFloat)width height:(CGFloat)height {
    
    //    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeHolder"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //    url = [NSString stringWithFormat:@"%@?path=%@&&width=%.f&height=%.f",URI_GetImage,url,width,height];
    //    __weak typeof(self) weakSelf = self;;
    //    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        if (!image) {
    //            dispatch_main_async_safe(^{
    //                weakSelf.image = [UIImage imageNamed:@"placeHolder"];
    //            });
    //        }
    //    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}
- (void)sd_setImageWithActivityAndURLString:(NSString *)url percent:(NSInteger)percent {
    //    __weak typeof(self) weakSelf = self;;
    //    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        if (!image) {
    //            dispatch_main_async_safe(^{
    //                weakSelf.image = [UIImage imageNamed:@"placeHolder"];
    //            });
    //        }
    //    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    //    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeHolder"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //    url = [NSString stringWithFormat:@"%@?path=%@&&percent=%@",URI_GetRatioImage,url,[NSNumber numberWithInteger:percent]];
    //    __weak typeof(self) weakSelf = self;;
    //    [self setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        if (!image) {
    //            dispatch_main_async_safe(^{
    //                weakSelf.image = [UIImage imageNamed:@"placeHolder"];
    //            });
    //        }
    //    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
}

- (void)addTap_click:(ClickBlock)block {
    
    self.userInteractionEnabled = YES;
    self.block = block;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTap_clicked)];
    [self addGestureRecognizer:tap];
    
}
- (void)addTap_clicked {
    if (self.block) {
        self.block();
    }
}

static NSString *strKey = @"strKey";

-(void)setBlock:(ClickBlock)block
{
    objc_setAssociatedObject(self, &strKey, block, OBJC_ASSOCIATION_COPY);
}

- (ClickBlock)block
{
    return objc_getAssociatedObject(self, &strKey);
}
@end
