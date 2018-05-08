//
//  HeaderView.m
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "HeaderView.h"
#import "UIImage+GIF.h"

@implementation HeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shangjiaID = @"";
    
}

- (IBAction)MyDetail:(UIButton *)sender {
    
    [self.gotoNextVc sendNext:self.shangjiaID];
    
}

- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

- (void)setModel:(FindXinXiModel *)model{
    
    _model = model;
    self.shangjiaID = [NSString stringWithFormat:@"%ld",model.userInfoBvo.id];
    
   [[NSString stringWithFormat:@"%@",model.userInfoBvo.bizCover] isBlankString] ? @"" : [self.headimage sd_setImageWithUrl:String(ImageHomeURL,model.userInfoBvo.bizCover) placeHolder:[UIImage imageNamed:@"占位图片"]];
    [[NSString stringWithFormat:@"%@",model.imgUrl] isBlankString] ? @"" : [self.blackImage sd_setImageWithUrl:String(ImageHomeURL,model.imgUrl) placeHolder:[UIImage imageNamed:@"占位图片"]];
    
    self.address.text = [[NSString stringWithFormat:@"%@",model.caseHotel] isBlankString] ? @"暂无" : model.caseHotel;
    self.time.text = [[NSString stringWithFormat:@"%@",model.caseTime] isBlankString] ? @"暂无" : model.caseTime;
    self.name.text = [[NSString stringWithFormat:@"%@",model.name] isBlankString] ? @"暂无" : model.name;
    self.shangjiaName.text = [[NSString stringWithFormat:@"%@",model.userInfoBvo.cnName] isBlankString] ? @"暂无" : model.userInfoBvo.cnName;
    
//    NSArray  *array = [model.orderDesn componentsSeparatedByString:@","];
//    
//    if (array.count == 1 ) {
//        self.imageRZOne.hidden = NO;
//      
//        self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
//    }
//    if (array.count == 2 ) {
//        self.imageRZOne.hidden = NO;
//        self.imageRZtwo.hidden = NO;
//        self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
//        self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
//        
//    }
//    if (array.count == 3 ) {
//        self.imageRZOne.hidden = NO;
//        self.imageRZtwo.hidden = NO;
//        self.imageRZthree.hidden = NO;
//        
//        self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
//        self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
//        self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
//     
//    }
//    if (model.descn.length > 4 ) {
//    
//        for (int i = 0; i < 9; i ++) {
//            
//      
//            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-5"]];
//            
//            view.frame = CGRectMake(i * 15, 0, 13, 13);
//            
//            [self.starView addSubview:view];
//        }
//
//        
//    }
//    
//    if (model.descn.length == 4) {
//        int k, m,j,n;
//        k = [[model.descn substringToIndex:1] intValue];
//        m = [[model.descn substringWithRange:NSMakeRange(1, 1)] intValue];
//        j = [[model.descn substringWithRange:NSMakeRange(2, 1)] intValue];
//        n = [[model.descn substringFromIndex:3] intValue];
//        for (int i = 0; i < k + m + j + n; i ++) {
//            NSString *imageString;
//            if (i < k) {
//                imageString = @"未标题-5";//huang
//            }
//            if (k <= i  && i  < k + m) {
//                imageString = @"未标题-2";//xing
//            }
//            if (i  >= k + m && i < k +m + j) {
//                imageString = @"未标题-1";//zhuan
//            }
//            if (i  >= k +m + j && i < k +m + j + n) {
//                imageString = @"未标题-3";//zhuan
//            }
//            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
//            
//            view.frame = CGRectMake(i * 15, 0, 13, 13);
//            
//            [self.starView addSubview:view];
//        }
//    }
//    
//    if (model.descn.length == 3) {
//        int k, m,j;
//        k = [[model.descn substringToIndex:1] intValue];
//        m = [[model.descn substringWithRange:NSMakeRange(1, 1)] intValue];
//        j = [[model.descn substringFromIndex:2] intValue];
//        
//        for (int i = 0; i < k + m + j; i ++) {
//            NSString *imageString;
//            if (i < k) {
//                imageString = @"未标题-2";//huang
//            }
//            if (k <= i  && i  < k + m) {
//                imageString = @"未标题-1";//xing
//            }
//            if (i  >= k + m) {
//                imageString = @"未标题-3";//zhuan
//            }
//            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
//            
//            view.frame = CGRectMake(i * 15, 0, 13, 13);
//            
//            [self.starView addSubview:view];
//        }
//    }
//    
//    if (model.descn.length == 2) {
//        
//        int k, j;
//        k = [[model.descn substringToIndex:1] intValue];
//        j = [[model.descn substringFromIndex:1] intValue];
//        
//        for (int i = 0; i < k + j; i ++) {
//            
//            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:i + 1 > k ? @"未标题-3" : @"未标题-1"]];
//            
//            view.frame = CGRectMake(i * 15, 0, 13, 13);
//            
//            [self.starView addSubview:view];
//        }
//    }
//    
//    if (model.descn.length == 1) {
//        for (int i = 0; i < [model.descn intValue]; i ++) {
//            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
//            
//            view.frame = CGRectMake(i * 15, 0, 13, 13);
//            
//            [self.starView addSubview:view];
//        }
//    }
//    if (model.descn.length == 0) {
//        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
//        
//        view.frame = CGRectMake(15, 0, 13, 13);
//        
//        [self.starView addSubview:view];
//    }

}

@end
