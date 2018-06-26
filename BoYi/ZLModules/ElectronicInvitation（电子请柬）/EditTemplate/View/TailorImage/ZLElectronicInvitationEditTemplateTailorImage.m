//
//  ZLElectronicInvitationEditTemplateTailorImage.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/25.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditTemplateTailorImage.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation ZLElectronicInvitationEditTemplateImageModel

@end

@interface ZLElectronicInvitationEditTemplateTailorImage ()

///背景图
@property (nonatomic,weak) UIImageView *bgImageView;
///背景图改变后的frame（每次改变结束后，会对其进行赋值）
@property (nonatomic,unsafe_unretained) CGRect bgImagedidChangeFrame;
///背景图frame（初始的、不变的）
@property (nonatomic,unsafe_unretained) CGRect fixedBgImageOriginalFrame;
///灰色蒙版
@property (nonatomic,weak) UIView *hudView;
///裁剪后的图片展示视图
@property (nonatomic,weak) UIImageView *tailorImageView;
///裁剪框
@property (nonatomic,weak) UIButton *tailorBoxButton;
///缩放比例（控件frame映射在图片上后的位置及尺寸比例值）
@property (nonatomic,unsafe_unretained) CGFloat zoomScale;
///缩放手势产生的总比例
@property (nonatomic,unsafe_unretained) CGFloat zoomScaleValue;
///上次的缩放总比例
@property (nonatomic,unsafe_unretained) CGFloat lastZoomScaleValue;
///平移手势的上一次的平移点
@property (nonatomic,unsafe_unretained) CGPoint panLastPoint;
///上次的旋转值
@property (nonatomic,unsafe_unretained) CGFloat lastRotation;
///原始的图片
@property (nonatomic,strong) UIImage *originalImage;

///工具条
@property (nonatomic,weak) UIView *toolBar;
///结果
@property (nonatomic,copy) void (^results)(ZLElectronicInvitationEditTemplateImageModel *imageModel);

@end

@implementation ZLElectronicInvitationEditTemplateTailorImage

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.zoomScaleValue = 1.0;
        self.lastZoomScaleValue = 1.0;
        self.backgroundColor = UIColor.blackColor;
        [self bgImageView];
        [self hudView];
        [self tailorImageView];
        [self configGestureRecognizer];
        [self tailorBoxButton];
        [self toolBar];
    }
    return self;
}

#pragma mark - Public
+ (void)showTailorImageViewInSuperView:(UIView *)superView Image:(UIImage *)image Scale:(CGFloat)scale Results:(void (^)(ZLElectronicInvitationEditTemplateImageModel *imageModel))complete {
    ZLElectronicInvitationEditTemplateTailorImage *tailorView = [[self alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    tailorView.originalImage = image;
    tailorView.results = complete;
    tailorView.bgImageView.frame = [tailorView frameFromImage:image];
    tailorView.bgImagedidChangeFrame = tailorView.bgImageView.frame;
    tailorView.fixedBgImageOriginalFrame = tailorView.bgImagedidChangeFrame;
    tailorView.bgImageView.image = image;
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    CGFloat height = screenSize.width * scale;
    tailorView.tailorBoxButton.frame = CGRectMake(0, (screenSize.height - height) / 2, screenSize.width, height);
    CGFloat tailorImageHeight = tailorView.bgImageView.frame.size.height > tailorView.tailorBoxButton.frame.size.height
    ? tailorView.tailorBoxButton.frame.size.height
    : tailorView.bgImageView.frame.size.height;
    tailorView.tailorImageView.frame = CGRectMake(tailorView.bgImageView.frame.origin.x, (screenSize.height - tailorImageHeight) / 2, tailorView.bgImageView.frame.size.width, tailorImageHeight);
    tailorView.tailorImageView.image = image.size.height > height
    ? [tailorView resetTailorImage]
    : image;
    [superView addSubview:tailorView];
    [tailorView show];
}

#pragma mark - Lazy
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        bgImageView.clipsToBounds = NO;
        [self addSubview:bgImageView];
        _bgImageView = bgImageView;
    }
    return _bgImageView;
}
- (UIView *)hudView {
    if (!_hudView) {
        UIView *hudView = [[UIView alloc] initWithFrame:self.bounds];
        hudView.backgroundColor = UIColor.blackColor;
        hudView.alpha = 0.7;
        [self addSubview:hudView];
        _hudView = hudView;
    }
    return _hudView;
}
- (UIImageView *)tailorImageView {
    if (!_tailorImageView) {
        UIImageView *tailorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:tailorImageView];
        _tailorImageView = tailorImageView;
    }
    return _tailorImageView;
}
- (UIButton *)tailorBoxButton {
    if (!_tailorBoxButton) {
        UIButton *tailorBoxButton = [[UIButton alloc] initWithFrame:CGRectZero];
        tailorBoxButton.layer.borderColor = UIColor.whiteColor.CGColor;
        tailorBoxButton.layer.borderWidth = 1.0;
        [self addSubview:tailorBoxButton];
        _tailorBoxButton = tailorBoxButton;
    }
    return _tailorBoxButton;
}
- (UIView *)toolBar {
    if (!_toolBar) {
        CGFloat height = 60;
        UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - height, CGRectGetWidth(self.frame), 60.0)];
        toolBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
        
        NSArray *frames = @[[NSValue valueWithCGRect:CGRectMake(15.0, 0, height, height)],[NSValue valueWithCGRect:CGRectMake(CGRectGetWidth(toolBar.frame) - 15.0 - height, 0, height, height)]];
        NSArray *titles = @[@"取消",@"确定"];
        for (NSInteger index = 0; index < 2; index++) {
            UIButton *sender = [[UIButton alloc] initWithFrame:[frames[index] CGRectValue]];
            [sender setTitle:titles[index] forState:UIControlStateNormal];
            sender.tag = 100 + index;
            [sender addTarget:self action:@selector(senderAction:) forControlEvents:UIControlEventTouchUpInside];
            [toolBar addSubview:sender];
        }

        [self addSubview:toolBar];
        _toolBar = toolBar;
    }
    return _toolBar;
}

#pragma mark - Separate
- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    }];
}
- (void)configGestureRecognizer {
    UIPanGestureRecognizer *panGr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self addGestureRecognizer:panGr];
    UIPinchGestureRecognizer *pinchGr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [self addGestureRecognizer:pinchGr];
    UIRotationGestureRecognizer *rotationGr = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationView:)];
    [self addGestureRecognizer:rotationGr];
}
- (CGRect)frameFromImage:(UIImage *)image {
    CGSize imageSize = image.size;
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    if (imageSize.width > screenSize.width) {
        width = screenSize.width;
        CGFloat scaleValue = screenSize.width / imageSize.width;
        self.zoomScale = scaleValue;
        height = imageSize.height * scaleValue;
        y = height > screenSize.height
        ? -((height - screenSize.height) / 2)
        : (screenSize.height - height) / 2;
        return CGRectMake(x, y, width, height);
    }
    width = imageSize.width;
    height = imageSize.height;
    self.zoomScale = 1.0;
    x = (screenSize.width - width) / 2;
    y = (screenSize.height - height) / 2;
    return CGRectMake(x, y, width, height);
}
- (UIImage *)resetTailorImage {
    CGRect futureImageInOriginalImageFrame = CGRectZero;
    CGRect frame = [self convertRect:self.tailorBoxButton.frame toView:self.bgImageView];
    if (self.bgImageView.image.size.width > frame.size.width) {//图片宽度大于裁剪框，取到缩放倍数，进行比例赋值
        CGRect frame = [self convertRect:self.tailorBoxButton.frame toView:self.bgImageView];
        CGFloat x = frame.origin.x / self.zoomScale / self.zoomScaleValue;
        CGFloat y = frame.origin.y / self.zoomScale / self.zoomScaleValue;
        CGFloat width = frame.size.width / self.zoomScale / self.zoomScaleValue;
        CGFloat height = frame.size.height / self.zoomScale / self.zoomScaleValue;
        futureImageInOriginalImageFrame = CGRectMake(x, y, width, height);
    }else {//图片宽度小于裁剪框，原始位置赋值
        CGFloat rotationZoomScale = self.originalImage.size.width / self.bgImageView.image.size.width;
        CGFloat width = frame.size.width / self.zoomScaleValue / rotationZoomScale;
        CGFloat height = frame.size.height / self.zoomScaleValue / rotationZoomScale;
        CGFloat x = 0;
        if (self.bgImageView.frame.size.width > frame.size.width) {
            x = frame.origin.x / self.zoomScaleValue / rotationZoomScale;
        }
        CGFloat y = (CGRectGetMinY(self.tailorBoxButton.frame) - CGRectGetMinY(self.bgImageView.frame)) / self.zoomScaleValue / rotationZoomScale;
        futureImageInOriginalImageFrame = CGRectMake(x, y, width, height);
    }
    CGImageRef originalImage_CG = self.bgImageView.image.CGImage;
    CGImageRef futureImageRef = CGImageCreateWithImageInRect(originalImage_CG, futureImageInOriginalImageFrame);
    CGSize size = CGSizeMake(futureImageInOriginalImageFrame.size.width, futureImageInOriginalImageFrame.size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, futureImageInOriginalImageFrame, futureImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:futureImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(futureImageRef);
    return smallImage;
}
- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, UIScreen.mainScreen.bounds.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (NSString *)MD5:(NSString *)stirng {
    const char *cStr = [stirng UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

#pragma mark - Action
- (void)senderAction:(UIButton *)sender {
    if (sender.tag == 100) {//取消
        [self dismiss];
        return;
    }
    //确认
    UIImage *image = self.tailorImageView.image;
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
    ZLElectronicInvitationEditTemplateImageModel *imageModel=[[ZLElectronicInvitationEditTemplateImageModel alloc] init];
    imageModel.image = image;
    imageModel.imageData=imageData;
    imageModel.imagePath=imgPath;
    imageModel.imageType=imageType;
    if (self.results) {
        self.results(imageModel);
        [self dismiss];
    }
}
- (void)panView:(UIPanGestureRecognizer *)pan {
    //只有宽或高超出裁剪框的尺寸，才有必要滑动
    if (self.bgImageView.frame.size.width > self.tailorBoxButton.frame.size.width
        || self.bgImageView.frame.size.height > self.tailorBoxButton.frame.size.height) {
        CGPoint point = [pan translationInView:pan.view];
        if (self.bgImageView.frame.size.width > self.tailorBoxButton.frame.size.width
            && self.bgImageView.frame.size.height > self.tailorBoxButton.frame.size.height) {//宽高都超出
            CGFloat offsetX = self.bgImagedidChangeFrame.origin.x + point.x;
            if (offsetX >= CGRectGetMinX(self.tailorBoxButton.frame)) {
                offsetX = CGRectGetMinX(self.tailorBoxButton.frame);
            }
            if (offsetX <= -(self.bgImageView.frame.size.width - CGRectGetMaxX(self.tailorBoxButton.frame))) {
                offsetX = -(self.bgImageView.frame.size.width - CGRectGetMaxX(self.tailorBoxButton.frame));
            }
            CGFloat offsetY = self.bgImagedidChangeFrame.origin.y + point.y;
            if (offsetY > CGRectGetMinY(self.tailorBoxButton.frame)) {
                offsetY = CGRectGetMinY(self.tailorBoxButton.frame);
            }
            CGFloat y = CGRectGetMaxY(self.tailorBoxButton.frame) - CGRectGetHeight(self.bgImageView.frame);
            if (offsetY < y) {
                offsetY = y;
            }
            self.bgImageView.frame = CGRectMake(offsetX, offsetY, self.bgImageView.frame.size.width, self.bgImageView.frame.size.height);
        }else if (self.bgImageView.frame.size.height > self.tailorBoxButton.frame.size.height) {//高超出
            CGFloat offsetY = self.bgImagedidChangeFrame.origin.y + point.y;
            if (offsetY > CGRectGetMinY(self.tailorBoxButton.frame)) {
                offsetY = CGRectGetMinY(self.tailorBoxButton.frame);
            }
            CGFloat y = CGRectGetMaxY(self.tailorBoxButton.frame) - CGRectGetHeight(self.bgImageView.frame);
            if (offsetY < y) {
                offsetY = y;
            }
            CGFloat x = (self.tailorBoxButton.frame.size.width - self.bgImageView.frame.size.width) / 2;
            self.bgImageView.frame = CGRectMake(x, offsetY, self.bgImageView.frame.size.width, self.bgImageView.frame.size.height);
        }else {//宽超出
            CGFloat offsetX = self.bgImagedidChangeFrame.origin.x + point.x;
            if (offsetX > CGRectGetMinX(self.tailorBoxButton.frame)) {
                offsetX = CGRectGetMinX(self.tailorBoxButton.frame);
            }
            if (offsetX < -(self.bgImageView.frame.size.width - CGRectGetMaxX(self.tailorBoxButton.frame))) {
                offsetX = -(self.bgImageView.frame.size.width - CGRectGetMaxX(self.tailorBoxButton.frame));
            }
            CGFloat y = (UIScreen.mainScreen.bounds.size.height - self.bgImageView.frame.size.height) / 2;
            self.bgImageView.frame = CGRectMake(offsetX, y, self.bgImageView.frame.size.width, self.bgImageView.frame.size.height);
        }
        self.tailorImageView.image = [self resetTailorImage];
        if (pan.state == UIGestureRecognizerStateEnded) {
            self.bgImagedidChangeFrame = self.bgImageView.frame;
        }
    }
}
- (void)pinchView:(UIPinchGestureRecognizer *)pinch {
    CGFloat maxScale = 3.0;
    CGFloat minScale = 0.5;
    if (pinch.scale > 1.0) {//放大
        if (self.bgImageView.frame.size.width > self.fixedBgImageOriginalFrame.size.width * maxScale) {
            self.tailorImageView.image = [self resetTailorImage];
            if (pinch.state == UIGestureRecognizerStateEnded) {
                self.lastZoomScaleValue = self.zoomScaleValue;
                self.bgImagedidChangeFrame = self.bgImageView.frame;
            }
            return;
        }
        CGFloat curentZoomScaleValue = (pinch.scale - 1.0);
        self.zoomScaleValue = self.lastZoomScaleValue + curentZoomScaleValue;
        CGFloat zoomWidth = curentZoomScaleValue * self.fixedBgImageOriginalFrame.size.width;
        CGFloat zoomHeight = curentZoomScaleValue * self.fixedBgImageOriginalFrame.size.height;
        CGFloat width = self.bgImagedidChangeFrame.size.width + zoomWidth;
        CGFloat height = self.bgImagedidChangeFrame.size.height + zoomHeight;
        CGFloat x = self.bgImagedidChangeFrame.origin.x - zoomWidth / 2;
        CGFloat y = self.bgImagedidChangeFrame.origin.y - zoomHeight / 2;
        self.bgImageView.frame = CGRectMake(x, y, width, height);
        if (self.bgImageView.frame.size.width < UIScreen.mainScreen.bounds.size.width) {//背景图处于小图时处理
            height = height < CGRectGetHeight(self.tailorBoxButton.frame)
            ? height
            : CGRectGetHeight(self.tailorBoxButton.frame);
            y = (UIScreen.mainScreen.bounds.size.height - height) / 2;
            self.tailorImageView.frame = CGRectMake(x, y, width, height);
        }else {//背景图处于大图时处理
            self.tailorImageView.frame = CGRectMake(self.tailorBoxButton.frame.origin.x, (UIScreen.mainScreen.bounds.size.height - self.tailorBoxButton.frame.size.height) / 2, self.tailorBoxButton.frame.size.width, self.tailorBoxButton.frame.size.height);
        }
    }else {//缩小
        if (self.bgImageView.frame.size.width < self.fixedBgImageOriginalFrame.size.width * minScale) {
            self.tailorImageView.image = [self resetTailorImage];
            if (pinch.state == UIGestureRecognizerStateEnded) {
                self.lastZoomScaleValue = self.zoomScaleValue;
                self.bgImagedidChangeFrame = self.bgImageView.frame;
            }
            return;
        }
        CGFloat curentZoomScaleValue = (1.0 - pinch.scale);
        self.zoomScaleValue = self.lastZoomScaleValue - curentZoomScaleValue;
        CGFloat zoomWidth = curentZoomScaleValue * self.fixedBgImageOriginalFrame.size.width;
        CGFloat zoomHeight = curentZoomScaleValue * self.fixedBgImageOriginalFrame.size.height;
        CGFloat width = self.bgImagedidChangeFrame.size.width - zoomWidth;
        CGFloat height = self.bgImagedidChangeFrame.size.height - zoomHeight;
        if (self.bgImageView.frame.size.width < UIScreen.mainScreen.bounds.size.width) {//背景图处于小图时处理
            CGFloat x = (CGRectGetWidth(self.tailorBoxButton.frame) - width) / 2;
            CGFloat y = self.bgImagedidChangeFrame.origin.y + zoomHeight / 2;
            CGFloat maxY = y + height;
            if (maxY > CGRectGetMaxY(self.tailorBoxButton.frame) && y >= CGRectGetMinY(self.tailorBoxButton.frame)) {//只缩减下边
                y = CGRectGetMinY(self.tailorBoxButton.frame);
            }else if (y < CGRectGetMinY(self.tailorBoxButton.frame) && maxY <= CGRectGetMaxY(self.tailorBoxButton.frame)) {//只缩减上边
                y = self.bgImagedidChangeFrame.origin.y + zoomHeight;
            }
            if (height < CGRectGetHeight(self.tailorBoxButton.frame)) {
                y = (UIScreen.mainScreen.bounds.size.height - height) / 2;
            }
            self.bgImageView.frame = CGRectMake(x, y, width, height);
            height = height < CGRectGetHeight(self.tailorBoxButton.frame)
            ? height
            : CGRectGetHeight(self.tailorBoxButton.frame);
            y = (UIScreen.mainScreen.bounds.size.height - height) / 2;
            self.tailorImageView.frame = CGRectMake(x, y, width, height);
        }else {//背景图处于大图时处理
            CGFloat x = self.bgImagedidChangeFrame.origin.x + zoomWidth / 2;
            CGFloat y = self.bgImagedidChangeFrame.origin.y + zoomHeight / 2;
            CGFloat maxX= x + width;
            if (maxX > CGRectGetMaxX(self.tailorBoxButton.frame) && x >= CGRectGetMinX(self.tailorBoxButton.frame)) {//只缩减右边
                x = 0;
            }else if (x < CGRectGetMinX(self.tailorBoxButton.frame) && maxX <= CGRectGetMaxX(self.tailorBoxButton.frame)) {//只缩减左边
                x = self.bgImagedidChangeFrame.origin.x + zoomWidth;
            }
            CGFloat maxY = y + height;
            if (maxY > CGRectGetMaxY(self.tailorBoxButton.frame) && y >= CGRectGetMinY(self.tailorBoxButton.frame)) {//只缩减下边
                y = CGRectGetMinY(self.tailorBoxButton.frame);
            }else if (y < CGRectGetMinY(self.tailorBoxButton.frame) && maxY <= CGRectGetMaxY(self.tailorBoxButton.frame)) {//只缩减上边
                y = self.bgImagedidChangeFrame.origin.y + zoomHeight;
            }
            self.bgImageView.frame = CGRectMake(x, y, width, height);
            self.tailorImageView.frame = CGRectMake(self.tailorBoxButton.frame.origin.x, self.tailorBoxButton.frame.origin.y, self.tailorBoxButton.frame.size.width, self.tailorBoxButton.frame.size.height);
        }
    }
    self.tailorImageView.image = [self resetTailorImage];
    if (pinch.state == UIGestureRecognizerStateEnded) {
        self.lastZoomScaleValue = self.zoomScaleValue;
        self.bgImagedidChangeFrame = self.bgImageView.frame;
    }
}
- (void)rotationView:(UIRotationGestureRecognizer *)rotation {
    CGFloat currentRotation = self.lastRotation + rotation.rotation;
    int roundNumber = floor(currentRotation / (M_PI * 2));
    currentRotation = !roundNumber ? currentRotation : currentRotation - roundNumber * M_PI * 2;
    CGSize rotatedBoxSize = CGSizeMake(self.originalImage.size.width, self.originalImage.size.height);
    UIGraphicsBeginImageContext(rotatedBoxSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, rotatedBoxSize.width / 2, rotatedBoxSize.height / 2);
    CGContextRotateCTM(context, currentRotation);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(-self.originalImage.size.width / 2, -self.originalImage.size.height / 2, self.originalImage.size.width, self.originalImage.size.height), [self.originalImage CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.bgImageView.image = newImage;
    self.tailorImageView.image = [self resetTailorImage];
    if (rotation.state == UIGestureRecognizerStateEnded) {
        self.lastRotation = currentRotation;
    }
}

//6.283
@end
