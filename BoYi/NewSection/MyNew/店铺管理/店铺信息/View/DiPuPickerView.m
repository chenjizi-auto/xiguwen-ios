//
//  DiPuPickerView.m
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DiPuPickerView.h"
#import "DipuModel.h"
@interface DiPuPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *PickerView;

@end
@implementation DiPuPickerView
{
    NSArray * dataSourcess;
    NSInteger Types; //表示类型 1.店铺类型 2.职业类型 3 . 表示城市选择
    NSInteger firstPickeIndext;
    NSInteger twoPickeIndext;
    
    
    NSString * Name;//组合名字
    NSString * Ids;//组合id
}
-(void)PickdataSources:(NSArray *)dataSources type:(NSInteger)type{
    
    //初始化信息，解决不滚动回调错误
    if (Name) {
        Name = nil;
        Ids = nil;
    }
    
    twoPickeIndext= 0;
    firstPickeIndext=0;
    Types = type;
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(0, ScreenHeight -200, ScreenWidth, 200);
    }];
    dataSourcess = dataSources;
    self.PickerView.dataSource = self;
    self.PickerView.delegate = self;
    [self.PickerView selectRow:0 inComponent:0 animated:YES];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return Types!=3?dataSourcess.count:component==0?dataSourcess.count:component==1?((DipuCityModel*)(dataSourcess[firstPickeIndext])).cityModel.count:(((DipuCityModel*)(dataSourcess[firstPickeIndext])).cityModel[twoPickeIndext]).countyModel.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return Types!=3?(Types==1?dataSourcess[row]:((DipuIficationObjc*)(dataSourcess[row])).proname):component==0?((DipuCityModel*)dataSourcess[row]).name:component==1?((DipuCityModel*)(((DipuCityModel*)(dataSourcess[firstPickeIndext])).cityModel[row])).name:((DipuCityModel*)(((DipuCityModel*)(((DipuCityModel*)(dataSourcess[firstPickeIndext])).cityModel[twoPickeIndext])).countyModel[row])).name;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (Types==3) {
        if (component == 0) {
            [pickerView selectRow:0 inComponent:1 animated:NO];
            firstPickeIndext = row;
            twoPickeIndext = 0;
        }
        
        [pickerView reloadComponent:1];
        
        if (!self.isCityChoose) {
            if (component == 0) {
                [pickerView selectRow:0 inComponent:2 animated:NO];
                [pickerView reloadComponent:2];
            /*-----新增-----*/
            }else if (component == 1) {
                twoPickeIndext = row;
                [pickerView selectRow:0 inComponent:2 animated:NO];
                [pickerView reloadComponent:2];
            }
            /*-----结束-----*/
        }
        
        DipuCityModel * model1 =((DipuCityModel*)dataSourcess[ component == 0 ? row : firstPickeIndext]);
        DipuCityModel * model2 =(DipuCityModel*)(((DipuCityModel*)(dataSourcess[firstPickeIndext])).cityModel[component==1?row:twoPickeIndext]);
        
        DipuCityModel * model3  = ((DipuCityModel*)(((DipuCityModel*)(((DipuCityModel*)(dataSourcess[firstPickeIndext])).cityModel[twoPickeIndext])).countyModel[component == 2 ? row : 0]));
    
        Name = [NSString stringWithFormat:@"%@,%@,%@",model1.name,model2.name,model3.name];
        Ids = [NSString stringWithFormat:@"%lu-%lu-%lu",(unsigned long)model1.id,model2.id,model3.id];
        NSLog(@"%@",Name);
    } else if(Types==1){
        Name = dataSourcess[row];
        Ids = [NSString stringWithFormat:@"%ld",row+1];
    }else{
        Name = ((DipuIficationObjc*)(dataSourcess[row])).proname;
        Ids = [NSString stringWithFormat:@"%ld",((DipuIficationObjc*)(dataSourcess[row])).occupationid];
        
    }
    
   
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.isCityChoose) {
        return Types==3?2:1;
    }
    return Types==3?3:1;
}
- (IBAction)DownAction:(id)sender {
    
    if (!Name) {
        if (Types==3) {
            
            DipuCityModel * model1 =((DipuCityModel*)dataSourcess[firstPickeIndext]);
            DipuCityModel * model2 =(DipuCityModel*)(((DipuCityModel*)(dataSourcess[firstPickeIndext])).cityModel[twoPickeIndext]);
            
            DipuCityModel * model3  = ((DipuCityModel*)(((DipuCityModel*)(((DipuCityModel*)(dataSourcess[firstPickeIndext])).cityModel[twoPickeIndext])).countyModel[0]));
            
            Name = [NSString stringWithFormat:@"%@,%@,%@",model1.name,model2.name,model3.name];
            Ids = [NSString stringWithFormat:@"%lu-%lu-%lu",(unsigned long)model1.id,model2.id,model3.id];
            
        } else if(Types==1){
            Name = dataSourcess[0];
            Ids = [NSString stringWithFormat:@"%d",1];
        }else{
            Name = ((DipuIficationObjc*)(dataSourcess[0])).proname;
            Ids = [NSString stringWithFormat:@"%ld",((DipuIficationObjc*)(dataSourcess[0])).occupationid];
            
        }
    }
    self.Mblock(Name, Ids,Types==3?city:Types==2?ShopType:Occupational);
  
    [UIView animateWithDuration:0.6 animations:^{
          self.frame = CGRectMake(0, ScreenHeight , ScreenWidth, 200);
    }];
}

- (IBAction)CancalAction:(id)sender {
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(0, ScreenHeight , ScreenWidth, 200);
    }];
}

@end
