//
//  NewHeaderDetil.h
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "peopleDetailModel.h"

@interface NewHeaderDetil : UIView{
    UIButton *_btnMark;
}
@property (strong, nonatomic) RACSubject *gotoNextVc;
@property (strong, nonatomic) RACSubject *gotoNextVcBtn;
@property (strong, nonatomic) peopleDetailModel *model;
@property (assign, nonatomic) BOOL isMarkGuanzhu;

@property (weak, nonatomic) IBOutlet UIImageView *imageRZOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageRZtwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageRZthree;
@property (weak, nonatomic) IBOutlet UIView *fenView;

@property (weak, nonatomic) IBOutlet UIView *starView;

@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *guanzhuBtn;


@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *zhiweiTpye;
@property (weak, nonatomic) IBOutlet UILabel *numberType;
@property (weak, nonatomic) IBOutlet UILabel *fansNumber;

@property (weak, nonatomic) IBOutlet UIButton *plBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) NSString *getNumberString;

@end
