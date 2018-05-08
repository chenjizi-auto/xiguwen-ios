//
//  DiPuDataViewController.m
//  BoYi
//
//  Created by heng on 2018/1/17.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "DiPuDataViewController.h"
#import "DipuDataModel.h"
#import "DipuModel.h"
#import "DIpuAlertImageBaseView.h"
#import "DipuNameChangeViewController.h"
#import "DiPuDataPickViewModel.h"
#import "DiPuPickerView.h"
#import "DiPuRequestCityViewModel.h"
#import "DipuModel.h"
@interface DiPuDataViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *BackGroundImage;//背景
@property (weak, nonatomic) IBOutlet UILabel *Number;//店铺编号
@property (weak, nonatomic) IBOutlet UITextField *ShopName;//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *ShopType;//店铺类别
@property (weak, nonatomic) IBOutlet UILabel *OccupationalCategory;//职业类别
@property (weak, nonatomic) IBOutlet UILabel *Address;//店铺地址
@property (weak, nonatomic) IBOutlet UITextField *DetaileAddress;//详细地址
@property (weak, nonatomic) IBOutlet UIView *zhiyeLeibieView;
@property (weak, nonatomic) IBOutlet UIView *shopTypeView;
@property (weak, nonatomic) IBOutlet UITextView *Introduction;//简介
//@property (weak, nonatomic) IBOutlet UIImageView *header;//头像
@property(nonatomic,strong)DIpuAlertImageBaseView * AlertImageBaseView;
@property(nonatomic,strong)DipuDataModel *DataModel;
@property(nonatomic,strong)DipuModel * sourcesModel;
@property(nonatomic,strong)DiPuPickerView * pickerView;
@property(nonatomic,strong)DiPuRequestCityViewModel * CityViewModel;

@property (weak, nonatomic) IBOutlet UIButton *firstDeleteBtn;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoDeleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *foreBtn;
@property (weak, nonatomic) IBOutlet UIButton *foreDeleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *ThreeDeleteBtn;
@property(nonatomic,strong)NSMutableArray * urlArray;

@end

@implementation DiPuDataViewController
{
    NSArray<DipuIficationObjc*> *Ificationlist;
    NSArray * CityArray;
    NSString * CityNames;
    NSString * cityIds;
    NSString * ShopName;
    NSString * ShoprIds;
    NSString * OccupationalName;
    NSString * OccupationalIds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺信息";
    self.urlArray = [[NSMutableArray alloc]initWithArray:@[@"",@"",@"",@""]];
    [self requestDiqu];
    [self addPopBackBts];

    [self RequestInfomation];
    [self addRightBtnWithTitle:@"保存" image:nil];
    [self RequestIficationlist];
    
    [self AlertImageBaseView];
    
    [self pickerView];
    self.ShopName.delegate = self;
    self.ShopName.inputAccessoryView = [self addToolbar];
    self.DetaileAddress.delegate = self;
    self.DetaileAddress.inputAccessoryView = [self addToolbar];
    self.Introduction.delegate = self;
    self.Introduction.inputAccessoryView = [self addToolbar];
    
}

- (void)addPopBackBts {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
}
- (void)popViewConDelay
{
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"更新数据" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * CalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        if (![self.navigationController popViewControllerAnimated:YES]) {
//            [self dismissViewControllerAnimated:YES completion:^{
//
//            }];
//        }
//    }];
//    UIAlertAction * DoneAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//           [self UpdataInformaton];
        if (![self.navigationController popViewControllerAnimated:YES]) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
//    }];
//     [alert addAction:CalAction];
//     [alert addAction:DoneAction];
//    [self presentViewController:alert animated:YES completion:nil];
   
}
-(void)takePhotoView{
  
}
- (void)respondsToRightBtn {
     [self UpdataInformaton];
}
/**
 * 获取详细信息
 */
-(void)RequestInfomation{
    NSInteger userId =[UserDataNew sharedManager].userInfoModel.user.userid;
    NSString * token = [UserDataNew sharedManager].userInfoModel.token.token;
    [self.DataModel.DataCommand execute:@{@"token":token,@"userid":@(userId)}];
    __weak typeof(self)weakSelf = self;
    [self.DataModel.Subject subscribeNext:^(id  _Nullable x) {
        [weakSelf UpdateUi:[DipuModel mj_objectWithKeyValues:x]];
    }];
}

/**
 * 城市获取
 */
- (void)requestDiqu{
   
    __weak typeof(self)weakSelf = self;
    [self.CityViewModel.DataCommand execute:nil];
    [self.CityViewModel.Subject subscribeNext:^(id  _Nullable x) {
        
//        [[NSUserDefaults standardUserDefaults] setObject:x forKey:@"CITYARRAY"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
       
       CityArray = [DipuCityModel mj_objectArrayWithKeyValuesArray:x];
    }];
}

/**
 * 获取职位类型
 */
-(void)RequestIficationlist{
    [self.DataModel.DataIficationlistCommand execute:nil];
    [self.DataModel.DataIficationlistSubject subscribeNext:^(id  _Nullable x) {
        Ificationlist = [DipuIficationObjc mj_objectArrayWithKeyValuesArray:x];
    }];
}

-(void)UpdataInformaton{
    NSLog(@"------------------------------%@",[self param]);
    [self.DataModel.UpDataCommand execute:[self param]];
    @weakify(self);
    [self.DataModel.UpDataSubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"-------------%@",x);
        @strongify(self);
        [NavigateManager showMessage:@"更新成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self popViewConDelay];
        });
        
    }];
    
}



/**
 * 跟新界面
 */
-(void)UpdateUi:(DipuModel*)model{
    
    self.sourcesModel = model;
    [self.BackGroundImage sd_setImageWithUrl:model.background placeHolder:nil];
    self.Number.text = [NSString stringWithFormat:@"%ld",model.userid];
    self.ShopName.text = model.nickname;
    self.ShopType.text = [NSString stringWithFormat:@"%@",model.team==1?@"个体商家":@"团队商家"];
//    if (model.team != 1) {
        //商城商家
        self.zhiyeLeibieView.hidden = model.usertype == 1;
        self.shopTypeView.hidden = model.usertype == 1;
//    }
    
    
    self.OccupationalCategory.text = [NSString stringWithFormat:@"%@",model.occupationid];
    self.Address.text = [NSString stringWithFormat:@"%@,%@,%@",model.provinceid,model.cityid,model.countyid];
    self.DetaileAddress.text = model.site;
    self.Introduction.text =model.content;
    [model.shopimg enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.urlArray[idx]=obj;
    }];
    [model.shopimg enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
                if (obj.length !=0) {
                    self.firstDeleteBtn.hidden = NO;
                    [self.firstBtn sd_setImageWithURL:[NSURL URLWithString:obj] forState:(UIControlStateNormal)];
                }
                break;
            case 1:
                if (obj.length!=0) {
                    self.twoDeleteBtn.hidden = NO;
                    [self.twoBtn sd_setImageWithURL:[NSURL URLWithString:obj] forState:(UIControlStateNormal)];
                }
                break;
            case 2:
                if (obj.length!=0) {
                    self.ThreeDeleteBtn.hidden = NO;
                    [self.threeBtn sd_setImageWithURL:[NSURL URLWithString:obj] forState:(UIControlStateNormal)];
                }
                break;
            case 3:
                if (obj.length!=0) {
                    self.foreDeleteBtn.hidden = NO;
                    [self.foreBtn sd_setImageWithURL:[NSURL URLWithString:obj] forState:(UIControlStateNormal)];
                }
               
                break;
            default:
                break;
        }
    }];
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma  btn 点击事件--------------------
- (IBAction)BackGroundBtnAction:(id)sender {
    [self.AlertImageBaseView ShowView];
    self.AlertImageBaseView.type = imageView;
    self.AlertImageBaseView.BackImageView = self.BackGroundImage;
    __weak typeof(self)weakSelf = self;
    self.AlertImageBaseView.Mblock = ^(NSData *data) {
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.header.image = [UIImage imageWithData:data];
//        });
        
       [weakSelf.DataModel UpImage:data indext:5];
    };
}
- (IBAction)ShopNameBtnAction:(id)sender {
//    DipuNameChangeViewController * vc = [[DipuNameChangeViewController alloc]init];
//    vc.Ntitle = @"设置昵称";
//    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)ShopTypeBtnAction:(id)sender {
    [self.pickerView PickdataSources:@[@"个人商家",@"团队商家"]  type:1];
}
- (IBAction)OccupationalCategoryBtnAction:(id)sender {
    [self.pickerView PickdataSources:Ificationlist  type:2];
}
- (IBAction)AddressBtnAction:(id)sender {
   [self.pickerView PickdataSources:CityArray  type:3];
}

/**
 * 数据 处理 模型
 */
- (DipuDataModel *)DataModel{
    if (!_DataModel) {
        _DataModel = [[DipuDataModel alloc]init];
        __weak typeof(self)weakself = self;
        _DataModel.ImageBlock = ^(NSString *imageUrl, NSInteger indext) {
            if (indext!=5) {
                weakself.urlArray[indext-1] = imageUrl;
            }
            
            switch (indext) {
                case 5:
                    weakself.sourcesModel.background = imageUrl;
                    break;
                default:
                    break;
            }
          
        };
    }
    return _DataModel;
}

/**
 * 图片选择和相册  界面
 */
- (DIpuAlertImageBaseView *)AlertImageBaseView{
    if (!_AlertImageBaseView) {
        _AlertImageBaseView=[[NSBundle mainBundle]loadNibNamed:@"DIpuAlertImageBaseView" owner:self options:nil].firstObject;
        _AlertImageBaseView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
        _AlertImageBaseView.Object = self;
        _AlertImageBaseView.DataModel = self.DataModel;
        _AlertImageBaseView.BackImageView = self.BackGroundImage;
        [self.view addSubview:_AlertImageBaseView];
    }
    return _AlertImageBaseView;
}
- (DiPuPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[NSBundle mainBundle]loadNibNamed:@"DiPuPickerView" owner:self options:nil].firstObject;
        _pickerView.frame = CGRectMake(0, ScreenHeight + 200, ScreenWidth, 200);
        [self.view addSubview:_pickerView];
        __weak typeof(self)weakSelf = self;
        _pickerView.Mblock = ^(NSString *cityNames, NSString *citys,DiPuPickerType type) {
            if (type==city) {
                cityIds = citys;
                CityNames = cityNames;
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.Address.text = cityNames;
                });
                
            }else if(type==ShopType){
                OccupationalName = cityNames;
                OccupationalIds = citys;
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.OccupationalCategory.text = cityNames;
                });
                
            }else{
                ShopName = cityNames;
                ShoprIds = citys;
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.ShopType.text =cityNames;
                });
                
               
            }
            
        };
    }
    return _pickerView;
}
- (DiPuRequestCityViewModel *)CityViewModel{
    if (!_CityViewModel) {
        _CityViewModel = [[DiPuRequestCityViewModel alloc]init];
    }
    return _CityViewModel;
}
-(NSDictionary*)param{
    NSInteger userId = [UserDataNew sharedManager].userInfoModel.user.userid;
    NSString * token = [UserDataNew sharedManager].userInfoModel.token.token;
    self.sourcesModel.site = self.DetaileAddress.text;
    self.sourcesModel.content = self.Introduction.text;
    if (!cityIds) {
        cityIds = [NSString stringWithFormat:@"%@-%@-%@",self.sourcesModel.provinceid,self.sourcesModel.cityid,self.sourcesModel.occupationid];
    }
    if (!ShoprIds) {
        ShoprIds = [NSString stringWithFormat:@"%lu",self.sourcesModel.team];
    }
    if (!OccupationalIds) {
        OccupationalIds = self.sourcesModel.occupationid;
    }
    if (self.urlArray.count!=0) {
        self.sourcesModel.shopimg = self.urlArray;
    }
    NSString * shopimgS = [self.sourcesModel.shopimg componentsJoinedByString:@","];
    if (shopimgS==nil) {
        shopimgS= @"";
    }
    return @{@"userid":@(userId),@"token":token,@"nickname":self.ShopName.text,@"background":[self NullAyjest:self.sourcesModel.background],@"area":[self NullAyjest:cityIds],@"shoptype":[self NullAyjest:ShoprIds],@"site":[self NullAyjest:self.sourcesModel.site],@"shopimg":[self NullAyjest:shopimgS],@"content":[self NullAyjest:self.sourcesModel.content],@"occupation":[self NullAyjest:OccupationalIds]};
}
-(NSString*)NullAyjest:(NSString*)str{
    if (str==nil) {
        return @"";
    }
    return str;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
 
}
- (IBAction)allBtnAction:(id)sender {
     [self.AlertImageBaseView ShowView];
    self.AlertImageBaseView.type = btn;
    self.AlertImageBaseView.Btn = sender;
    __weak typeof(self) weakSelf = self;
    self.AlertImageBaseView.Mblock = ^(NSData *data) {
        [weakSelf.DataModel UpImage:data indext:((UIButton*)sender).tag-10];
        ((UIButton*)[weakSelf.view viewWithTag:((UIButton*)sender).tag+10]).hidden = NO;
    };
}
- (IBAction)allDelegateBtnAction:(id)sender {
    [((UIButton*)[self.view viewWithTag:((UIButton*)sender).tag-10]) setImage:[UIImage imageNamed:@"评价 上传图片"] forState:(UIControlStateNormal)];
    ((UIButton*)sender).hidden = YES;
    self.urlArray[((UIButton*)sender).tag-20] = @"";
}


@end
