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



@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"管家登录";
    
    _usernameTF.clipsToBounds = YES;
    _usernameTF.layer.cornerRadius = 6.0;
    
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
    
    NSDictionary *param = @{@"mobile":_usernameTF.text,@"password":_codeTF.text};
    
    [[NetWorking shareNetWorking] RequestWithAction:kLoginAction Params:param result:^(BOOL isSuccess, id data) {
       
       
        
        if (isSuccess) {
          
        
            if ([data isKindOfClass:[NSDictionary class]]) {
                
                
                Usermodel *model = [[Usermodel alloc]init];
                
                [model setValuesForKeysWithDictionary:data];
                
                [UserInfo saveUserInfo:model];
                
                
                [self dismissViewControllerAnimated:YES completion:nil];
            
                
            }

            
            
        }
        
   
        
    }];
    
   
    
    
    
    
}
@end
