//
//  UIImage+Helper.m
//  BoYi
//
//  Created by Niklaus on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "UIImage+Helper.h"
#import <AVFoundation/AVFoundation.h>



static NSString *urlStr;
@implementation UIImage (Helper)

+ (UIImage *)cw_scaledImageForUpload:(UIImage *)image maxPixel:(CGFloat)maxPixel {
	if (image == nil) {
		return nil;
	}
	CGFloat longestSide = MAX(image.size.width, image.size.height);
	if (longestSide <= maxPixel || longestSide <= 0.0f) {
		return image;
	}
	CGFloat scale = maxPixel / longestSide;
	CGSize targetSize = CGSizeMake(floor(image.size.width * scale), floor(image.size.height * scale));
	UIGraphicsBeginImageContextWithOptions(targetSize, NO, 1.0);
	[image drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return scaledImage ?: image;
}

+ (NSData *)cw_JPEGDataForImage:(UIImage *)image quality:(CGFloat)quality {
	return UIImageJPEGRepresentation(image, MIN(MAX(quality, 0.1f), 1.0f));
}

+ (NSData *)cw_uploadImageDataFromImage:(UIImage *)image {
	if (image == nil) {
		return nil;
	}
	UIImage *scaledImage = [self cw_scaledImageForUpload:image maxPixel:2560.0f];
	NSData *bestData = [self cw_JPEGDataForImage:scaledImage quality:0.92f];
	if (bestData.length <= 1500 * 1024) {
		return bestData;
	}
	CGFloat low = 0.7f;
	CGFloat high = 0.92f;
	for (NSInteger i = 0; i < 6; i++) {
		CGFloat mid = (low + high) / 2.0f;
		NSData *candidate = [self cw_JPEGDataForImage:scaledImage quality:mid];
		if (candidate.length > 1500 * 1024) {
			high = mid;
			bestData = candidate;
		} else {
			low = mid;
			bestData = candidate;
		}
	}
	if (bestData.length > 2500 * 1024) {
		UIImage *smallerImage = [self cw_scaledImageForUpload:scaledImage maxPixel:1920.0f];
		NSData *fallbackData = [self cw_JPEGDataForImage:smallerImage quality:0.82f];
		if (fallbackData.length > 0) {
			bestData = fallbackData;
		}
	}
	return bestData;
}

+ (NSString *)cw_mimeTypeForVideoURL:(NSURL *)url {
	NSString *extension = url.pathExtension.lowercaseString;
	if ([extension isEqualToString:@"mov"]) {
		return @"video/quicktime";
	}
	if ([extension isEqualToString:@"m4v"]) {
		return @"video/x-m4v";
	}
	if ([extension isEqualToString:@"mp4"]) {
		return @"video/mp4";
	}
	return @"application/octet-stream";
}

+ (void)cw_uploadVideoDataForURL:(NSURL *)url completion:(void (^)(NSData *data, NSString *fileName, NSString *mimeType))completion {
	if (url == nil) {
		if (completion) {
			completion(nil, @"video.mp4", @"video/mp4");
		}
		return;
	}
	AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
	NSArray<NSString *> *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:asset];
	NSString *preset = [compatiblePresets containsObject:AVAssetExportPreset1920x1080] ? AVAssetExportPreset1920x1080 : AVAssetExportPresetHighestQuality;
	AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:preset];
	if (session == nil) {
		NSData *data = [NSData dataWithContentsOfURL:url];
		if (completion) {
			completion(data, url.lastPathComponent.length > 0 ? url.lastPathComponent : @"video.mp4", [self cw_mimeTypeForVideoURL:url]);
		}
		return;
	}
	NSString *outputFileName = [NSString stringWithFormat:@"cw_upload_%@.mp4", NSUUID.UUID.UUIDString];
	NSString *outputPath = [NSTemporaryDirectory() stringByAppendingPathComponent:outputFileName];
	[[NSFileManager defaultManager] removeItemAtPath:outputPath error:nil];
	session.outputURL = [NSURL fileURLWithPath:outputPath];
	session.shouldOptimizeForNetworkUse = YES;
	if ([[session supportedFileTypes] containsObject:AVFileTypeMPEG4]) {
		session.outputFileType = AVFileTypeMPEG4;
	} else {
		session.outputFileType = session.supportedFileTypes.firstObject;
	}
	[session exportAsynchronouslyWithCompletionHandler:^{
		dispatch_async(dispatch_get_main_queue(), ^{
			if (session.status == AVAssetExportSessionStatusCompleted) {
				NSData *data = [NSData dataWithContentsOfURL:session.outputURL];
				NSString *mimeType = [self cw_mimeTypeForVideoURL:session.outputURL];
				if (completion) {
					completion(data, session.outputURL.lastPathComponent.length > 0 ? session.outputURL.lastPathComponent : outputFileName, mimeType);
				}
			} else {
				NSData *data = [NSData dataWithContentsOfURL:url];
				if (completion) {
					completion(data, url.lastPathComponent.length > 0 ? url.lastPathComponent : @"video.mp4", [self cw_mimeTypeForVideoURL:url]);
				}
			}
		});
	}];
}

#pragma mark - 将图片转换为URL
+ (void)urlWithBase64Image:(UIImage *)image complete:(GetImageUrlBlock)complete {
	
	NSData *data = [self cw_uploadImageDataFromImage:image];
	NSString *imageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
	NSDictionary *dic = @{@"img":[@"data:image/png;base64," stringByAppendingString:imageStr]};
	[[RequestManager sharedManager] requestUrl:URL_base64Upload
										method:POST
										loding:@""
										   dic:dic
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   urlStr = response[@"data"];
										   complete(YES,response[@"data"]);
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   complete(NO,nil);
									   }];
}

#pragma mark - 将视频地址转为URL
+ (void)urlWithNSURL:(NSURL *)url complete:(GetImageUrlBlock)complete {
	[self cw_uploadVideoDataForURL:url completion:^(NSData *data, NSString *fileName, NSString *mimeType) {
		[[RequestManager sharedManager] uploadFileData:data
												   url:URL_videoUpload
												  name:@"file"
											  fileName:fileName
											  mimeType:mimeType
											  progress:nil
											   success:^(NSURLSessionDataTask *task, id response) {
												   urlStr = response[@"data"];
												   complete(YES,response[@"data"]);
											   } failure:^(NSURLSessionDataTask *task, NSError *error) {
												   complete(NO,nil);
											   }];
	}];

}
@end
