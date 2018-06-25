//
//  ZLElectronicInvitationEditTemplateButton.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/14.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditTemplateButton.h"

@implementation ZLElectronicInvitationEditTemplateButton

- (UIButton *)placeholderImageButton {
    if (!_placeholderImageButton) {
        UIButton *sender = [[UIButton alloc] initWithFrame:self.bounds];
        sender.userInteractionEnabled = NO;
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"编辑图片.png"];
        [sender setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        [self addSubview:sender];
        _placeholderImageButton = sender;
    }
    return _placeholderImageButton;
}

@end
