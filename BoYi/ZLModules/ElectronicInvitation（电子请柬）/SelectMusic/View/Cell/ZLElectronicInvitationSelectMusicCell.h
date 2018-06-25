//
//  ZLElectronicInvitationSelectMusicCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLElectronicInvitationSelectMusicCell : UITableViewCell

///标题
@property (nonatomic,weak) UIButton *titleButton;
///选中状态
@property (nonatomic,unsafe_unretained) BOOL didSelected;

@end
