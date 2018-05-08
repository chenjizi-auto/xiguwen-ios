//
//  HeaderView.h
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindXinXiModel.h"

@interface HeaderView : UIView{
    
}
@property (strong, nonatomic) NSString *shangjiaID;

@property (strong, nonatomic) RACSubject *gotoNextVc;


@property (strong, nonatomic) FindXinXiModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *blackImage;

@property (weak, nonatomic) IBOutlet UIImageView *headimage;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *shangjiaName;

//@property (weak, nonatomic) IBOutlet UIImageView *imageRZOne;
//@property (weak, nonatomic) IBOutlet UIImageView *imageRZtwo;
//@property (weak, nonatomic) IBOutlet UIImageView *imageRZthree;
//
//@property (weak, nonatomic) IBOutlet UIView *starView;
@end
