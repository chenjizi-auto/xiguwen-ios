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

//范围
@property (strong ,nonatomic) NSString *scope;
//当前城市名
@property (strong ,nonatomic) NSString *currentCityName;

@property (strong,nonatomic)NSString *type;

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@property (weak, nonatomic) IBOutlet IB_DESIGN_View *cityView;
@end
