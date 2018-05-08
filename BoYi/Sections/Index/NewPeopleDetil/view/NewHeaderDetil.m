//
//  NewHeaderDetil.m
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewHeaderDetil.h"
#import "UIImage+GIF.h"
@implementation NewHeaderDetil


- (IBAction)guanAC:(id)sender {
    
    [self.gotoNextVc sendNext:@1];
    
}
- (IBAction)action:(UIButton *)sender {
    
    _btnMark.selected = NO;
    sender.selected = YES;
    _btnMark = sender;
    [self.gotoNextVcBtn sendNext:@(sender.tag)];
    
}


- (RACSubject *)gotoNextVcBtn {
    
    if (!_gotoNextVcBtn) {
        _gotoNextVcBtn = [RACSubject subject];
    }
    return _gotoNextVcBtn;
    
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}
- (void)setIsMarkGuanzhu:(BOOL)isMarkGuanzhu{
    if (isMarkGuanzhu) {
        [self.guanzhuBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        
    }else {
        [self.guanzhuBtn setTitle:@"+关注" forState:UIControlStateNormal];
        
    }
}
- (void)setGetNumberString:(NSString *)getNumberString{
    _getNumberString = getNumberString;
    [self.plBtn setTitle:[NSString stringWithFormat:@"评论(%@)",getNumberString] forState:UIControlStateNormal];
}

- (void)setModel:(peopleDetailModel *)model{
    
    _model = model;
    
    
    if (![String(@"",model.user.bizCover) isBlankString]) {
        [self.headerImage sd_setImageWithUrl:String(ImageHomeURL,model.user.bizCover) placeHolder:[UIImage imageNamed:@"占位图片"]];
    }
//    if (model.comments.commentList.count > 0) {
//        [self.plBtn setTitle:[NSString stringWithFormat:@"评论(%lu)",(unsigned long)model.comments.commentList.count] forState:UIControlStateNormal];
//    }
    
    self.name.text = model.user.cnName;
    self.zhiweiTpye.text = model.channel.name;
    self.numberType.text = model.user.userType == 3 ? @"个人" : @"团队";
    self.fansNumber.text = [NSString stringWithFormat:@"粉丝数量%@",model.follow];
    if (model.productList.count > 0) {
        
        self.price.text = [NSString stringWithFormat:@"¥%ld起",model.productList[model.productList.count - 1].currentPrice];
    }
    self.width.constant = 15;
    self.imageRZOne.hidden = YES;
    self.imageRZOne.hidden = YES;
    self.imageRZOne.hidden = YES;
    
    if (model.authList.count == 1) {
        self.imageRZOne.hidden = NO;
        self.width.constant = 50;
        if (model.authList[0].authType == 1) {
            
            self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
        }else if (model.authList[0].authType == 2){
            self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
        }else {
            
            if (model.user.userType == 3) {//ge
                
                if (model.authList[0].authLevel == 1) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                }else if (model.authList[0].authLevel == 2) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                }else if (model.authList[0].authLevel == 3) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                }else if (model.authList[0].authLevel == 4) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                }else if (model.authList[0].authLevel == 5) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                }else if (model.authList[0].authLevel == 6) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                }else if (model.authList[0].authLevel == 7) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                }
                
            }else {
                if (model.authList[0].authLevel == 8) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                }else if (model.authList[0].authLevel == 9) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                }else if (model.authList[0].authLevel == 10) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                }else if (model.authList[0].authLevel == 11) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                }else if (model.authList[0].authLevel == 12) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                }else if (model.authList[0].authLevel == 13) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                }else if (model.authList[0].authLevel == 14) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                }
            }
        }
    }
    if (model.authList.count == 2) {
        self.imageRZOne.hidden = NO;
        self.imageRZtwo.hidden = NO;
        self.width.constant = 75;
        if (model.authList[0].authType == 1) {
            
            self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
        }else if (model.authList[0].authType == 2){
            self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
        }else {
            
            if (model.user.userType == 3) {//ge
                
                if (model.authList[0].authLevel == 1) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                }else if (model.authList[0].authLevel == 2) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                }else if (model.authList[0].authLevel == 3) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                }else if (model.authList[0].authLevel == 4) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                }else if (model.authList[0].authLevel == 5) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                }else if (model.authList[0].authLevel == 6) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                }else if (model.authList[0].authLevel == 7) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                }
                
            }else {
                if (model.authList[0].authLevel == 8) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                }else if (model.authList[0].authLevel == 9) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                }else if (model.authList[0].authLevel == 10) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                }else if (model.authList[0].authLevel == 11) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                }else if (model.authList[0].authLevel == 12) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                }else if (model.authList[0].authLevel == 13) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                }else if (model.authList[0].authLevel == 14) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                }
            }
        }
        
        //dierge
        if (model.authList[1].authType == 1) {
            
            self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
        }else if (model.authList[1].authType == 2){
            self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
        }else {
            
            if (model.user.userType == 3) {//ge
                
                if (model.authList[1].authLevel == 1) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                }else if (model.authList[1].authLevel == 2) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                }else if (model.authList[1].authLevel == 3) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                }else if (model.authList[1].authLevel == 4) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                }else if (model.authList[1].authLevel == 5) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                }else if (model.authList[1].authLevel == 6) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                }else if (model.authList[1].authLevel == 7) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                }
                
            }else {
                if (model.authList[1].authLevel == 8) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                }else if (model.authList[1].authLevel == 9) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                }else if (model.authList[1].authLevel == 10) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                }else if (model.authList[1].authLevel == 11) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                }else if (model.authList[1].authLevel == 12) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                }else if (model.authList[1].authLevel == 13) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                }else if (model.authList[1].authLevel == 14) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                }
            }
        }
        
    }
    if (model.authList.count == 3) {
        self.imageRZOne.hidden = NO;
        self.imageRZtwo.hidden = NO;
        self.imageRZthree.hidden = NO;
        self.width.constant = 100;
        
        if (model.authList[0].authType == 1) {
            
            self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
        }else if (model.authList[0].authType == 2){
            self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
        }else {
            
            if (model.user.userType == 3) {//ge
                
                if (model.authList[0].authLevel == 1) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                }else if (model.authList[0].authLevel == 2) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                }else if (model.authList[0].authLevel == 3) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                }else if (model.authList[0].authLevel == 4) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                }else if (model.authList[0].authLevel == 5) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                }else if (model.authList[0].authLevel == 6) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                }else if (model.authList[0].authLevel == 7) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                }
                
            }else {
                if (model.authList[0].authLevel == 8) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                }else if (model.authList[0].authLevel == 9) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                }else if (model.authList[0].authLevel == 10) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                }else if (model.authList[0].authLevel == 11) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                }else if (model.authList[0].authLevel == 12) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                }else if (model.authList[0].authLevel == 13) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                }else if (model.authList[0].authLevel == 14) {
                    self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                }
            }
        }
        
        //dierge
        if (model.authList[1].authType == 1) {
            
            self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
        }else if (model.authList[1].authType == 2){
            self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
        }else {
            
            if (model.user.userType == 3) {//ge
                
                if (model.authList[1].authLevel == 1) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                }else if (model.authList[1].authLevel == 2) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                }else if (model.authList[1].authLevel == 3) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                }else if (model.authList[1].authLevel == 4) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                }else if (model.authList[1].authLevel == 5) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                }else if (model.authList[1].authLevel == 6) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                }else if (model.authList[1].authLevel == 7) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                }
                
            }else {
                if (model.authList[1].authLevel == 8) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                }else if (model.authList[1].authLevel == 9) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                }else if (model.authList[1].authLevel == 10) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                }else if (model.authList[1].authLevel == 11) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                }else if (model.authList[1].authLevel == 12) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                }else if (model.authList[1].authLevel == 13) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                }else if (model.authList[1].authLevel == 14) {
                    self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                }
            }
        }
        //disange
        //
        if (model.authList[2].authType == 1) {
            
            self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
        }else if (model.authList[2].authType == 2){
            self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
        }else {
            
            if (model.user.userType == 3) {//ge
                
                if (model.authList[2].authLevel == 1) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                }else if (model.authList[2].authLevel == 2) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                }else if (model.authList[2].authLevel == 3) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                }else if (model.authList[2].authLevel == 4) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                }else if (model.authList[2].authLevel == 5) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                }else if (model.authList[2].authLevel == 6) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                }else if (model.authList[2].authLevel == 7) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                }
                
            }else {
                if (model.authList[2].authLevel == 8) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                }else if (model.authList[2].authLevel == 9) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                }else if (model.authList[2].authLevel == 10) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                }else if (model.authList[2].authLevel == 11) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                }else if (model.authList[2].authLevel == 12) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                }else if (model.authList[2].authLevel == 13) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                }else if (model.authList[2].authLevel == 14) {
                    self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                }
            }
        }
        
        
    }if (model.authList.count == 0) {
        self.fenView.hidden = YES;
    }
    for(UIView *view in [self.starView subviews])
    {
        [view removeFromSuperview];
    }
    if (![[NSString stringWithFormat:@"%@",model.creditData] isBlankString]) {
        int max = [[NSString stringWithFormat:@"%ld",(long)model.user.bizDealCount] intValue];
        int a = 0,b = 0,c = 0,d = 0;
        a = max / 1250;
        b = (max % 1250) / 250;
        c = (max % 1250 % 250) / 50;
        d = (max % 1250 % 250 % 50) / 10;
        for (int i = 0; i < a + b + c + d; i ++) {
            NSString *imageString;
            
            if (i > 8) {
                break;
            }
            if (i < a) {
                imageString = @"未标题-5";//zhi
            }
            if (a <= i  && i  < a + b) {
                imageString = @"未标题-2";//huang
            }
            if (i  >= a + b && i <a + b + c) {
                imageString = @"未标题-1";//zhuan
            }
            if (i  >= a + b + c && i < a + b + c + d) {
                imageString = @"未标题-3";//xing
            }
            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
            
            view.frame = CGRectMake(i * 15, 0, 13, 13);
            
            [self.starView addSubview:view];
        }
        if (max < 10 && max > 0) {
            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
            
            view.frame = CGRectMake(0, 0, 13, 13);
            
            [self.starView addSubview:view];
        }
        if (max == 10) {
            for (int i = 0; i < 2; i ++) {
                UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
                
                view.frame = CGRectMake(i * 15, 0, 13, 13);
                
                [self.starView addSubview:view];
                }
            
            } 
    }
}
@end
