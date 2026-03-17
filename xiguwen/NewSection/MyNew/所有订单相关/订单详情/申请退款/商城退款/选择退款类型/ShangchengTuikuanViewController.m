//
//  ShangchengTuikuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengTuikuanViewController.h"
#import "ShangChengTuikuanTwoViewController.h"
@interface ShangchengTuikuanViewController ()

@end

@implementation ShangchengTuikuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择退款类型";
    [self addPopBackBtn];
    
    [self.goodsImage sd_setImageWithUrl:self.model.goods_image placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = self.model.goods_name;
    self.priceD.text = [NSString stringWithFormat:@"¥ %@",self.model.price];
    self.number.text = [NSString stringWithFormat:@"x %ld",self.model.quantity];
    self.yanseChima.text = self.model.specification;
}
- (IBAction)actionAll:(UIButton *)sender {
   
    if (sender.tag == 0) {//都收货
        ShangChengTuikuanTwoViewController *tui = [[ShangChengTuikuanTwoViewController alloc] init];
        tui.isYiFaHuo =  NO;//仅退钱
        tui.typeStitc = self.type;
        tui.id = self.model.goods_id;
        [self pushToNextVCWithNextVC:tui];
        
    }else {//退货物  已收货
        ShangChengTuikuanTwoViewController *tui = [[ShangChengTuikuanTwoViewController alloc] init];
        tui.isYiFaHuo =  YES;
        tui.typeStitc = self.type;
        tui.id = self.model.goods_id;
        [self pushToNextVCWithNextVC:tui];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
