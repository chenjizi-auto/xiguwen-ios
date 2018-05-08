//
//  DipuNameChangeViewController.m
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DipuNameChangeViewController.h"
#import "DipuDataModel.h"
@interface DipuNameChangeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *TextField;
@property(nonatomic,strong)DipuDataModel *VieWmodel;
@end

@implementation DipuNameChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.Ntitle;
    [self addPopBackBtn];
    [self VieWmodel];
    self.TextField.delegate = self;
    self.TextField.inputAccessoryView = [self addToolbar];
  

    // Do any additional setup after loading the view from its nib.
}
- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DipuDataModel *)VieWmodel{
    if (!_VieWmodel) {
        _VieWmodel = [[DipuDataModel alloc]init];
    }
    return _VieWmodel;
}

@end
