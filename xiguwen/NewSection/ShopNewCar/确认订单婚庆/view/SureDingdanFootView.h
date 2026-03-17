//
//  SureDingdanFootView.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SureDingdanFootView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *words;

@property (weak, nonatomic) IBOutlet UILabel *peisong;
@property (weak, nonatomic) IBOutlet UILabel *price;

///保存备注
@property (nonatomic,copy) void (^saveNote)(NSString *note);

@end
