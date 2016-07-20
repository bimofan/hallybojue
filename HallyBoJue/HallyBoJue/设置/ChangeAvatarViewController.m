//
//  ChangeAvatarViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/20.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ChangeAvatarViewController.h"
#import "Usermodel.h"

@interface ChangeAvatarViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@end

@implementation ChangeAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _changeButton.clipsToBounds = YES;
    _changeButton.layer.cornerRadius = kCornerRadous;
    
    Usermodel  *model = [UserInfo getUserModel];
    
    [_headImqgeView sd_setImageWithURL:[NSURL URLWithString:[model.avatar_img objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    
}






- (IBAction)changeAction:(id)sender {
    
    
    UIActionSheet *  _pickPhotoActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"相册图片描述"];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"手机拍照描述"];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"取消"];
    
    _pickPhotoActionSheet.cancelButtonIndex = 2;
    
    _pickPhotoActionSheet.tag = 99;
    
    
    
    [_pickPhotoActionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag ==99) {
        
        
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 2:
                {
                    return;
                }
                    break;
                    
                    
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 0: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        picker.sourceType = sourceType;
        
        
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        
        [popover presentPopoverFromRect:CGRectMake(0, 0, 600, 800) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
        
        
        
        
        
        
        
    }
    
    
}

#pragma mark -  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    image = [CommonMethods autoSizeImageWithImage:image];
    
    
    NSData *imagedata = UIImagePNGRepresentation(image);
    

    if (imagedata) {
        
        
        int keeper_id = [UserInfo getkeeperid];
        
        NSDictionary  *params = @{@"keeper_id":@(keeper_id)};
        
        [[NetWorking shareNetWorking] RequestWithAction:kChangeAvatar Params:params Data:imagedata name:@"avatar" filename:@"avatar.png" result:^(BOOL isSuccess, id data) {
           
               [MyProgressHUD dismiss];
            
            if (isSuccess) {
                
                self.headImqgeView.image = image;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kChangedAvatarNoti object:imagedata];
                
                if ([data isKindOfClass:[NSDictionary class]]) {
                    
                    Usermodel *model = [[Usermodel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:data];
                    
                    [UserInfo saveAvatar:model.avatar_img];
                }
           
                
                
                
            }
        }];
    }
    
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}



@end
