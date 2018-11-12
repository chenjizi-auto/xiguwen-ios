//
//  SureDingdanHQFootView.m
//  BoYi
//
//  Created by heng on 2018/3/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SureDingdanHQFootView.h"

@implementation SureDingdanHQFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    self.words.delegate = self;
    self.words.inputAccessoryView = [self addToolbar];
}
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 35)];
    toolbar.tintColor = MAINCOLOR;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}
- (void)textFieldDone{
    if (self.saveNote) {
        self.saveNote(self.words.text);
    }
    [self endEditing:YES];
}
@end
