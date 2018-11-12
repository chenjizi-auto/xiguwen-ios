//
//  BoyiShiPingType.m
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPingType.h"
#import "UIButton+BaseButton.h"
#import "BoyiShiPinModel.h"
@interface BoyiShiPingType()<UISearchBarDelegate>
@end
@implementation BoyiShiPingType
{
    @private
    UIButton * selectedButton;
    UISearchBar * searBar;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)SHIpingTypeNumber:(NSArray*)number{
    
    UIButton * spreadOutButton = [[UIButton alloc]initWithFrame: CGRectMake(self.frame.size.width - 8-5, (60-5), 8, 5)];
    [self addSubview:spreadOutButton];
    [spreadOutButton addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i=0; i<number.count; i++) {
       UIButton * button = [UIButton buttonType:CGRectMake(16+(16+70)*(i%4), 16+(16+28)*(i/4), 70, 28)];
        BoyShiPingTypeMode * mode = number[i];
        [button setTitle:mode.title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000+mode.id;
        
        if (i==0) [self BtnAction:button];
        [self addSubview:button];
    }

    
   searBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20,  CGRectGetMaxY([self viewWithTag:1000+ ((BoyShiPingTypeMode*)number.lastObject).id].frame)+10, ScreenWidth - 40 , 34)];
    searBar.placeholder = @"输入关键字";
    searBar.barTintColor = [UIColor whiteColor];
    searBar.searchBarStyle = UISearchBarStyleDefault;
    searBar.layer.cornerRadius = 17;
    searBar.layer.masksToBounds = YES;
    searBar.layer.borderWidth = 1;
    searBar.layer.borderColor = RGBA(217, 217, 217, 217).CGColor;
    searBar.delegate = self;
    [self addSubview:searBar];
}

- (void)BtnAction:(UIButton*)icon{
    
    if (icon.tag>=1000) {
        if (selectedButton) {selectedButton.backgroundColor = RGBA(255, 244, 247, 1); [selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];}
        icon.backgroundColor = RGBA(255, 114, 153, 1);
        [icon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectedButton = icon;
    }else{
        CGFloat height = self.frame.size.height;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height==60?height:60);
        }];
    }
    self.Mblock(icon);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  self.searchBlock(searchBar.text);
    [searchBar endEditing:YES];
}
- (void)CanBegcomFouce{
    [searBar endEditing:YES];
}
@end
