//
//  DIpuAlertImageBaseView.m
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "DIpuAlertImageBaseView.h"

@interface DIpuAlertImageBaseView()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController * picker ;
@end
@implementation DIpuAlertImageBaseView

- (IBAction)SelectedImageAction:(id)sender {
    [self TakePhotoOrImageSelected:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)TakePhotoAction:(id)sender {
    [self TakePhotoOrImageSelected:UIImagePickerControllerSourceTypeCamera];
}
-(void)TakePhotoOrImageSelected:(UIImagePickerControllerSourceType)type{
    self.picker.sourceType =  type;
    self.picker.navigationBar.translucent = NO;
    [((UIViewController*)self.Object) presentViewController:self.picker animated:YES completion:nil];
}
- (IBAction)CancaleAction:(id)sender {
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(0, ScreenHeight, self.frame.size.width, ScreenHeight);
    }];
}
- (void)ShowView{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }completion:^(BOOL finished) {
        
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (self.type==btn) {
        [self.Btn setImage:info[UIImagePickerControllerOriginalImage] forState:(UIControlStateNormal)];
    }else{
      self.BackImageView.image = info[UIImagePickerControllerOriginalImage];
    }
    
    NSData * data = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.1);
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        
    }else{
        
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
        self.Mblock(data);
        [self CancaleAction:nil];
    }];
}
- (UIImagePickerController *)picker{
    if (!_picker) {
        _picker  = [[UIImagePickerController alloc]init];
        _picker.delegate = self;
    }
    return _picker;
}
@end
