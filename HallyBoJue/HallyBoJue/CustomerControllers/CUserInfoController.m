//
//  CUserInfoController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/6.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "CUserInfoController.h"
#import "CarTableViewCell.h"
#import "SetRemindViewController.h"
#import "AddVipCardViewController.h"
#import "EditCarInfoViewController.h"




@interface CUserInfoController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) SetRemindViewController *setRemindViewController;
@property (nonatomic,strong) AddVipCardViewController *addVipCardViewController;
@property (nonatomic,strong) NSArray *services;
@property (nonatomic,strong) EditCarInfoViewController *editCarInfoViewController;






@end

@implementation CUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    _carTableView.delegate = self;
    _carTableView.dataSource = self;
    
    _firstBackView.clipsToBounds = YES;
    _firstBackView.layer.cornerRadius = kCornerRadous;
    
    _secondBackView.clipsToBounds = YES;
    _secondBackView.layer.cornerRadius = kCornerRadous;
    
    _updateCarInfo.clipsToBounds = YES;
    _updateCarInfo.layer.cornerRadius = kCornerRadous;
    _updateCarInfo.layer.borderColor = kBorderColor.CGColor;
    _updateCarInfo.layer.borderWidth = 1;
    
    
    
    _thirdBackView.clipsToBounds = YES;
    _thirdBackView.layer.cornerRadius = kCornerRadous;
    
    _vipLabel.clipsToBounds = YES;
    _vipLabel.layer.cornerRadius = kCornerRadous;
    
    _registCard.clipsToBounds = YES;
    _registCard.layer.cornerRadius = kCornerRadous;
    _registCard.layer.borderWidth = 1;
    _registCard.layer.borderColor = kBorderColor.CGColor;
    
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _RemindButton.clipsToBounds = YES;
    _RemindButton.layer.cornerRadius = kCornerRadous;
    _RemindButton.layer.borderColor = kBorderColor.CGColor;
    _RemindButton.layer.borderWidth = 1;
    
    
    

    
    
    
    
    
}

#pragma makr - EditCarInfoViewController
-(EditCarInfoViewController*)editCarInfoViewController
{
    if (!_editCarInfoViewController) {
        
        _editCarInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditCarInfoViewController"];
        
        _editCarInfoViewController.view.frame =self.view.frame;
        
       
        
        
    }
    
    return _editCarInfoViewController;
    
}

#pragma mark - AddVipCardViewController
-(AddVipCardViewController*)addVipCardViewController
{
    if (!_addVipCardViewController) {
        
        _addVipCardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddVipCardViewController"];
        
        _addVipCardViewController.view.frame = self.view.frame;
        
    }
    
    
    return _addVipCardViewController;
    
}

-(void)setCUserModel:(CUserModel *)cUserModel
{
    
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[cUserModel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _nameLabel.text = cUserModel.nickname;
    
    _vipLabel.text = cUserModel.level_name;
    
    _realNameLabel.text = cUserModel.nickname;
    
    _phoneLabel.text = [NSString stringWithFormat:@"%@",cUserModel.mobile];
    
    _addTimeLabel.text = cUserModel.reg_time;
    
    _vipaddresslabel.text = cUserModel.vip_address;
    
    _cUserModel = cUserModel;
    
    NSDictionary *dict  = [_cUserModel.service_orders firstObject];
    
    _services = [dict objectForKey:@"services"];
    
    
    [_setRemindViewController.view removeFromSuperview];
    
    [_addVipCardViewController.view removeFromSuperview];
    
    _setRemindViewController = nil;
    _addVipCardViewController = nil;
    
    
    [_carTableView reloadData];
    
    
    
     
}

#pragma mark - UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            
            return _cUserModel.cars.count;
        }
            break;
        case 1:
        {
            return _services.count;
        }
            break;
            
            
        default:
        {
            return 1;
        }
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = kDarkTextColor;
    label.font = FONT_15;
    
    if (section == 0) {
        
        
        label.text = @"车辆信息";
        
        return label;
        
        
    }
    else
    {
        
        label.text = @"最近一次服务记录";
        
        return label;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarTableViewCell"];
    
    if (indexPath.section == 0) {
        
        if (_cUserModel.cars.count > indexPath.row) {
            
            NSDictionary *carDict = [_cUserModel.cars objectAtIndex:indexPath.row];
            
            cell.oneLabel.text = [carDict objectForKey:@"brand_name"];
            
            NSString *carbrand =[carDict objectForKey:@"plate_number"]?[carDict objectForKey:@"plate_number"]:@"";
            NSString *mileage  = [carDict objectForKey:@"mileage"]?[carDict objectForKey:@"mileage"]:@"未知";
            
            
            if ([mileage isEqual:[NSNull null]]) {
                
                mileage = @"未知";
                
            }
            cell.twoLabel.text = [NSString stringWithFormat:@"%@  行驶里程:%@",carbrand,mileage];
            
    
            
        }
    }
    else
    {
        
        cell.oneLabel.text = nil;
        cell.twoLabel.text = nil;
        
        if (_services.count > indexPath.row) {
            
            NSDictionary *serviceDict = [_services objectAtIndex:indexPath.row];
            
            cell.oneLabel.text = [serviceDict objectForKey:@"service_name"] ? [serviceDict objectForKey:@"service_name"] :@"";
            
            cell.twoLabel.text = [serviceDict objectForKey:@"order_time"] ?  [serviceDict objectForKey:@"order_time"]:@"";
            
            
        }
    }
    
    
    return cell;
}



-(SetRemindViewController*)setRemindViewController
{
    if (!_setRemindViewController) {
        
        _setRemindViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"SetRemindViewController"];
        
        _setRemindViewController.view.frame = self.view.frame;
        
    }
    
    return _setRemindViewController;
    
}

#pragma mark - 设置跟进提醒

- (IBAction)setRemindAction:(id)sender {
    
    
    
    self.setRemindViewController.cUserModel =_cUserModel;
    
    [self.view.superview addSubview:self.setRemindViewController.view];
    
    [self.view removeFromSuperview];
    
    
}

#pragma mark - 修改车辆信息
- (IBAction)updateCarInfoAction:(id)sender {
    
    
    self.editCarInfoViewController.cUserModel = _cUserModel;
    
    [self.view.superview addSubview:self.editCarInfoViewController.view];
    
    [self.view removeFromSuperview];
    
    
    
}
#pragma mark - 开卡


- (IBAction)registCardAction:(id)sender {
    
    
    self.addVipCardViewController.cUserModel = _cUserModel;
    
    [self.view.superview addSubview:self.addVipCardViewController.view];
    
    [self.view removeFromSuperview];
    
    
    
}
@end
