//
//  YJCropViewController.m
//  Base
//
//  Created by junzong on 2016/9/22.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "YJCropViewController.h"
#import "YJCropImageView.h"

@interface YJCropViewController ()

@property (weak, nonatomic) IBOutlet YJCropImageView *cropImageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGSize cropSize;
@property (nonatomic, strong) NSString *imageType;

@end

@implementation YJCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_cropImageView setCropSize:_cropSize];
    [_cropImageView setImage:_image jpgOrPng:_imageType];
}

- (instancetype)initWithOriginalImage:(UIImage *)originalImage imageType:(NSString *)imageType cropSize:(CGSize)cropSize cropImageBlock:(CropImageBlock)cropImageBlock
{
    self = [super init];
    if (self) {
        _image = originalImage;
        _cropSize = cropSize;
        _imageType = imageType;
        _cropImageBlock = cropImageBlock;
    }
    return self;
}

#pragma mark - 取消
- (IBAction)cancelEvent:(UIButton *)sender {
    [self backOnViewController];
}

#pragma mark - 保存
- (IBAction)saveEvent:(UIButton *)sender {
    _cropImageBlock([_cropImageView cropImage]);
    [self backOnViewController];
}

#pragma mark - 返回上一个控制器（判断是push还是present进入）
- (void)backOnViewController
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1) {
        if ([viewControllers objectAtIndex:viewControllers.count - 1] == self) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
