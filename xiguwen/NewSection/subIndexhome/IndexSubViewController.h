//
//  IndexSubViewController.h
//  BoYi
//
//  Created by heng on 2017/11/26.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <WMPageController/WMPageController.h>

@interface IndexSubViewController : WMPageController<WMMenuViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (assign ,nonatomic) NSInteger type;

@end
