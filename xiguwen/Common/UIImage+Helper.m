//
//  UIImage+Helper.m
//  BoYi
//
//  Created by Niklaus on 2018/3/30.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "UIImage+Helper.h"



static NSString *urlStr;
@implementation UIImage (Helper)

#pragma mark - 将图片转换为URL
+ (void)urlWithBase64Image:(UIImage *)image complete:(GetImageUrlBlock)complete {
	
	NSData *data = UIImageJPEGRepresentation(image, 0.6f);
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
	NSData *data = [NSData dataWithContentsOfURL:url];
	NSDictionary *dic = @{@"file":data};
	[[RequestManager sharedManager] requestUrl:URL_videoUpload
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
@end
