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
    
    _orderidLabel.text = [NSString stringWithFormat:@"订单号:%@",_orderModel.so_number];
    _orderidLabel.adjustsFontSizeToFitWidth = YES;
    
    _startTimeLabel.text = [CommonMethods getYYYYMMddhhmmDateStr:[NSDate date]];
    
    _carinfoLabel.text = [NSString stringWithFormat:@"%@",_orderModel.car_plate_num];
 
    
    int expecte_time = [_orderModel.expecte_time intValue]/60;
    
    if (expecte_time > 0) {
        
         _etaLabel.text = [NSString stringWithFormat:@"预计时间:%d分钟",expecte_time];
    }
    else
    {
        if (!_orderModel.expecte_time) {
            
            _orderModel.expecte_time = @"     ";
        }
        
         _etaLabel.text = [NSString stringWithFormat:@"预计时间:%@分钟", _orderModel.expecte_time];
        
    }
   
    
  

    
    
}

-(void)setCarcheckArray:(NSArray *)carcheckArray
{
    NSMutableArray *temcarcheckarray = [[NSMutableArray alloc]init];
    
    int d = 0;
    
    NSMutableArray *smallarray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < carcheckArray.count; i++) {
        
        NSDictionary *onecheck = [carcheckArray objectAtIndex:i];
        
        d = i%2;
        
        [smallarray addObject:onecheck];
        
        
        if (d == 1) {
            
            [temcarcheckarray addObject:smallarray];
            
            smallarray = [[NSMutableArray alloc]init];
        }
        
        if (d == 0 && i == carcheckArray.count -1) {
            
            [temcarcheckarray addObject:smallarray];
        }
        
    
        
        
    }
    _carcheckArray = temcarcheckarray;
    
    [_serviceTableView reloadData];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
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
        
        return 30;
    }
    
    return 80;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        
        UITableViewCell *carcheckcell = [tableView dequeueReusableCellWithIdentifier:@"carcheckcell"];
        
        UILabel *carcheckLabel = (UILabel*)[carcheckcell viewWithTag:99];
        UILabel *secLabel = (UILabel*)[carcheckcell viewWithTag:100];
        
       NSArray *smallarray  = [_carcheckArray objectAtIndex:indexPath.row];
        
        NSDictionary *carcheck = [smallarray firstObject];
        
        NSString *position = [carcheck objectForKey:@"position"];
        NSString *position_problem = [carcheck objectForKey:@"position_problem"];
     
        carcheckLabel.text = [NSString stringWithFormat:@"  %@-%@",position,position_problem];
        
        
        if (smallarray.count > 1) {
            
            NSDictionary *secdict = [smallarray objectAtIndex:1];
            
            NSString *secposition = [secdict objectForKey:@"position"];
            NSString *secposition_problem = [secdict objectForKey:@"position_problem"];
            
            secLabel.text = [NSString stringWithFormat:@"  %@-%@",secposition,secposition_problem];
        }
        else
        {
            secLabel.text = nil;
            
        }
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
