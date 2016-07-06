//
//  CUserInfoController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/6.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "CUserInfoController.h"
#import "CarTableViewCell.h"

@interface CUserInfoController ()<UITableViewDelegate,UITableViewDataSource>

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
    
    
    _thirdBackView.clipsToBounds = YES;
    _thirdBackView.layer.cornerRadius = kCornerRadous;
    
    _vipLabel.clipsToBounds = YES;
    _vipLabel.layer.cornerRadius = kCornerRadous;
    
    _registCard.clipsToBounds = YES;
    _registCard.layer.cornerRadius = kCornerRadous;
    

    
    
    
    
    
}


-(void)setCUserModel:(CUserModel *)cUserModel
{
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[cUserModel.avatar objectForKey:@"avatar"]] placeholderImage:kDefaultHeadImage];
    
    _nameLabel.text = cUserModel.user_real_name;
    
    _vipLabel.text = cUserModel.level_name;
    
    _realNameLabel.text = cUserModel.user_real_name;
    
    _phoneLabel.text = [NSString stringWithFormat:@"%@",cUserModel.mobile];
    
    _addTimeLabel.text = cUserModel.add_time;
    
    
    _cUserModel = cUserModel;
    
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
            return _cUserModel.service_orders.count;
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
    return 2;
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    label.backgroundColor = [UIColor clearColor];
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
        
        if (_cUserModel.cars.count > indexPath.section) {
            
            NSDictionary *carDict = [_cUserModel.cars objectAtIndex:indexPath.section];
            
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
        
        if (_cUserModel.service_orders.count > indexPath.section) {
            
            NSDictionary *serviceDict = [_cUserModel.service_orders objectAtIndex:indexPath.section];
            
            cell.oneLabel.text = [serviceDict objectForKey:@"service_name"] ? [serviceDict objectForKey:@"service_name"] :@"";
            
            cell.twoLabel.text = [serviceDict objectForKey:@"order_time"] ?  [serviceDict objectForKey:@"order_time"]:@"";
            
            
        }
    }
    
    
    return cell;
}




#pragma mark - 开卡

- (IBAction)registCardAction:(id)sender {
    
    
    
    
    
}
@end
