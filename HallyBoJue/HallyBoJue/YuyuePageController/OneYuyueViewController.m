//
//  OneYuyueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/8.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "OneYuyueViewController.h"
#import "OneYuyueCell.h"



@interface OneYuyueViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation OneYuyueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _statusLabel.clipsToBounds = YES;
    _statusLabel.layer.cornerRadius = kCornerRadous;
    
    _timeTwoLabel.clipsToBounds = YES;
    _timeTwoLabel.layer.cornerRadius = kCornerRadous;
    
    _checkButton.clipsToBounds = YES;
    _checkButton.layer.cornerRadius = kCornerRadous;
    
    _sendButton.clipsToBounds = YES;
    _sendButton.layer.cornerRadius = kCornerRadous;
    
    

}

-(void)setOrdermodel:(OrderModel *)ordermodel
{
    _ordermodel = ordermodel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_ordermodel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _realnameLabel.text = ordermodel.usermodel.user_real_name;
    
    _plateLabel.text = ordermodel.car_plate_num;
    
    _mobileLabel.text = ordermodel.usermodel.mobile;
    
    _timeOneLabel.text = ordermodel.order_time;
    
    _statusLabel.text = ordermodel.status_str;
    
    _timeTwoLabel.text = ordermodel.order_time;
    
    [_serviceTable reloadData];
    
    
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _ordermodel.services.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 5)];
    
    backView.backgroundColor = kBackgroundColor;
    
    
    return backView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    OneYuyueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneYuyueCell"];
    
    cell.service_nameLabel.text = [[_ordermodel.services objectAtIndex:indexPath.section] objectForKey:@"service_name"];
    
    
    
    return cell;
    
    
}



- (IBAction)checkAction:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectedCarCheck)]) {
        
        [self.delegate didSelectedCarCheck];
        
    }
 
    
    
}
- (IBAction)sendAction:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(startSendWorders:)]) {
        
        
        [self.delegate startSendWorders:_ordermodel];
        
        
    }
    
    
    
    
}
@end
