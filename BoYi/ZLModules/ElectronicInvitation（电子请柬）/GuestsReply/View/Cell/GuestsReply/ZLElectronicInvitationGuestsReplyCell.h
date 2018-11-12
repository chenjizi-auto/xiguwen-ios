//
//  ZLElectronicInvitationGuestsReplyCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLElectronicInvitationGuestsReplyModel.h"

@interface ZLElectronicInvitationGuestsReplyCell : UITableViewCell

///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath InfoModel:(ZLElectronicInvitationGuestsReplyModel *)infoModel;

@end
