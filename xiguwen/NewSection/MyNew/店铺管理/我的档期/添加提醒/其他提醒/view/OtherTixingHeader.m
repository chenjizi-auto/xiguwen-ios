//
//  OtherTixingHeader.m
//  BoYi
//
//  Created by heng on 2018/1/19.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "OtherTixingHeader.h"

@implementation OtherTixingHeader

- (IBAction)action:(UIButton *)sender {
    [self.selectBtnSubject sendNext:nil];
}

- (RACSubject *)selectBtnSubject {
    
    if (!_selectBtnSubject) _selectBtnSubject = [RACSubject subject];
    
    return _selectBtnSubject;
}
@end
