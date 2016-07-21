//
//  FiveYuYueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/16.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FiveYuYueViewController.h"
#import "FiveYuYueCell.h"

@interface FiveYuYueViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation FiveYuYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _statusLabel.clipsToBounds = YES;
    _statusLabel.layer.cornerRadius = kCornerRadous;
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    _serviceTableView.delegate = self;
    _serviceTableView.dataSource = self;
    
    
    
}

-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    if (_orderModel.usermodel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_orderModel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
        
    }
    
    _realNameLabel.text = _orderModel.usermodel.nickname;
    
    _plate_numLabel.text = _orderModel.car_plate_num;
    
    _mobileLabel.text = _orderModel.usermodel.mobile;
    
    _timeLabel.text = _orderModel.order_time;
    
    _statusLabel.text = _orderModel.status_str;
    
    [_serviceTableView reloadData];
    
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _orderModel.services.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FiveYuYueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiveYuYueCell"];
    
    if (_orderModel.services.count > indexPath.section) {
        
        NSDictionary *service = [_orderModel .services objectAtIndex:indexPath.section];
        
        cell.serviceNameLabel.text = [service objectForKey:@"name"];
        
    }
    
    
    return cell;
    
    
}








@end
