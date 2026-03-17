//
//  BOyiShiPinMoreViewController.m
//  BoYi
//
//  Created by heng on 2018/1/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "BOyiShiPinMoreViewController.h"
#import "ShiPinMoreViewModel.h"
#import "BoYiYinYueViewMoreMode.h"
typedef NS_ENUM(NSInteger){
    TUIJIAN=3,//推荐
    ZUIXIN=1,//最新
    ZUIRE=2//最热
}TYPEA;
@interface BOyiShiPinMoreViewController ()
@property (weak, nonatomic) IBOutlet UIView *zuixinLine;
@property (weak, nonatomic) IBOutlet UIView *tuijianLine;
@property (weak, nonatomic) IBOutlet UIView *zuireLine;
@property (strong,nonatomic) UICollectionView *collect;
@property (strong,nonatomic) UITableView * tableView;
@property (weak, nonatomic) IBOutlet UIButton *tuijianBtn;
@property (weak, nonatomic) IBOutlet UIButton *zuixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *zuireBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong)ShiPinMoreViewModel * viewModel;
@property(nonatomic,strong)BoYiYinYueViewMoreMode * YinYueViewMode;
@end
@interface BOyiShiPinMoreViewController()<UISearchBarDelegate>
@end
@implementation BOyiShiPinMoreViewController
{
    @private
    UIView * selectLine;
    UIButton * selectBtn;
    NSString * name;
    NSInteger typea;
}
- (void)viewDidLoad {

    [super viewDidLoad];
    self.navigationItem.title = self.titletex;
    self.searchBar.delegate = self;
    self.searchBar.barTintColor = RGBA(236, 236, 236, 1);
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchBar.layer.cornerRadius = 17;
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.layer.borderColor = RGBA(236, 236, 236, 1).CGColor;
    
    for (UIView * view in self.searchBar.subviews) {
        
        for (UIView * viewa in view.subviews) {
            if ([viewa isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                 viewa.backgroundColor = RGBA(236, 236, 236, 1);
            }
        }
    }
    [self addPopBackBtn];
    [self SetViewMode:self.musicOrVideo==VIDEO?ShiPinMoreViewModel.class:BoYiYinYueViewMoreMode.class];
    /**
     * 默认
     */
    typea = TUIJIAN;
    selectLine = self.tuijianLine;
    selectBtn = self.tuijianBtn;
    name = @"";
    [self.titletex isEqualToString:@"推荐"]?({
        [self tuijianAction:self.tuijianBtn];
    }):[self.titletex isEqualToString:@"最新"]?({
         [self zuixinAction:self.zuixinBtn];
    }):({
        [self zuireAction:self.zuireBtn];
    });
  
}
-(void)TypeSelecte:(TYPEA)types lineView:(UIView*)lineView btn:(UIButton*)btn{
    typea = types;
    selectLine = lineView;
    selectBtn = btn;
}

-(void)request{
    if (self.musicOrVideo==VIDEO) {
        [self.viewModel Request:@{@"name":name,@"type":@(self.type),@"typea":@(typea)}];
    }else{
        [self.YinYueViewMode Request:@{@"name":name,@"type":@(self.type),@"typea":@(typea)}];
    }
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
- (IBAction)zuireAction:(id)sender {
     [self Action:sender];
     [self selectViewLine:self.zuireLine];
     typea = ZUIRE;
     [self request];
}
- (IBAction)zuixinAction:(id)sender {
     [self Action:sender];
     [self selectViewLine:self.zuixinLine];
     typea = ZUIXIN;
     [self request];
}
- (IBAction)tuijianAction:(id)sender {
     [self Action:sender];
     [self selectViewLine:self.tuijianLine];
     typea = TUIJIAN;
     [self request];
}
-(void)Action:(UIButton*)btn{
    [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(255, 114, 153, 1) forState:UIControlStateNormal];
    selectBtn = btn;
}
- (void)selectViewLine:(UIView*)line{
    selectLine.backgroundColor = [UIColor clearColor];
    line.backgroundColor = RGBA(255, 114, 153, 1);
    selectLine = line;
    
}

-(void)SetViewMode:(Class)ClassOb{
    id objc = [[ClassOb alloc] init];
    if ( self.musicOrVideo==1) {
        self.viewModel=objc;
        [self.viewModel MesaageDelegate:self.collect];
    }else{
        self.YinYueViewMode=objc;
        [self.YinYueViewMode MesaageDelegate:self.tableView];
    }
}


/**视频*/
- (UICollectionView *)collect
{
    if (!_collect) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((ScreenWidth-30)/2.0, (ScreenWidth-15)/2.0);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame)+14, ScreenWidth, self.view.frame.size.height- CGRectGetMaxY(self.searchBar.frame)-14) collectionViewLayout:layout];
        _collect.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collect];
    }
    return _collect;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame)+14, ScreenWidth, self.view.frame.size.height- CGRectGetMaxY(self.searchBar.frame)-14) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    name = searchBar.text;
    [self request];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
