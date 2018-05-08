//
//  SearchSubViewController.h
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "WMPageController.h"
#import "SearchsjViewController.h"
#import "SearchalViewController.h"
@interface SearchSubViewController : WMPageController<WMMenuViewDataSource,UITextFieldDelegate>
@property (strong ,nonatomic) NSString *content;
@property (strong,nonatomic)NSString *type;

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@property (weak, nonatomic) IBOutlet IB_DESIGN_View *cityView;
@end
