//
//  YJCropView.m
//  Base
//
//  Created by junzong on 2016/9/22.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "YJCropView.h"
#import "YJCropImageView.h"

@interface YJCropView ()

@property (weak, nonatomic) IBOutlet YJCropImageView *cropImageView;

@end

@implementation YJCropView

- (instancetype)initWithFrame:(CGRect)frame originalImage:(UIImage *)originalImage imageType:(NSString *)imageType cropSize:(CGSize)cropSize cropImageBlock:(CropImageBlock)cropImageBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YJCropView" owner:self options:nil] firstObject];
        self.frame = frame;
        _cropImageBlock = cropImageBlock;
        [_cropImageView setCropSize:cropSize];
        [_cropImageView setImage:originalImage jpgOrPng:imageType];
    }
    return self;
}

#pragma mark - 取消
- (IBAction)cancelEvent:(UIButton *)sender {
    [self removeFromSuperview];
}

#pragma mark - 保存
- (IBAction)saveEvent:(UIButton *)sender {
    _cropImageBlock([_cropImageView cropImage]);
    [self removeFromSuperview];
}


@end
