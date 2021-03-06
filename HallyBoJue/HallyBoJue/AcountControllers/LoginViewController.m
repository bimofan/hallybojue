//
//  LoginViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "LoginViewController.h"
#import "CommonMethods.h"
#import "UserInfo.h"
#import "XGPush.h"
#import "GetIPAddress.h"




@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"管家登录";
    
    _usernameTF.clipsToBounds = YES;
    _usernameTF.layer.cornerRadius = 6.0;
    
    _usernameTF.delegate = self;
    _codeTF.delegate = self;
    
    
    _codeTF.clipsToBounds = YES;
    _codeTF.layer.cornerRadius = 6.0;
    
    _summitbutton.clipsToBounds = YES;
    _summitbutton.layer.cornerRadius = 6.0;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)summit:(id)sender {
    
    if (_usernameTF.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写帐号"];
        
        return;
    }
    
    if (_codeTF.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写密码"];
        
        return;
    }
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (!deviceToken) {
        deviceToken = @"";
        
    }
    
    
    NSDictionary *param = @{@"mobile":_usernameTF.text,@"password":_codeTF.text,@"devicetoken":deviceToken};
    
     Usermodel *model = [[Usermodel alloc]init];
    
    [[NetWorking shareNetWorking] RequestWithAction:kLoginAction Params:param itemModel:model result:^(BOOL isSuccess, id data) {
       
       
        
        if (isSuccess) {
          
            
           
             [XGPush startApp:kXingePush_ACCESSID appKey:kXingePush_ACCESSKEY];
    
            //绑定信鸽推送
            [XGPush initForReregister:^{
                
             [XGPush setAccount:[NSString stringWithFormat:@"%@",model.mobile]];
                
             
                
                if (deviceToken) {
                    
                    
//                    [XGPush registerDevice:deviceToken];
                  NSString *devicetokenstr =  [XGPush registerDeviceStr:deviceToken];
                    
                    NSLog(@"devicetoken: %@",devicetokenstr);
                    
                    
                    
                }
                
            }];
      
           
                 model.vip_address = @"";
                [UserInfo saveUserInfo:model];
            
                
                [self dismissViewControllerAnimated:YES completion:nil];
            
   
            
            
        }
        
   
        
    }];
    
   
    
    
    
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
       
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 200);
        
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 200);
        
    }];
}
@end
