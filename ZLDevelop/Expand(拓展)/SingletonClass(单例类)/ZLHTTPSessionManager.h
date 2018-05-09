//
//  ZLHTTPSessionManager.h
//  BoYi
//
//  Created by zhaolei on 2018/5/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

///请求失败状态
typedef NS_ENUM (NSInteger , ZLSessionManagerErrorState){
    ///请求正常
    ZLSessionManagerErrorStateNull = 0,
    ///服务器挂掉、访问地址不存在
    ZLSessionManagerErrorStateServerFailure ,
    ///超时
    ZLSessionManagerErrorStateTimeout ,
    ///断网
    ZLSessionManagerErrorStateNoNetwork
};

@interface ZLFileModel : NSObject

///图片
@property (nonatomic,strong) UIImage *fileImage;
///文件二进制
@property (nonatomic,strong) NSData *fileData;
///文件沙盒路径
@property (nonatomic,strong) NSString *filePath;
///文件类型
@property (nonatomic,strong) NSString *fileType;
///文件名称（上传时根据需要传入）
@property (nonatomic,strong) NSString *fileName;

@end

@interface ZLHTTPSessionManager : NSObject

///当前环境
@property (nonatomic,strong) NSString *currentUrlPath;
///上次因token时间过期而保存的参数信息
@property (nonatomic,strong) NSMutableArray *lastErrorParamsM;
///登录时（正在登陆期间）
@property (nonatomic,unsafe_unretained) BOOL isLogining;

/**POST请求
 *@param path 路径
 *@param dict 参数
 *@param isPost POST/GET
 *@param modelArray 图片数据
 *@param isAddHeader 是否添加Header
 *@param complete 处理结果
 */
+ (void)requestDataWithUrlPath:(NSString *)path Params:(id)dict POST:(BOOL)isPost ModelArray:(NSArray <ZLFileModel *>*)modelArray HttpHeader:(BOOL)isAddHeader Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, id responseObject))complete;

@end
