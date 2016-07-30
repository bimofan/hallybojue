//
//  ToPrintViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/29.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ToPrintViewController.h"
#import "Usermodel.h"


@implementation ToPrintViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _serviceTableView.delegate = self;
    _serviceTableView.dataSource = self;
    
    
}



-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    Usermodel *keeperModel = [UserInfo getUserModel];
    
    _keeperLabel.text = [NSString stringWithFormat:@" %@  %@",keeperModel.real_name,keeperModel.mobile];
    
    
    NSString *vipname = _orderModel.usermodel.vipcard_name;
    NSString *vipaddress = _orderModel.usermodel.vip_address;
    
    if (!vipname) {
        
        vipname= @"";
    }
    
    if (!vipaddress) {
        
        vipaddress  =@"";
    }
    
    _drivernameLabel.text = [NSString stringWithFormat:@" %@  %@  %@ %@",_orderModel.usermodel.nickname,_orderModel.usermodel.mobile,vipname,vipaddress];
    

    
    
}

-(void)setCarcheckArray:(NSArray *)carcheckArray
{
    _carcheckArray = carcheckArray;
    
    [_serviceTableView reloadData];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    label.text = @"";
    label.font = FONT_14;
    label.textAlignment = NSTextAlignmentLeft;
    
    if (section == 0) {
        
        label.text = @"  环车检查结果:";
    }
    else
    {
        label.text = @"  服务内容:";
    }
    return label;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return _carcheckArray.count;
    }
    else
    {
        return _orderModel.services.count;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        
        return 45;
    }
    
    return 80;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        
        UITableViewCell *carcheckcell = [tableView dequeueReusableCellWithIdentifier:@"carcheckcell"];
        
        UILabel *carcheckLabel = (UILabel*)[carcheckcell viewWithTag:99];
        
        NSDictionary *carcheck = [_carcheckArray objectAtIndex:indexPath.row];
        
        NSString *position = [carcheck objectForKey:@"position"];
        NSString *position_problem = [carcheck objectForKey:@"position_problem"];
     
        carcheckLabel.text = [NSString stringWithFormat:@"  %@-%@",position,position_problem];
        
        NSLog(@"carcheckcell");
        
        return carcheckcell;
        
    }
    
    else
    {
        
        UITableViewCell *servicecell = [tableView dequeueReusableCellWithIdentifier:@"workercell"];
        
        UILabel *serviceLabel = (UILabel*)[servicecell viewWithTag:100];
        
           serviceLabel.text = [[_orderModel.services objectAtIndex:indexPath.row] objectForKey:@"name"];
        
        return servicecell;
        
    }
}
@end
