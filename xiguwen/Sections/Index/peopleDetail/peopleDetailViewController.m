//
//  peopleDetailViewController.m
//  BoYi
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "peopleDetailViewController.h"
#import "peopleDetailViewModel.h"
#import "IndexCollectionViewCell.h"
#import "MapCollectionViewCell.h"
#import "FSCalendar.h"
#import "ZuoPinCollectionViewCell.h"
#import "AddShopCar.h"
#import "fuwuModel.h"
#import "ScheduleModel.h"
#import "ShopCarList.h"
#import "SurePayViewController.h"
#import "UIImage+GIF.h"
#import "TeamCollectionViewCell.h"
#import "FindDetailViewController.h"
#import "VideoViewController.h"
@interface peopleDetailViewController ()<UIScrollViewDelegate,FSCalendarDelegate,FSCalendarDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIButton *_btnMark;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) peopleDetailViewModel *viewModel;

@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (strong,nonatomic)NSMutableArray *reamArray;
@property (strong,nonatomic)NSMutableArray *fuwuxiangArray;
@property (strong,nonatomic)NSMutableArray *dangqiArray;

@property (assign,nonatomic)BOOL isGuanzhuMark;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthFive;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *zhiweiTpye;
@property (weak, nonatomic) IBOutlet UILabel *numberType;
@property (weak, nonatomic) IBOutlet UILabel *fansNumber;


@property (weak, nonatomic) IBOutlet UILabel *shopWords;
@property (weak, nonatomic) IBOutlet UILabel *fuwuWords;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;

@property (weak, nonatomic) IBOutlet UILabel *contentWords;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UICollectionView *teamCollection;

@property (weak, nonatomic) IBOutlet UICollectionView *zuopinCollection;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@property (weak, nonatomic) IBOutlet UIButton *plbtn;

@end

@implementation peopleDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    [self addPopBackBtn];
    
    [self setupTableView];
    
    [self scrollInitView];
    
    [self setupScollview];
    
    [self isdata];
    
    self.dateView.delegate = self;
    self.dateView.scrollDirection = FSCalendarScrollDirectionHorizontal;
    
    
}

- (void)setupScollview{
    self.teamCollection.delegate = self;
    self.teamCollection.dataSource = self;
    [self.teamCollection registerNib:[UINib nibWithNibName:@"TeamCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TeamCollectionViewCell"];
    
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"MapCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MapCollectionViewCell"];
    
    self.zuopinCollection.delegate = self;
    self.zuopinCollection.dataSource = self;
    [self.zuopinCollection registerNib:[UINib nibWithNibName:@"ZuoPinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZuoPinCollectionViewCell"];
    self.teamCollection.showsVerticalScrollIndicator = FALSE;
    self.teamCollection.showsHorizontalScrollIndicator = FALSE;
    
    self.collectionAddress.showsVerticalScrollIndicator = FALSE;
    self.collectionAddress.showsHorizontalScrollIndicator = FALSE;
    
    self.zuopinCollection.showsVerticalScrollIndicator = FALSE;
    self.zuopinCollection.showsHorizontalScrollIndicator = FALSE;
}

- (void)isdata{
    self.fuwuArray = [NSMutableArray array];
    self.reamArray = [NSMutableArray array];
    self.fuwuxiangArray = [NSMutableArray array];
    self.dangqiArray = [NSMutableArray array];
    
}

- (void)scrollInitView{
    self.scrollWidth.constant = 4 * ScreenWidth;
    self.widthOne.constant = ScreenWidth;
    self.widthThree.constant = ScreenWidth;
    self.widthFour.constant = ScreenWidth;
    self.widthFive.constant = ScreenWidth;
    _scroll.delegate = self;
    
    // 实例化NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 获取当前日期
    NSString *currentDateString = [formatter stringFromDate:[NSDate new]];
    
    self.time.text = currentDateString;
    
}
#pragma mark - 点击事件
- (IBAction)action:(UIButton *)sender {
    _btnMark.selected = NO;
    sender.selected = YES;
    _btnMark = sender;
    if (sender.tag == 10) {
        [_scroll setContentOffset:CGPointMake(0,0) animated:YES];
        
    }else if (sender.tag == 12) {
        [_scroll setContentOffset:CGPointMake(ScreenWidth,0) animated:YES];
        
    }else if (sender.tag == 13) {
        [_scroll setContentOffset:CGPointMake(ScreenWidth * 2,0) animated:YES];
        
    }else if (sender.tag == 14) {
        [_scroll setContentOffset:CGPointMake(ScreenWidth * 3,0) animated:YES];
        
    }
}



#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"TlakTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TlakTableViewCell"];

    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *city = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
    
    [self.viewModel.refreshDataCommand execute:@{@"user_id":self.userId, @"city":city}];
    
    [self.viewModel.fuwuXiangmuCommand execute:@{@"userId":self.userId}];
    
    [self.viewModel.lookDQCommand execute:@{@"userid":self.userId,
                                            @"startTime":self.dateView.selectedDate ? self.dateView.selectedDate.fs_string : self.dateView.today.fs_string,
                                            @"endTime":self.dateView.selectedDate ? self.dateView.selectedDate.fs_string : self.dateView.today.fs_string}];
    
    if ([UserData UserLoginState]) {
        [self.viewModel.GetShopDataCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id), @"followuserid":self.userId}];
    }
    
    @weakify(self);

    [self.viewModel.addguanUISubject subscribeNext:^(id  _Nullable x) {
        
      
        if (x[@"r"]) {
            if ([x[@"status"] integerValue] == 200) {
                self.isGuanzhuMark = YES;
                [self isChangeGuanzhu];
            }
            
        }
        
    }];
    [self.viewModel.deleteguanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if (x[@"r"]) {
            if ([x[@"status"] integerValue] == 200) {
                self.isGuanzhuMark = NO;
                [self isChangeGuanzhu];
            }
            
        }
        
    }];
    [self.viewModel.guanzhuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if (x[@"r"]) {
            if ([x[@"r"] integerValue] == 1) {
                self.isGuanzhuMark = YES;
                
            }else {
                self.isGuanzhuMark = NO;
                
            }
            [self isChangeGuanzhu];
        }
        
    }];
//    请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        
        self.viewModel.model = [peopleDetailModel mj_objectWithKeyValues:x];
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        [self fuzhiData:self.viewModel.model];
        //刷新视图
        [self.table reloadData];
        
    }];
    
    //服务项
    [self.viewModel.fuwuxiangmuUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        self.fuwuxiangArray = [Esarrayqw mj_objectArrayWithKeyValuesArray:x[@"r"]];
        
    }];
    [self.viewModel.lookDQUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [self.dangqiArray removeAllObjects];
        [self.dangqiArray addObjectsFromArray:[ScheduleModel mj_objectArrayWithKeyValuesArray:x[@"r"]]];
        if (self.dangqiArray.count > 0) {
            ScheduleModel *model = self.dangqiArray[0];
            if (model.scheduleType == 1) {
                self.contentWords.text = @"午宴已订,晚宴可订";
            }else {
                self.contentWords.text = @"午宴可订,晚宴已订";
            }
            
        }else{
            self.contentWords.text = @"午宴可订,晚宴可订";
        }
    }];

}

- (void)fuzhiData:(peopleDetailModel *)model{
    
    if (![String(@"",model.user.bizCover) isBlankString]) {
        [self.headerImage sd_setImageWithUrl:String(ImageHomeURL,model.user.bizCover) placeHolder:[UIImage imageNamed:@"占位图片"]];
    }
    if (model.comments.commentList.count > 0) {
        [self.plbtn setTitle:[NSString stringWithFormat:@"评论(%lu)",(unsigned long)model.comments.commentList.count] forState:UIControlStateNormal];
    }
    
    self.name.text = model.user.cnName;
    self.zhiweiTpye.text = model.channel.name;
    self.numberType.text = model.user.userType == 3 ? @"个人" : @"团队";
    self.fansNumber.text = [NSString stringWithFormat:@"粉丝数量%ld",(long)model.user.bizDealCount];
    self.shopWords.text = model.user.descn;
    self.fuwuWords.text = model.user.tagNames;
    if (model.openCitiesMap) {
        NSMutableDictionary *dic = model.openCitiesMap;
        for (NSString *s in [dic allKeys]) {
            if ([dic objectForKey:s]) {
                NSMutableArray *array = [dic objectForKey:s];
                self.fuwuArray = array;
                if (self.fuwuArray.count == 0) {
                    self.addressCollectionHeight.constant = 40;
                }else if (_fuwuArray.count < 4){
                    self.addressCollectionHeight.constant = 70;
                }else {
                    self.addressCollectionHeight.constant = 100;
                }
                [self.collectionAddress reloadData];
                
            }
            
        }
    }
    [self.teamCollection reloadData];
    [self.zuopinCollection reloadData];
    self.width.constant = 15;

//    if (model.authList.count == 2) {
//    }
//    if (model.authList.count == 3) {
//        if (model.authList[0].authType == 1) {
//            
//           
//        }else if (model.authList[0].authType == 2){
//            
//        }else {
//            
//        }
//    }
    
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
        self.width.constant = 90;
        
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
    if (![[NSString stringWithFormat:@"%@",model.creditData] isBlankString]) {
        int max = [model.creditData intValue];
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
    }
//    if (model.creditData.length == 0) {
//        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
//        
//        view.frame = CGRectMake(15, 0, 13, 13);
//        
//        [self.starView addSubview:view];
//    }
}

//初始化viewModel
- (peopleDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[peopleDetailViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.collectionAddress == collectionView) {
        return self.fuwuArray.count;
        
    }else if (self.teamCollection == collectionView) {
        return self.viewModel.model.recommendUsers.count;
    }else {
        return self.viewModel.model.exampleList.count;;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionAddress == collectionView) {
        
        //重用cell
        MapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MapCollectionViewCell" forIndexPath:indexPath];
        cell.city.text = self.fuwuArray[indexPath.row];
    
        return cell;
        
    }else if (self.teamCollection == collectionView) {
        
        //重用cell
        TeamCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeamCollectionViewCell" forIndexPath:indexPath];
        
        cell.name.text = self.viewModel.model.recommendUsers[indexPath.row].recommendUser.cnName;
        cell.zhiwei.text = self.viewModel.model.recommendUsers[indexPath.row].recommendUser.bizWork.name;
        [cell.image sd_setImageWithUrl:ImageAppendURL(self.viewModel.model.recommendUsers[indexPath.row].recommendUser.avatar) placeHolder:[UIImage imageNamed:@"头像"]];
        
        return cell;
        
    }else {
        //重用cell
        ZuoPinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZuoPinCollectionViewCell" forIndexPath:indexPath];

        [cell.image sd_setImageWithUrl:ImageAppendURL(self.viewModel.model.exampleList[indexPath.row].imgUrl) placeHolder:[UIImage imageNamed:@"占位图片"]];
        return cell;
    }
    
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.teamCollection == collectionView) {
        
        self.userId = [NSString stringWithFormat:@"%ld",self.viewModel.model.recommendUsers[indexPath.row].recommendUser.id];
        
        NSString *city = [NSStringFormatter([UserData UserDefaults:@"index_city"]) isBlankString] ? @"成都市":[UserData UserDefaults:@"index_city"];
        
        [self.viewModel.refreshDataCommand execute:@{@"user_id":self.userId, @"city":city}];
        
        [self.viewModel.fuwuXiangmuCommand execute:@{@"userId":self.userId}];
        
        [self.viewModel.lookDQCommand execute:@{@"userid":self.userId,
                                                @"startTime":self.dateView.selectedDate ? self.dateView.selectedDate.fs_string : self.dateView.today.fs_string,
                                                @"endTime":self.dateView.selectedDate ? self.dateView.selectedDate.fs_string : self.dateView.today.fs_string}];
    }
    if (self.zuopinCollection == collectionView) {
        
        
        if (self.viewModel.model.exampleList[indexPath.row].exampleType == 3) {
            
            FindDetailViewController *find = [[FindDetailViewController alloc] init];
            find.idString = [NSString stringWithFormat:@"%ld",(long)self.viewModel.model.exampleList[indexPath.row].id];
            [self pushToNextVCWithNextVC:find];
            
        }else {
            VideoViewController *video = [[VideoViewController alloc] init];
            video.urlString = self.viewModel.model.exampleList[indexPath.row].descn;
            [self pushToNextVCWithNextVC:video];
        }
    }
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionAddress == collectionView) {
        if (ScreenWidth == 320) {
            
            return CGSizeMake(80,30);
            
        }else if (ScreenWidth == 375) {
            
            return CGSizeMake(90,30);
            
        }else {
            return CGSizeMake(100,30);
        }
        
    }else if (self.teamCollection == collectionView) {
        if (ScreenWidth == 320) {
            
            return CGSizeMake(90,90 + 33);
            
        }else if (ScreenWidth == 375) {
            
            return CGSizeMake(100,100 + 33);
            
        }else {
            return CGSizeMake(110,110 + 33);
        }
        
    }else {
        
        return CGSizeMake((ScreenWidth - 30) / 2,130);
        
    }
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


#pragma mark FSCalendarDelegate
//选中某一天进行相关操作
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    
    self.time.text = self.dateView.selectedDate.fs_string;

    [self.viewModel.lookDQCommand execute:@{@"userid":self.userId,//@([UserData sharedManager].userInfoModel.id),
                                            @"startTime":self.dateView.selectedDate ? self.dateView.selectedDate.fs_string : self.dateView.today.fs_string,
                                            @"endTime":self.dateView.selectedDate ? self.dateView.selectedDate.fs_string : self.dateView.today.fs_string}];
    
}
//取消选中的日期进行相关操作
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date {
    //...
    NSLog(@"%@",date);
}

- (IBAction)addAction:(UIButton *)sender {
    
    
    
        //是否登录
        if (![UserData UserLoginState]) {
            //预约cell
            NewLoginViewController *vc = [[NewLoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
    
    if (sender.tag == 10) {
        
        [self isGuanzhuaction];
        
    }else if (sender.tag == 11) {
        //是否登录
        if (![UserData UserLoginState]) {
            //预约cell
            NewLoginViewController *vc = [[NewLoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
            return ;
        }
    
        [ShopCarList showInView:[UIApplication sharedApplication].keyWindow dic:nil block:^(NSDictionary *dic) {
            
            SurePayViewController *sure = [[SurePayViewController alloc] init];
            sure.hidesBottomBarWhenPushed = YES;
            sure.dic = [[NSMutableDictionary alloc] initWithDictionary:dic];
            [self pushToNextVCWithNextVC:sure];
        }];
        
    }else {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":self.viewModel.model.user.cnName,@"header":[NSString stringWithFormat:@"%@",self.viewModel.model.user.bizCover],@"bizUserId":[NSString stringWithFormat:@"%ld",(long)self.viewModel.model.user.id]}];
        
        [AddShopCar showInView:self.view array:_fuwuxiangArray dic:dic string:@"" block:^(NSDictionary *dic) {
            NSLog(@"%@",dic);
        }];
        
    }
}

- (IBAction)guanzhu:(IB_DESIGN_Button *)sender {
    //是否登录
    if (![UserData UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
    
    [self isGuanzhuaction];
    
}
- (void)isChangeGuanzhu{
    if (self.isGuanzhuMark) {
        [self.guanzhuBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        self.guanzhulabel.textColor = RGBA(255, 83, 132, 1);
        self.guanzhuimage.image = [UIImage imageNamed:@"关注"];
    }else {
        [self.guanzhuBtn setTitle:@"+关注" forState:UIControlStateNormal];
        self.guanzhulabel.textColor = RGBA(102, 102, 102, 1);
        self.guanzhuimage.image = [UIImage imageNamed:@"关注_灰"];
    }
}
- (void)isGuanzhuaction{
    if (self.isGuanzhuMark) {
        
        [self.viewModel.deleguanzhuCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id), @"followuserid":[NSString stringWithFormat:@"%ld",(long)self.viewModel.model.user.id]}];
        
    }else {
        [self.viewModel.addguanzhuCommand execute:@{@"userid":@([UserData sharedManager].userInfoModel.id), @"followuserid":[NSString stringWithFormat:@"%ld",(long)self.viewModel.model.user.id],@"type":@"1"}];
        
    }
}


@end
