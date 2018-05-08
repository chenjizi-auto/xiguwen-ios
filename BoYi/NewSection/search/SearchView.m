//
//  SearchView.m
//  BoYi
//
//  Created by heng on 2017/11/28.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "SearchView.h"
#import "SearchCollectionViewCell.h"
#import "SearchHeaderCollectionReusableView.h"
#import "AnlieListModel.h"

@implementation SearchView
+ (SearchView *)showInView:(UIView *)view array:(NSMutableArray *)array block:(void(^)(NSDictionary *dic))block{
    SearchView *alert = [[[NSBundle mainBundle]loadNibNamed:@"SearchView" owner:self options:nil]lastObject];
   

    if (isIPhoneX) {
        alert.height.constant = 84;
    }
    alert.search.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"放大镜"]];
   
    //    图片显示的模式
    //    UITextFieldViewModeNever,
    //    UITextFieldViewModeWhileEditing,
    //    UITextFieldViewModeUnlessEditing,
    //    UITextFieldViewModeAlways
    alert.search.leftViewMode = UITextFieldViewModeWhileEditing;
    alert.dic = [[NSMutableDictionary alloc] init];
    alert.collection.delegate = alert;
    alert.collection.dataSource = alert;
    alert.search.delegate = alert;
    alert.search.returnKeyType = UIReturnKeySearch;

    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [alert.collection registerNib:[UINib nibWithNibName:@"SearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SearchCollectionViewCell"];
     [alert.collection registerClass:[SearchHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHeaderCollectionReusableView"];
    alert.remenArray = [NSMutableArray array];
    alert.lishiArray = [NSMutableArray array];
   
    alert.type = @"sj";
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    [alert getData];
    return alert;
}
- (void)getData{
    NSDictionary *dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"type":self.type,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    [[RequestManager sharedManager] requestUrl:URL_New_search
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               self.model = [SearchLsModel mj_objectWithKeyValues:response[@"data"]];
                                               self.remenArray = [NSMutableArray arrayWithArray:self.model.hot];
                                               self.lishiArray = [NSMutableArray arrayWithArray:self.model.lishi];;
                                               [self.collection reloadData];
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        
                                           
                                       }];
}

- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {//商家
        [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        self.image1.hidden = NO;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        self.iamge4.hidden = YES;
        self.type = @"sj";
    }else if (sender.tag == 1) {//案例
        [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        self.image1.hidden = YES;
        self.image2.hidden = NO;
        self.image3.hidden = YES;
        self.iamge4.hidden = YES;
        self.type = @"al";
    }else if (sender.tag == 2) {//服务
        [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn3 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = NO;
        self.iamge4.hidden = YES;
        self.type = @"fw";
    }else {//商品
        [self.btn1 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
        [self.btn4 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        self.iamge4.hidden = NO;
        self.type = @"sp";
    }
}


- (IBAction)cancleAC:(UIButton *)sender {
    [self hidden];
}
- (void) hidden{
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        
        //        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
//    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1;
        
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return section == 0 ? self.remenArray.count : self.lishiArray.count;
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth,30);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    //从缓存中获取 Headercell
    SearchHeaderCollectionReusableView *header =nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        SearchHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHeaderCollectionReusableView" forIndexPath:indexPath];

        headerView.titleLabel.text = indexPath.section == 0 ? @"热门搜索" : @"历史搜索";
        [headerView.btn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [headerView.btn addTarget:self action:@selector(deleAC) forControlEvents:UIControlEventTouchUpInside];
        headerView.btn.hidden = indexPath.section == 0 ? YES : NO;
        header = headerView;
    }
    return header;
}
- (void)deleAC{

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionViewCell" forIndexPath:indexPath];
    
    cell.content.text = indexPath.section == 0 ? self.remenArray[indexPath.row].title : self.lishiArray[indexPath.row].title;
    cell.content.tag = indexPath.row;
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self searchw:self.remenArray[indexPath.row].title];
    }else {
        [self searchw:self.lishiArray[indexPath.row].title];
    }
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UILabel *lbl_text = [[UILabel alloc]init];
    lbl_text.text = indexPath.section == 0 ? self.remenArray[indexPath.row].title : self.lishiArray[indexPath.row].title;
    UIFont *fnt = [UIFont fontWithName:@"Courier New" size:12.0f];
    lbl_text.font = fnt;
    // 根据字体得到NSString的尺寸
    CGSize size = [lbl_text.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName,nil]];
    // 名字的W
    CGFloat nameW = size.width;
    lbl_text = nil;
    return CGSizeMake(nameW + 20,30);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length != 0) {
        [self searchw:textField.text];
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)searchw:(NSString *)sring{
    NSDictionary *dic = @{@"cont":sring,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"type":self.type,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    [[RequestManager sharedManager] requestUrl:URL_New_searchwu
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
 
                                               [self.dic setObject:response forKey:@"model"];
                                               [self.dic setObject:self.type forKey:@"type"];
                                               if (self.block) {
                                                   self.block(self.dic);
                                               }
                                               [self hidden];
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {

                                       }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self endEditing:YES];
}

@end
