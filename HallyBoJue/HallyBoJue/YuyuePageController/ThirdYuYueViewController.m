//
//  ThirdYuYueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/12.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ThirdYuYueViewController.h"
#import "ThirdYuYueCell.h"
#import "Constants.h"


@interface ThirdYuYueViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@end

@implementation ThirdYuYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    _serviceTableView.delegate = self;
    _serviceTableView.dataSource = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _statusLabel.clipsToBounds = YES;
    _statusLabel.layer.cornerRadius = kCornerRadous;
    
    _headImageView.clipsToBounds= YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    _checkCarButton.clipsToBounds = YES;
    _checkCarButton.layer.cornerRadius = kCornerRadous;
    _checkCarButton.layer.borderColor = kBorderColor.CGColor;
    _checkCarButton.layer.borderWidth = 1;
    
    
    _doneButton.clipsToBounds = YES;
    _doneButton.layer.cornerRadius = kCornerRadous;
    _doneButton.layer.borderWidth = 1;
    _doneButton.layer.borderColor = kBorderColor.CGColor;
    
    
    
    
    
    
}

-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    _statusLabel.text = _orderModel.status_str;
    
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    if (_orderModel.usermodel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_orderModel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    }
    else
    {
        _headImageView.image = kDefaultHeadImage;
        
    }
    
    
    
    _realNameLabel.text = _orderModel.usermodel.nickname;
    
    _plateNumLabel.text = _orderModel.car_plate_num;
    
    _mobileLabel.text = _orderModel.usermodel.mobile;
    
    _timeLabel.text = _orderModel.order_time;
    
     _vipcard_Label.text = [NSString stringWithFormat:@" %@ %@",orderModel.usermodel.vipcard_name,orderModel.usermodel.vip_address];
    [_serviceTableView reloadData];
    
    
    
    
}


#pragma mark - UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _orderModel.services.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ThirdYuYueCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdYuYueCell"];
    
    NSDictionary *service = [_orderModel.services objectAtIndex:indexPath.section];
    
    cell.serviceNameLabel.text = [service objectForKey:@"name"];
    
    
//    if ([workplace objectForKey:@"name"];) {
//        <#statements#>
//    }
    cell.workplaceLabel.text = [service objectForKey:@"workplace_name"];
    
    NSMutableString *mustring = [[NSMutableString alloc]init];
    
    NSArray *workers = [service objectForKey:@"workers"];
    
    for (int i = 0; i < workers.count; i++) {
        
        NSDictionary *worker = [ workers objectAtIndex:i];
        
        if (mustring.length == 0) {
            
            if ([worker objectForKey:@"worker_real_name"] ) {
                
                [mustring appendString:[worker objectForKey:@"worker_real_name"]];
            }
            else
            {
                
            }
         
            
        }
        else
        {
            [mustring appendString:[NSString stringWithFormat:@"  %@",[worker objectForKey:@"worker_real_name"]]];
            
        }
        
    }
    
    cell.workerLabel.text = mustring;
    
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 165;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section == _orderModel.services.count -1) {
        
        return 0;
        
    }
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    view.backgroundColor = kBackgroundColor;
    
    
    return view;
    
}




- (IBAction)checkCarAction:(id)sender {
    
    
    
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]init];
    
    [mudict setObject:@(_orderModel.store_id) forKey:@"store_id"];
    [mudict setObject:@(_orderModel.user_id) forKey:@"user_id"];
    [mudict setObject:@(_orderModel.id) forKey:@"service_order_id"];
    [mudict setObject:@(_orderModel.car_id) forKey:@"user_car_id"];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:mudict forKey:kOrderInfo];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"CarCheckNav"];
    
    [self.superViewController presentViewController:nav animated:YES completion:nil];
    
    
}



- (IBAction)doneAction:(id)sender {
    
    

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定完成吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = 9999;
    
    [alert show];

    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9999 && buttonIndex == 1) {
        
        
        
        [[NetWorking shareNetWorking] RequestWithAction:kCheckappoint Params:@{@"order_id":@(_orderModel.id),@"status":@(5)} itemModel:nil result:^(BOOL isSuccess, id data) {
            
            if (isSuccess) {
                
                
                _orderModel.status = 5;
                _orderModel.status_str = @"服务完成";
                
                if ([self.delegate respondsToSelector:@selector(didDoneService:)]) {
                    
                    [self.delegate didDoneService:_orderModel];
                    
                }
                
                
            }
            
            
            
        }];
    }
}


@end
