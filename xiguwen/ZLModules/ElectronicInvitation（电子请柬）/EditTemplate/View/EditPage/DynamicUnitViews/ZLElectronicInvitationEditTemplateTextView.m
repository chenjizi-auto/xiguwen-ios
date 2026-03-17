//
//  ZLElectronicInvitationEditTemplateTextView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditTemplateTextView.h"

@implementation ZLElectronicInvitationEditTemplateTextView

- (UIButton *)placeholderImageButton {
    if (!_placeholderImageButton) {
        UIButton *sender = [[UIButton alloc] initWithFrame:self.bounds];
        sender.userInteractionEnabled = NO;
        UIImage *image = [UIImage imageNamed:@"图片文字框.9"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width / 2 - 1.0, 0, image.size.width / 2 + 1.0) resizingMode:(UIImageResizingModeStretch)];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        [self addSubview:sender];
        _placeholderImageButton = sender;
    }
    return _placeholderImageButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"图片文字框.9"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width / 2 - 1.0, 0, image.size.width / 2 + 1.0) resizingMode:(UIImageResizingModeStretch)];
    [self.placeholderImageButton setBackgroundImage:image forState:UIControlStateNormal];
    self.placeholderImageButton.frame = self.bounds;
}

@end
