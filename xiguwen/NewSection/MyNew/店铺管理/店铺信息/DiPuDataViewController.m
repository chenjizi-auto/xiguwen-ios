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
#import "CwApiCacheStore.h"
#import "DipuModel.h"
@interface DiPuDataViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *BackGroundImage;//背景
@property (weak, nonatomic) IBOutlet UILabel *Number;//店铺编号
@property (weak, nonatomic) IBOutlet UITextField *ShopName;//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *ShopType;//店铺类别
@property (weak, nonatomic) IBOutlet UILabel *shopState;//店铺状态
///是否是改变商店状态
@property (nonatomic,unsafe_unretained) BOOL isChangeShopState;
@property (weak, nonatomic) IBOutlet UILabel *OccupationalCategory;//职业类别
@property (weak, nonatomic) IBOutlet UILabel *Address;//店铺地址
@property (weak, nonatomic) IBOutlet UITextField *DetaileAddress;//详细地址
@property (weak, nonatomic) IBOutlet UIView *zhiyeLeibieView;
@property (weak, nonatomic) IBOutlet UIView *shopTypeView;
@property (weak, nonatomic) IBOutlet UITextView *Introduction;//简介
@property (weak, nonatomic) IBOutlet UIView *unitImagesView;

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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;
@property (nonatomic, strong) NSMutableArray<UIButton *> *shopImageButtons;
@property (nonatomic, strong) NSMutableArray<UIButton *> *shopImageDeleteButtons;
@property (nonatomic, weak) NSLayoutConstraint *unitImagesHeightConstraint;
@property (nonatomic, strong) UILabel *introductionTitleLabel;

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

static const NSInteger CwShopImageMaxCount = 9;
static const NSInteger CwBackgroundUploadIndex = 1000;
static NSString * const CwIntroductionPlaceholder = @"请输入商家简介";

- (NSArray *)cachedRegionDataSource {
    NSArray *rawRegions = [[CwApiCacheStore sharedStore] cachedRegionJSONArray];
    if (rawRegions.count > 0) {
        return rawRegions;
    }
    return [[CwApiCacheStore sharedStore] cachedRegionTree];
}

- (void)reloadCityArrayFromCache {
    NSArray *cachedRegions = [self cachedRegionDataSource];
    if (cachedRegions.count > 0) {
        CityArray = [DipuCityModel mj_objectArrayWithKeyValuesArray:cachedRegions];
    }
}

- (void)updateAddressLabelWithModel:(DipuModel *)model {
    NSString *addressText = [[CwApiCacheStore sharedStore] regionDisplayNameForProvinceId:model.provinceid
                                                                                   cityId:model.cityid
                                                                                 countyId:model.countyid];
    if (addressText.length == 0) {
        NSMutableArray<NSString *> *parts = [NSMutableArray array];
        for (NSString *part in @[model.provinceid ?: @"", model.cityid ?: @"", model.countyid ?: @""]) {
            NSString *trimmed = [part stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (trimmed.length > 0 && ![trimmed isEqualToString:@"0"]) {
                [parts addObject:trimmed];
            }
        }
        addressText = [parts componentsJoinedByString:@","];
    }
    self.Address.text = addressText;
}

- (NSString *)normalizedShopImageURLString:(NSString *)rawURL {
    if (![rawURL isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSString *trimmed = [rawURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimmed.length == 0 || [trimmed isEqualToString:@"(null)"] || [trimmed isEqualToString:@"<null>"]) {
        return nil;
    }
    NSString *normalized = RIGHT_URL(trimmed);
    return [normalized stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (void)applyShopImageURLString:(NSString *)rawURL toButton:(UIButton *)button {
    NSString *urlString = [self normalizedShopImageURLString:rawURL];
    UIImage *placeholder = [UIImage imageNamed:@"占位图片"];
    if (urlString.length == 0) {
        [button setImage:placeholder forState:UIControlStateNormal];
        return;
    }
    [button sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal placeholderImage:placeholder];
}

- (void)setupImageGridView {
    [self.unitImagesView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.shopImageButtons = [NSMutableArray array];
    self.shopImageDeleteButtons = [NSMutableArray array];

    CGFloat spacing = 10.0;
    CGFloat inset = 16.0;
    CGFloat itemWidth = floor((CGRectGetWidth(UIScreen.mainScreen.bounds) - inset * 2 - spacing * 2) / 3.0);
    CGFloat height = itemWidth * 3 + spacing * 2;

    for (NSLayoutConstraint *constraint in self.unitImagesView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondItem == nil) {
            self.unitImagesHeightConstraint = constraint;
            break;
        }
    }
    if (!self.unitImagesHeightConstraint) {
        self.unitImagesHeightConstraint = [self.unitImagesView.heightAnchor constraintEqualToConstant:height];
        self.unitImagesHeightConstraint.active = YES;
    } else {
        self.unitImagesHeightConstraint.constant = height;
    }

    for (NSInteger index = 0; index < CwShopImageMaxCount; index++) {
        NSInteger row = index / 3;
        NSInteger column = index % 3;
        CGFloat x = inset + column * (itemWidth + spacing);
        CGFloat y = row * (itemWidth + spacing);

        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = CGRectMake(x, y, itemWidth, itemWidth);
        imageButton.tag = index;
        imageButton.adjustsImageWhenHighlighted = NO;
        imageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageButton.clipsToBounds = YES;
        imageButton.layer.cornerRadius = 10.0;
        imageButton.layer.borderWidth = 1.0;
        imageButton.layer.borderColor = [UIColor colorWithWhite:0.88 alpha:1.0].CGColor;
        imageButton.backgroundColor = UIColor.whiteColor;
        [imageButton setImage:[UIImage imageNamed:@"评价 上传图片"] forState:UIControlStateNormal];
        [imageButton addTarget:self action:@selector(handleShopImageButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.unitImagesView addSubview:imageButton];
        [self.shopImageButtons addObject:imageButton];

        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(CGRectGetMaxX(imageButton.frame) - 18.0, CGRectGetMinY(imageButton.frame) - 2.0, 20.0, 20.0);
        deleteButton.tag = index;
        deleteButton.hidden = YES;
        deleteButton.layer.cornerRadius = 10.0;
        deleteButton.layer.masksToBounds = YES;
        deleteButton.backgroundColor = UIColor.whiteColor;
        [deleteButton setImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(handleShopImageDeleteTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.unitImagesView addSubview:deleteButton];
        [self.shopImageDeleteButtons addObject:deleteButton];
    }
}

- (void)reloadShopImageGrid {
    if (self.shopImageButtons.count == 0) {
        return;
    }
    NSMutableArray<NSString *> *validImageURLs = [NSMutableArray array];
    for (id value in self.urlArray) {
        NSString *string = [value isKindOfClass:[NSString class]] ? (NSString *)value : [NSString stringWithFormat:@"%@", value];
        NSString *trimmed = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (trimmed.length == 0 || [trimmed isEqualToString:@"(null)"] || [trimmed isEqualToString:@"<null>"]) {
            continue;
        }
        [validImageURLs addObject:trimmed];
    }
    self.urlArray = validImageURLs;
    NSInteger imageCount = MIN(self.urlArray.count, CwShopImageMaxCount);
    NSInteger visibleCount = imageCount < CwShopImageMaxCount ? imageCount + 1 : CwShopImageMaxCount;
    UIImage *uploadImage = [UIImage imageNamed:@"评价 上传图片"];

    for (NSInteger index = 0; index < self.shopImageButtons.count; index++) {
        UIButton *imageButton = self.shopImageButtons[index];
        UIButton *deleteButton = self.shopImageDeleteButtons[index];
        BOOL shouldShow = index < visibleCount;
        imageButton.hidden = !shouldShow;
        deleteButton.hidden = YES;
        if (!shouldShow) {
            continue;
        }
        if (index < imageCount) {
            [self applyShopImageURLString:self.urlArray[index] toButton:imageButton];
            deleteButton.hidden = NO;
        } else {
            [imageButton setImage:uploadImage forState:UIControlStateNormal];
        }
    }
}

- (void)presentShopImagePickerForIndex:(NSInteger)index {
    [self.pickerView pickDismiss];
    [[UIApplication sharedApplication].delegate.window endEditing:NO];
    [self.AlertImageBaseView ShowView];
    self.AlertImageBaseView.type = btn;
    self.AlertImageBaseView.Btn = nil;
    __weak typeof(self) weakSelf = self;
    self.AlertImageBaseView.Mblock = ^(NSData *data) {
        [weakSelf.DataModel UpImage:data indext:index + 1];
    };
}

- (void)handleShopImageButtonTap:(UIButton *)sender {
    [self presentShopImagePickerForIndex:sender.tag];
}

- (void)handleShopImageDeleteTap:(UIButton *)sender {
    NSInteger index = sender.tag;
    if (index >= 0 && index < self.urlArray.count) {
        [self.urlArray removeObjectAtIndex:index];
        self.sourcesModel.shopimg = [self.urlArray copy];
        [self reloadShopImageGrid];
    }
}

- (void)configureIntroductionInput {
    UIView *containerView = self.Introduction.superview;
    if (!containerView) {
        return;
    }

    self.introductionTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.introductionTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.introductionTitleLabel.text = @"店铺简介";
    self.introductionTitleLabel.font = [UIFont systemFontOfSize:16.0];
    self.introductionTitleLabel.textColor = UIColor.blackColor;
    [containerView addSubview:self.introductionTitleLabel];

    NSMutableArray<NSLayoutConstraint *> *constraintsToDeactivate = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in containerView.constraints) {
        if (constraint.firstItem == self.Introduction || constraint.secondItem == self.Introduction) {
            [constraintsToDeactivate addObject:constraint];
        }
    }
    [NSLayoutConstraint deactivateConstraints:constraintsToDeactivate];
    [NSLayoutConstraint deactivateConstraints:self.Introduction.constraints];

    self.Introduction.translatesAutoresizingMaskIntoConstraints = NO;
    self.Introduction.font = [UIFont systemFontOfSize:15.0];
    self.Introduction.textAlignment = NSTextAlignmentLeft;
    self.Introduction.textContainerInset = UIEdgeInsetsMake(12.0, 0.0, 12.0, 0.0);
    self.Introduction.textContainer.lineFragmentPadding = 0.0;
    self.Introduction.scrollEnabled = YES;
    self.Introduction.backgroundColor = UIColor.whiteColor;
    self.Introduction.layer.cornerRadius = 10.0;
    self.Introduction.layer.borderWidth = 1.0;
    self.Introduction.layer.borderColor = [UIColor colorWithWhite:0.88 alpha:1.0].CGColor;
    self.Introduction.layer.masksToBounds = YES;

    UIView *detailAddressContainer = self.DetaileAddress.superview;
    [NSLayoutConstraint activateConstraints:@[
        [self.Introduction.topAnchor constraintEqualToAnchor:detailAddressContainer.bottomAnchor constant:10.0],
        [self.Introduction.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-8.0],
        [self.Introduction.leadingAnchor constraintEqualToAnchor:self.introductionTitleLabel.trailingAnchor constant:16.0],
        [self.Introduction.heightAnchor constraintEqualToConstant:78.0],

        [self.introductionTitleLabel.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:16.0],
        [self.introductionTitleLabel.topAnchor constraintEqualToAnchor:self.Introduction.topAnchor constant:15.0],

        [self.unitImagesView.topAnchor constraintEqualToAnchor:self.Introduction.bottomAnchor constant:10.0],
    ]];

    [self updateIntroductionPlaceholderIfNeeded];
}

- (NSString *)currentIntroductionContent {
    NSString *text = self.Introduction.text ?: @"";
    if ([text isEqualToString:CwIntroductionPlaceholder]) {
        return @"";
    }
    return [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)updateIntroductionPlaceholderIfNeeded {
    NSString *content = [self currentIntroductionContent];
    if (content.length == 0) {
        self.Introduction.text = CwIntroductionPlaceholder;
        self.Introduction.textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    } else {
        self.Introduction.text = content;
        self.Introduction.textColor = [UIColor colorWithWhite:0.33 alpha:1.0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.navigationItem.title = @"店铺信息";
    self.urlArray = [[NSMutableArray alloc] init];
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
    self.topInset.constant = [UIApplication sharedApplication].statusBarFrame.size.height + 24.0;
    self.BackGroundImage.contentMode = UIViewContentModeScaleAspectFill;
    self.BackGroundImage.layer.cornerRadius = 10.0;
    self.BackGroundImage.layer.masksToBounds = YES;
    self.Number.textAlignment = NSTextAlignmentRight;
    self.OccupationalCategory.textAlignment = NSTextAlignmentRight;
    self.ShopType.textAlignment = NSTextAlignmentRight;
    self.shopState.textAlignment = NSTextAlignmentRight;
    self.Address.textAlignment = NSTextAlignmentRight;
    [self configureIntroductionInput];
    [self setupImageGridView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    CGPoint point = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin;
    if ((point.y != UIScreen.mainScreen.bounds.size.height)) {
        [self.pickerView pickDismiss];
    }
}

- (void)addPopBackBts {
    [self addPopBackBtn];
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
    [self reloadCityArrayFromCache];

    __weak typeof(self)weakSelf = self;
    [self.CityViewModel.Subject subscribeNext:^(id  _Nullable x) {
        CityArray = [DipuCityModel mj_objectArrayWithKeyValuesArray:x];
        if (CityArray.count == 0) {
            [weakSelf reloadCityArrayFromCache];
        }
    }];
    [self.CityViewModel.DataCommand execute:nil];
}

/**
 * 获取职位类型
 */
-(void)RequestIficationlist{
    [self.DataModel.DataIficationlistSubject subscribeNext:^(id  _Nullable x) {
        Ificationlist = [DipuIficationObjc mj_objectArrayWithKeyValuesArray:x];
    }];
    [self.DataModel.DataIficationlistCommand execute:nil];
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
    NSLog(@"[ShopInfo] shopimg class=%@ value=%@", NSStringFromClass([model.shopimg class]), model.shopimg);
    [self.BackGroundImage sd_setImageWithUrl:model.background placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.Number.text = [NSString stringWithFormat:@"%ld",model.userid];
    self.ShopName.text = model.nickname;
    self.ShopType.text = [NSString stringWithFormat:@"%@",model.team==1?@"个体商家":@"团队商家"];
    self.shopState.text = [NSString stringWithFormat:@"%@",model.onlinestatus==1?@"上线":@"下线"];
//    if (model.team != 1) {
        //商城商家
        self.zhiyeLeibieView.hidden = model.usertype == 1;
        self.shopTypeView.hidden = model.usertype == 1;
//    }
    
    
    self.OccupationalCategory.text = [NSString stringWithFormat:@"%@",model.occupationid];
    [self updateAddressLabelWithModel:model];
    self.DetaileAddress.text = model.site;
    self.Introduction.text = model.content;
    [self updateIntroductionPlaceholderIfNeeded];
    self.urlArray = model.shopimg ? [model.shopimg mutableCopy] : [NSMutableArray array];
    [self reloadShopImageGrid];
    cityIds = [NSString stringWithFormat:@"%@-%@-%@",[self NullAyjest:model.provinceid],[self NullAyjest:model.cityid],[self NullAyjest:model.countyid]];
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma  btn 点击事件--------------------
- (IBAction)BackGroundBtnAction:(id)sender {
    [self.pickerView pickDismiss];
    [[UIApplication sharedApplication].delegate.window endEditing:NO];
    [self.AlertImageBaseView ShowView];
    self.AlertImageBaseView.type = imageView;
    self.AlertImageBaseView.BackImageView = self.BackGroundImage;
    __weak typeof(self)weakSelf = self;
    self.AlertImageBaseView.Mblock = ^(NSData *data) {
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.header.image = [UIImage imageWithData:data];
//        });
        
       [weakSelf.DataModel UpImage:data indext:CwBackgroundUploadIndex];
    };
}
- (IBAction)ShopNameBtnAction:(id)sender {
    [[UIApplication sharedApplication].delegate.window endEditing:NO];
//    DipuNameChangeViewController * vc = [[DipuNameChangeViewController alloc]init];
//    vc.Ntitle = @"设置昵称";
//    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)ShopTypeBtnAction:(id)sender {
    self.isChangeShopState = NO;
    [[UIApplication sharedApplication].delegate.window endEditing:NO];
    [self.pickerView PickdataSources:@[@"个人商家",@"团队商家"]  type:1];
}
- (IBAction)shopStateAction:(id)sender {
    self.isChangeShopState = YES;
    [[UIApplication sharedApplication].delegate.window endEditing:NO];
    [self.pickerView PickdataSources:@[@"上线",@"下线"]  type:1];
}

- (IBAction)OccupationalCategoryBtnAction:(id)sender {
    [[UIApplication sharedApplication].delegate.window endEditing:NO];
    [self.pickerView PickdataSources:Ificationlist  type:2];
}
- (IBAction)AddressBtnAction:(id)sender {
    [[UIApplication sharedApplication].delegate.window endEditing:NO];
    if (CityArray.count == 0) {
        [self reloadCityArrayFromCache];
    }
    if (CityArray.count == 0) {
        [self.CityViewModel.DataCommand execute:nil];
        [NavigateManager showMessage:@"地区数据加载中，请稍后再试"];
        return;
    }
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
            if (indext == CwBackgroundUploadIndex) {
                weakself.sourcesModel.background = imageUrl;
                [weakself.BackGroundImage sd_setImageWithUrl:imageUrl placeHolder:[UIImage imageNamed:@"占位图片"]];
                return;
            }
            NSInteger index = indext - 1;
            if (index < 0 || index >= CwShopImageMaxCount) {
                return;
            }
            if (index < weakself.urlArray.count) {
                weakself.urlArray[index] = imageUrl;
            } else {
                while (weakself.urlArray.count < index) {
                    [weakself.urlArray addObject:@""];
                }
                [weakself.urlArray addObject:imageUrl];
            }
            weakself.sourcesModel.shopimg = [weakself.urlArray copy];
            [weakself reloadShopImageGrid];
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
        CGFloat height = UIApplication.sharedApplication.statusBarFrame.size.height == 20.0 ? 200.0 : 235.0;
        _pickerView.frame = CGRectMake(0, ScreenHeight + height, ScreenWidth, height);
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
                    if (weakSelf.isChangeShopState) {
                        weakSelf.shopState.text = cityNames;
                        return;
                    }
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
    self.sourcesModel.content = [self currentIntroductionContent];
    if (!cityIds) {
        cityIds = [NSString stringWithFormat:@"%@-%@-%@",[self NullAyjest:self.sourcesModel.provinceid],[self NullAyjest:self.sourcesModel.cityid],[self NullAyjest:self.sourcesModel.countyid]];
    }
    if (!ShoprIds) {
        ShoprIds = [NSString stringWithFormat:@"%lu",self.sourcesModel.team];
    }
    if (!OccupationalIds) {
        OccupationalIds = self.sourcesModel.occupationid;
    }
    self.sourcesModel.shopimg = [self.urlArray copy];
    NSString * shopimgS = [self.sourcesModel.shopimg componentsJoinedByString:@","];
    if (shopimgS==nil) {
        shopimgS= @"";
    }
    NSString *shopState = [self.shopState.text isEqualToString:@"上线"] ? @"1" : @"2";
    return @{@"userid":@(userId),@"onlinestatus":shopState,@"token":token,@"nickname":self.ShopName.text,@"background":[self NullAyjest:self.sourcesModel.background],@"area":[self NullAyjest:cityIds],@"shoptype":[self NullAyjest:ShoprIds],@"site":[self NullAyjest:self.sourcesModel.site],@"shopimg":[self NullAyjest:shopimgS],@"content":[self NullAyjest:self.sourcesModel.content],@"occupation":[self NullAyjest:OccupationalIds]};
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

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == self.Introduction && [textView.text isEqualToString:CwIntroductionPlaceholder]) {
        textView.text = @"";
        textView.textColor = [UIColor colorWithWhite:0.33 alpha:1.0];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == self.Introduction) {
        [self updateIntroductionPlaceholderIfNeeded];
    }
}
- (IBAction)allBtnAction:(id)sender {
    NSInteger index = MAX(((UIButton *)sender).tag - 11, 0);
    [self presentShopImagePickerForIndex:index];
}
- (IBAction)allDelegateBtnAction:(id)sender {
    NSInteger index = MAX(((UIButton *)sender).tag - 21, 0);
    if (index < self.urlArray.count) {
        [self.urlArray removeObjectAtIndex:index];
        self.sourcesModel.shopimg = [self.urlArray copy];
        [self reloadShopImageGrid];
    }
}


@end
