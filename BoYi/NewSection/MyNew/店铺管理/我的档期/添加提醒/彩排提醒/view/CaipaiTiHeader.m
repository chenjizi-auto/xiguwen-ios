//
//  CaipaiTiHeader.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CaipaiTiHeader.h"

@implementation CaipaiTiHeader

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		
		if (self.model) {
			// 如果实在修改状态就添加原本信息
			
			
		}
		
		
	}
	return self;
}



- (IBAction)action:(UIButton *)sender {
    [self.selectBtnSubject sendNext:nil];
}




- (RACSubject *)selectBtnSubject {
    
    if (!_selectBtnSubject) _selectBtnSubject = [RACSubject subject];
    
    return _selectBtnSubject;
}

@end
