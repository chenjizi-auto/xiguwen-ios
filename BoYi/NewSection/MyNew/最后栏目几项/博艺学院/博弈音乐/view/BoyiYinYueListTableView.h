//
//  BoyiYinYueListTableView.h
//  BoYi
//
//  Created by zhoumeineng on 3/22/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoyiYinYueModel.h"
typedef void(^HeaderBlock)(NSString*title);
@interface BoyiYinYueListTableView : UITableView
@property(nonatomic,setter=setTablData:,copy) NSArray<NSArray<BoyiYinYueModel*>*> * dataSources;
@property(nonatomic,strong)HeaderBlock Mblock;
@end
