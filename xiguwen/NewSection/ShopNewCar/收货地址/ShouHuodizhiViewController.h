//
//  ShouHuodizhiViewController.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
#import "ShouHuodizhiModel.h"

@interface ShouHuodizhiViewController : FatherViewController

///已经获得的模型
@property (nonatomic,copy) void (^didGetModel)(Addressarray *model);

@end
