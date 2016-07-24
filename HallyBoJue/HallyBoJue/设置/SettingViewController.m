//
//  SettingViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/18.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangeAvatarViewController.h"
#import "ChangePasswordViewController.h"


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) ChangeAvatarViewController *changeAvatarViewController;
@property (nonatomic,strong) ChangePasswordViewController *changePasswordViewController;



@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _leftView.clipsToBounds = YES;
    _leftView.layer.cornerRadius = kCornerRadous;
    
    
    
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    
    
}

-(ChangePasswordViewController*)changePasswordViewController
{
    if (!_changePasswordViewController) {
        
        _changePasswordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
        
        _changePasswordViewController.view.frame =CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
    }
    
    return _changePasswordViewController;
    
}


-(ChangeAvatarViewController*)changeAvatarViewController
{
    if (!_changeAvatarViewController) {
        
        _changeAvatarViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeAvatarViewController"];
        
        _changeAvatarViewController.view.frame =CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
        
        
    }
    
    return _changeAvatarViewController;
    
}

-(NSArray*)titles
{
    if (!_titles) {
        
        _titles = @[@"更换头像",@"修改密码",@"退出登录"];
    }
    
    return _titles;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    line.backgroundColor = kBackgroundColor;
    
    return line;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingcell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingcell"];
        
        
        
    }
    
    cell.textLabel.text = [_titles objectAtIndex:indexPath.section];
    
    cell.textLabel.textColor = kDarkTextColor;
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    cell.textLabel.font = FONT_17;
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (UIView *view in _rightView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    switch (indexPath.section) {
        case 0:
        {
            [self.rightView addSubview:self.changeAvatarViewController.view];
            
        }
            break;
        case 1:
        {
            [self.rightView addSubview:self.changePasswordViewController.view];
            
        }
            break;
        case 2:
        {
             [self logout];
        }
            break;
        case 3:
        {
           
        }
            break;
            
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

-(void)logout
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否退出当前管家账号?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
    
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:nil];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:@{} forKey:kUserInfo];
        
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kHadLogin];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        UINavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:YES completion:nil];
        
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
