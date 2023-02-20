//
//  CXHunqingquanTableViewCell.m
//  BoYi
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CXHunqingquanTableViewCell.h"

@interface CXHunqingquanTableViewCell(){
    UIView *layerView;
}

@property (nonatomic ,strong) NSMutableArray *iCONS;
@property (nonatomic ,strong) UIView *bgView;
@end;
@implementation CXHunqingquanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 @property (nonatomic ,strong)UIButton *header;
 @property (nonatomic ,strong)UILabel *StoreName;
 @property (nonatomic ,strong)UILabel *delabel;
 @property (nonatomic ,strong)UILabel *time;
 @property (nonatomic ,strong)UIButton *sees;
 @property (nonatomic ,strong)UIButton *talks;
 @property (nonatomic ,strong)UIButton *goods;
 -(void)imagesLoadwithData:(NSArray *)images;
 */

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _header = [[UIButton alloc] initWithFrame:CGRectZero];
    _header.layer.cornerRadius = 18.5;
    _header.clipsToBounds = YES;
    _header.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [_header addTarget:self action:@selector(selectHeader:) forControlEvents:UIControlEventTouchUpInside];
    _name = [[UILabel alloc] initWithFrame:CGRectZero];
    _name.font = [UIFont systemFontOfSize:16];
    _name.textColor = [CXSinglerModel colorWithHex:@"262626" alpha:1];
    
    _deslabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _deslabel.font = [UIFont systemFontOfSize:15];
    _deslabel.textColor = [CXSinglerModel colorWithHex:@"262626" alpha:1];
    _deslabel.numberOfLines = 10000;
    
    _time = [[UILabel alloc] initWithFrame:CGRectZero];
    _time.font = [UIFont systemFontOfSize:11];
    _time.textColor = [CXSinglerModel colorWithHex:@"898989" alpha:1];
    
    _sees = [[UIButton alloc] initWithFrame:CGRectZero];
    [_sees setTitleColor:[CXSinglerModel colorWithHex:@"898989" alpha:1] forState:UIControlStateNormal];
    
    _talks = [[UIButton alloc] initWithFrame:CGRectZero];
    [_talks setTitleColor:[CXSinglerModel colorWithHex:@"898989" alpha:1] forState:UIControlStateNormal];
    
    _goods = [[UIButton alloc] initWithFrame:CGRectZero];
    [_goods setTitleColor:[CXSinglerModel colorWithHex:@"898989" alpha:1] forState:UIControlStateNormal];
    
    _sees.titleLabel.font = _talks.titleLabel.font = _goods.titleLabel.font = [UIFont systemFontOfSize:14];
     NSArray *imagenames = @[@"浏览",@"评论",@"未点赞"];
    for (NSInteger index = 0; index < imagenames.count; index ++) {
        UIButton *operationBtn;
        if (index == 0) {
            operationBtn = _sees;
            operationBtn.userInteractionEnabled = false;
        }
        else if (index == 1){
            operationBtn = _talks;
            operationBtn.userInteractionEnabled = false;
        }
        else if (index == 2){
            operationBtn = _goods;
        }
        [operationBtn addTarget:self action:@selector(operationTaped:) forControlEvents:UIControlEventTouchUpInside];
        [operationBtn setImage:[UIImage imageNamed:imagenames[index]] forState:UIControlStateNormal];
        if (index == 2) {
            [operationBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateSelected];
        }
        operationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [operationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, cxwid / 6 - 25, 0, 0)];
        [operationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, cxwid / 6 - 30, 0, 0)];
        [operationBtn setTitle:@"99" forState:UIControlStateNormal];
        [operationBtn setTitleColor:[CXSinglerModel colorWithHex:@"898989" alpha:1] forState:UIControlStateNormal];
        [operationBtn setTitleColor:[CXSinglerModel colorWithHex:@"FC5887" alpha:1] forState:UIControlStateSelected];
    }
    
    
    
    _iCONS = [NSMutableArray array];
    
    _careBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _careBtn.layer.cornerRadius = 2;
    _careBtn.layer.borderWidth = 0.5;
    _careBtn.layer.borderColor = [CXSinglerModel colorWithHex:@"F5A623" alpha:1].CGColor;
    [_careBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_careBtn setTitle:@"取消关注" forState:UIControlStateSelected];
    [_careBtn setTitleColor:[CXSinglerModel colorWithHex:@"F1951C" alpha:1] forState:UIControlStateNormal];
    [_careBtn setTitleColor:[CXSinglerModel colorWithHex:@"F1951C" alpha:1] forState:UIControlStateSelected];
    _careBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    
    _jubaoBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_jubaoBtn addTarget:self action:@selector(jubaoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_jubaoBtn setImage:[UIImage imageNamed:@"jubao"] forState:UIControlStateNormal];
    
    
    layerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:_header];
    [self.contentView addSubview:_name];
    [self.contentView addSubview:_deslabel];
    [self.contentView addSubview:_time];
    [self.contentView addSubview:_sees];
    [self.contentView addSubview:_talks];
    [self.contentView addSubview:_goods];
    [self.contentView addSubview:_careBtn];
    [self.contentView addSubview:_jubaoBtn];
    [self.contentView addSubview:layerView];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectZero];
    _bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self.contentView addSubview:_bgView];
    
    return self;
}


-(void)loadwithModel:(Hunqinnewarray *)model{
    CGFloat partwid = (cxwid - 48) / 3;
    NSString *des = model.content;
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGSize size = [des boundingRectWithSize:CGSizeMake(cxwid - 32, 1000000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    NSInteger sizehit = ceilf(size.height);
    CGFloat topdis = 10 + sizehit + 64 + (10 + partwid) * ((model.photourl.count - 1) / 3 + 1);
    if (model.photourl.count == 0) {
        topdis = 10 + sizehit + 64;
    }
    
    _header.frame = CGRectMake(14, 14, 37, 37);
    [_header sd_setImageWithURL:[NSURL URLWithString:model.head] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    _name.frame =CGRectMake(58, 16, cxwid - 58 - 80 - 80, 16);
    _name.text = model.nickname;
    
    _time.frame =CGRectMake(58, 40, cxwid - 58 - 80, 11);
    _time.text = model.create_ti;
    
    _careBtn.frame = CGRectMake(cxwid - 16 - 60, 22, 60, 24);
    
    _jubaoBtn.frame = CGRectMake(cxwid - 16 - 60 - 40 - 5, 15, 40, 40);
    
    //    _.frame = CGRectMake(28 + 75, 15, cxwid - 20 - 75 - 18, size.height);
    
    _deslabel.frame = CGRectMake(16, 64, cxwid - 32, sizehit);
    _deslabel.text = model.content;
    
   
    for (NSInteger index = 0; index < model.photourl.count; index ++) {
        UIImageView *partimage;
		
		
        if(index < _iCONS.count){
            partimage = _iCONS[index];
            partimage.hidden = NO;
            partimage.frame = CGRectMake(16 + (8 + partwid) * (index % 3), 10 + sizehit + 64 + (10 + partwid) * (index / 3), partwid, partwid);
        }
        else{
            partimage = [[UIImageView alloc] initWithFrame:CGRectMake(16 + (8 + partwid) * (index % 3), 10 + sizehit + 64 + (10 + partwid) * (index / 3), partwid, partwid)];
            [partimage setContentMode:UIViewContentModeScaleAspectFill];
            partimage.clipsToBounds = YES;
             [self.contentView addSubview:partimage];
            [_iCONS addObject:partimage];
        }
        partimage.userInteractionEnabled = YES;
#warning 查看大图点击
        // 给图片添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
        [partimage addGestureRecognizer:tap];
        tap.view.tag = index;
        NSString *imageurl = model.photourl[index].photourl;
        [partimage sd_setImageWithURL:[NSURL URLWithString:imageurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        partimage.backgroundColor = [UIColor lightGrayColor];
       
    }
    if (_iCONS.count > model.photourl.count) {
        for (NSInteger num = model.photourl.count; num < _iCONS.count; num ++) {
            UIImageView *imageview = _iCONS[num];
            imageview.hidden = YES;
        }
    }
    
    //    CGFloat topdis = 10 + sizehit + 64 + (10 + sizehit) * (model.photourl.count / 3 + 1) + 15;
    layerView.frame = CGRectMake(16, topdis - 1, cxwid - 32, 1);
    layerView.backgroundColor = [CXSinglerModel colorWithHex:@"d9d9d9" alpha:1];
    [self.contentView addSubview:layerView];
    for (NSInteger index = 0; index < 3; index ++) {
        UIButton *operationBtn;
        if (index == 0) {
            operationBtn = _sees;
        }
        else if (index == 1){
            operationBtn = _talks;
        }
        else if (index == 2){
            operationBtn = _goods;
        }
        operationBtn.frame = CGRectMake(cxwid / 3 * index, topdis,cxwid / 3, 30);
    }
    
    _bgView.frame = CGRectMake(0, topdis + 30, cxwid, 10);
    
    
#pragma mark--状态变化
    if (model.shifouzan == 1) {
        _goods.selected = YES;
    }
    else{
        _goods.selected = NO;
    }
    [_sees setTitle:[NSString stringWithFormat:@"%ld",model.pv] forState:UIControlStateNormal];
    [_talks setTitle:[NSString stringWithFormat:@"%ld",model.follow] forState:UIControlStateNormal];
    [_goods setTitle:[NSString stringWithFormat:@"%ld",model.zan] forState:UIControlStateNormal];
    [_careBtn setTitle:model.follow == 1 ? @"取消关注" : @"关注" forState:UIControlStateNormal];
//    self.backgroundColor = [UIColor clearColor];
//    self.contentView.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:bgView];
//    bgView.backgroundColor = [UIColor whiteColor];
    
//    [self.contentView addSubview:_header];
//    [self.contentView addSubview:_name];
//    [self.contentView addSubview:_time];
//    [self.contentView addSubview:_deslabel];
}

- (void)selectImage:(UITapGestureRecognizer *)sender {
	DLog(@"点击");
	self.onSelectedImg(sender.view.tag);
}
- (void)selectHeader:(UIButton *)sender {
    DLog(@"点击");
    self.onSelectedHeader();
}
- (void)jubaoBtnAction {
    self.onJubao();
}

-(void)operationTaped:(UIButton *)sender{
//    if ([sender isEqual:_careBtn]) {
//        _partTpaed(@"care");
//    }
//    if (sender.center.x < cxwid / 3) {
//        _partTpaed(@"see");
//    }
//    else if (sender.center.x < cxwid / 3 * 2){
//        _partTpaed(@"talk");
//    }
//    else{
//        _partTpaed(@"good");
//    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
