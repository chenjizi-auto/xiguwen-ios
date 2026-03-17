//
//  Util.m
//  Medication
//
//  Created by zhaoxiaoling on 15/7/3.
//  Copyright (c) 2015年 bode. All rights reserved.
//

#import "Util.h"
#import <objc/runtime.h>
#import <execinfo.h>
#import <fcntl.h>
#import <limits.h>
#import <signal.h>
#import <string.h>
#import <sys/stat.h>
#import <unistd.h>

@implementation Util

+(NSString*)AsciiFromString:(NSString*)string
{
    NSMutableString *str = [NSMutableString new];
    
    const char *ch = [string cStringUsingEncoding:NSASCIIStringEncoding];
    for (int i = 0; i < strlen(ch); i++)
    {
//        printf("%d", [string characterAtIndex:i]);
        
        int code = [string characterAtIndex:i]+10;
        
        NSString *string = [NSString stringWithFormat:@"%c", code];
        
        [str appendString:string];
    }
    return str;
}

+(void)showMessage:(NSString*)string
{
    if (string.length>0)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setNumberOfLines:0];
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        CGSize labelsize = [self returnCGSizeWithString:string];
        [label setFrame:CGRectMake((ScreenWidth-labelsize.width-20)/2, (ScreenHeight-labelsize.height-10)/2, labelsize.width+20, labelsize.height+10)];
        label.text  = string;
        label.backgroundColor  = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.layer.borderWidth   = 1;
        label.layer.cornerRadius  = 5;
        label.layer.masksToBounds = true;
        label.font  = font;
        label.alpha = 0;
        label.textAlignment  = NSTextAlignmentCenter;
        [[[UIApplication sharedApplication] delegate].window addSubview:label];
        [UIView animateWithDuration:0.3 animations:^{
            label.alpha = 1;
        } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:.3 delay:2 options:0 animations:^{
                 label.alpha = 0;
             } completion:^(BOOL finished) {
                 [label removeFromSuperview];
             }];
         }];
    }
}
/**隐藏显示提示标签*/
+(void)timerForLabelHandle:(id)sender
{
    __block  UILabel  *label  = (UILabel*)[sender userInfo];
    [UIView animateWithDuration:0.3 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished)
     {
         [label removeFromSuperview];
     }];
}

+(BOOL)validateRegix:(NSString*)rex withString:(NSString*)string
{
    NSPredicate *regix = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",rex];
    if ([regix evaluateWithObject:string]==YES)
    {
        return YES;
    }
    return NO;
}

+(CGSize)returnCGSizeWithString:(NSString*)string
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

+(CGSize)returnCGSizeWithString:(NSString*)string withFont:(UIFont*)font
{
    if ([string isKindOfClass:[NSNull class]])
    {
        return CGSizeZero;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(NSString *)getUUID
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"uuid"] length]==0)
    {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        //    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"uuid"];
        return result;
    }
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"uuid"];
}

//定位后存放城市Id
+(void)setCityNumber:(NSString*)cityName withCityArray:(NSArray*)array
{
    if (array.count>0)
    {
        BOOL haveTrue = NO;
        for (NSDictionary *obj in array)
        {
            if ([obj[@"cityName"] isEqualToString:cityName])
            {
                haveTrue    = YES;
                [[NSUserDefaults standardUserDefaults]setObject:obj[@"id"] forKey:@"cityNum"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                break;
            }
        }
        if (!haveTrue)
        {
            [[NSUserDefaults standardUserDefaults]setObject:array[0][@"id"] forKey:@"cityNum"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"cityNum"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

//获取城市Id
+(NSString*)getCityNumber
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"cityNum"])
    {
        return [[NSUserDefaults standardUserDefaults]objectForKey:@"cityNum"];
    }
    return @"1";
}

//将时间戳转为标准时间
+(NSString*)dateFromTimeStamp:(NSString*)timeStamp
{
    if ([timeStamp isKindOfClass:[NSNull class]] || timeStamp == nil)
    {
        return @"";
    }
    
    NSTimeInterval timeInterval = [timeStamp doubleValue];
    NSDateFormatter* formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSString *systemTime        = [formatter stringFromDate:date];
    return systemTime;
}

//计算两个日期相差的天数
+(NSInteger)getDaysNumberStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [dateFormatter dateFromString:startTime];
    NSDate *dateToString = [dateFormatter dateFromString:endTime];
    NSTimeInterval timediff = [dateToString timeIntervalSince1970]-[dateFromString timeIntervalSince1970];
    if (timediff > 0 && timediff < 86400) {
        return 1;
    }else if (timediff / 86400 > 1) {
        return timediff / ( 24 * 60 * 60 )+1;
    }else{
        return timediff / ( 24 * 60 * 60 );
    }
}


#pragma mark - 判断一个字符串是否全是汉字
+ (BOOL)isAllChineseCharacters:(NSString *)string
{
    for (int i = 0; i < string.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [string substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) != 3)
        {
            return NO;
        }
        
    }
    
    return YES;
}

#pragma mark - 判断一个字符串是否全是数字
+ (BOOL)isAllNumber:(NSString *)string
{
    for (int i = 0; i < string.length; i++) {
        unichar cString = [string characterAtIndex:i];
        if (!isdigit(cString)) {
            return NO;
        }
    }
    return YES;
}

@end

#pragma mark - NIMKit Emoticon Safe

@implementation UIImage (NIMKitSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = object_getClass(self);
        SEL originalSelector = @selector(nim_emoticonInKit:);
        SEL swizzledSelector = @selector(nim_safe_emoticonInKit:);
        Method originalMethod = class_getClassMethod(cls, originalSelector);
        Method swizzledMethod = class_getClassMethod(cls, swizzledSelector);
        if (originalMethod && swizzledMethod) {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

+ (UIImage *)nim_safe_emoticonInKit:(NSString *)imageName {
    @try {
        return [self nim_safe_emoticonInKit:imageName];
    } @catch (__unused NSException *exception) {
        UIImage *image = nil;
        if (imageName.length > 0) {
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"NIMKitEmoticon" ofType:@"bundle"];
            if (bundlePath.length > 0) {
                NSBundle *emojiBundle = [NSBundle bundleWithPath:bundlePath];
                NSString *name = [@"Emoji" stringByAppendingPathComponent:imageName];
                image = [UIImage imageNamed:name inBundle:emojiBundle compatibleWithTraitCollection:nil];
                if (!image) {
                    image = [UIImage imageNamed:imageName inBundle:emojiBundle compatibleWithTraitCollection:nil];
                }
            }
            if (!image) {
                image = [UIImage imageNamed:imageName];
            }
        }
        return image ?: [self nim_safe_emptyImage];
    }
}

+ (UIImage *)nim_safe_emptyImage {
    static UIImage *image = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return image;
}

@end

#pragma mark - QMUI NavigationBar Safe

@implementation UINavigationBar (QMUISafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [UINavigationBar class];
        SEL originalSelector = @selector(qmui_contentView);
        SEL swizzledSelector = @selector(qmui_safe_contentView);
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
        if (originalMethod && swizzledMethod) {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (UIView *)qmui_safe_contentView {
    UIView *view = nil;
    @try {
        view = [self qmui_safe_contentView];
    } @catch (__unused NSException *exception) {
        view = [self qmui_fallbackContentView];
    }
    if (!view) {
        view = [self qmui_fallbackContentView];
    }
    return view;
}

- (UIView *)qmui_fallbackContentView {
    for (UIView *subview in self.subviews) {
        NSString *className = NSStringFromClass([subview class]);
        if ([className containsString:@"UINavigationBarContentView"] ||
            [className containsString:@"NavigationBarContent"] ||
            [className containsString:@"BarContentView"]) {
            return subview;
        }
    }
    for (UIView *subview in self.subviews) {
        NSString *className = NSStringFromClass([subview class]);
        if ([className containsString:@"ContentView"] && ![className containsString:@"UIVisualEffect"]) {
            return subview;
        }
    }
    return self.subviews.count > 0 ? self.subviews.lastObject : nil;
}

@end

#pragma mark - AppLogManager

static NSString *g_runtimeLogPath = nil;
static char g_crashSignalPath[PATH_MAX] = {0};

static NSString *AppLogTimestampString(void) {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyyMMdd_HHmmss";
    });
    return [formatter stringFromDate:[NSDate date]];
}

static NSString *AppLogDirectory(void) {
    NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [documents stringByAppendingPathComponent:@"AppLogs"];
}

static void AppLogEnsureDirectory(void) {
    NSString *dir = AppLogDirectory();
    [[NSFileManager defaultManager] createDirectoryAtPath:dir
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
}

static NSString *AppLogRuntimeFilePath(void) {
    if (g_runtimeLogPath.length == 0) {
        NSString *fileName = [NSString stringWithFormat:@"run_%@.log", AppLogTimestampString()];
        g_runtimeLogPath = [AppLogDirectory() stringByAppendingPathComponent:fileName];
    }
    return g_runtimeLogPath;
}

static NSString *AppLogCrashFilePath(void) {
    NSString *fileName = [NSString stringWithFormat:@"crash_%@.log", AppLogTimestampString()];
    return [AppLogDirectory() stringByAppendingPathComponent:fileName];
}

static void AppLogWriteCrashLog(NSString *content) {
    if (content.length == 0) {
        return;
    }
    NSString *path = AppLogCrashFilePath();
    [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

static void AppLogSignalHandler(int signalCode) {
    int fd = open(g_crashSignalPath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        signal(signalCode, SIG_DFL);
        raise(signalCode);
        return;
    }
    
    char header[256];
    int headerLen = snprintf(header, sizeof(header), "Signal %d was raised.\n", signalCode);
    if (headerLen > 0) {
        write(fd, header, (size_t)headerLen);
    }
    
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **symbols = backtrace_symbols(callstack, frames);
    if (symbols) {
        for (int i = 0; i < frames; i++) {
            size_t len = strlen(symbols[i]);
            if (len > 0) {
                write(fd, symbols[i], len);
                write(fd, "\n", 1);
            }
        }
        free(symbols);
    }
    close(fd);
    
    signal(signalCode, SIG_DFL);
    raise(signalCode);
}

static void AppLogExceptionHandler(NSException *exception) {
    NSArray<NSString *> *stack = exception.callStackSymbols ?: @[];
    NSString *content = [NSString stringWithFormat:
                         @"Date: %@\nName: %@\nReason: %@\nUserInfo: %@\nCallStack:\n%@\n",
                         [NSDate date],
                         exception.name ?: @"",
                         exception.reason ?: @"",
                         exception.userInfo ?: @{},
                         [stack componentsJoinedByString:@"\n"]];
    AppLogWriteCrashLog(content);
}

@implementation AppLogManager

+ (void)startLogging {
    AppLogEnsureDirectory();
    
    NSString *runtimePath = AppLogRuntimeFilePath();
    const char *path = runtimePath.fileSystemRepresentation;
    if (path && strlen(path) > 0) {
        freopen(path, "a+", stderr);
        freopen(path, "a+", stdout);
        setvbuf(stdout, NULL, _IOLBF, 0);
        setvbuf(stderr, NULL, _IOLBF, 0);
    }
    
    NSString *signalPath = [AppLogDirectory() stringByAppendingPathComponent:@"crash_signal.log"];
    strncpy(g_crashSignalPath, signalPath.fileSystemRepresentation, sizeof(g_crashSignalPath) - 1);
    
    NSSetUncaughtExceptionHandler(&AppLogExceptionHandler);
    signal(SIGABRT, AppLogSignalHandler);
    signal(SIGILL, AppLogSignalHandler);
    signal(SIGSEGV, AppLogSignalHandler);
    signal(SIGFPE, AppLogSignalHandler);
    signal(SIGBUS, AppLogSignalHandler);
    signal(SIGPIPE, AppLogSignalHandler);
}

+ (NSString *)logDirectory {
    AppLogEnsureDirectory();
    return AppLogDirectory();
}

+ (NSArray<NSURL *> *)sortedLogFileURLs {
    AppLogEnsureDirectory();
    NSURL *dirURL = [NSURL fileURLWithPath:AppLogDirectory() isDirectory:YES];
    NSArray<NSURL *> *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:dirURL
                                                           includingPropertiesForKeys:@[NSURLContentModificationDateKey]
                                                                              options:0
                                                                                error:nil];
    NSMutableArray<NSURL *> *logFiles = [NSMutableArray array];
    for (NSURL *url in files) {
        if ([[url.pathExtension lowercaseString] isEqualToString:@"log"]) {
            [logFiles addObject:url];
        }
    }
    [logFiles sortUsingComparator:^NSComparisonResult(NSURL * _Nonnull a, NSURL * _Nonnull b) {
        NSDate *dateA = nil;
        NSDate *dateB = nil;
        [a getResourceValue:&dateA forKey:NSURLContentModificationDateKey error:nil];
        [b getResourceValue:&dateB forKey:NSURLContentModificationDateKey error:nil];
        return [dateB compare:dateA];
    }];
    return [logFiles copy];
}

@end
