//
//  OneYuyueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/8.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "OneYuyueViewController.h"
#import "OneYuyueCell.h"
#import "AddServiceViewController.h"




@interface OneYuyueViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>


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
    
    _checkButton.layer.borderColor = kBorderColor.CGColor;
    _checkButton.layer.borderWidth = 1;
    
    
    _sendButton.clipsToBounds = YES;
    _sendButton.layer.cornerRadius = kCornerRadous;
    _sendButton.layer.borderWidth = 1;
    _sendButton.layer.borderColor =kBorderColor.CGColor;
    
    
    _addServiceButton.clipsToBounds = YES;
    _addServiceButton.layer.cornerRadius = kCornerRadous;
    
    _headImageView.clipsToBounds=  YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    
    
    _serviceTable.delegate = self;
    _serviceTable.dataSource = self;
    
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(addserviceNotice:) name:kAddServieNotice object:nil];
    
    
    

}

-(void)setOrdermodel:(OrderModel *)ordermodel
{
    _ordermodel = ordermodel;
    
    
    if (_ordermodel.usermodel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_ordermodel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    }
    
    
    _realnameLabel.text = ordermodel.usermodel.nickname;
    
    _plateLabel.text = ordermodel.car_plate_num;
    
    _mobileLabel.text = ordermodel.usermodel.mobile;
    
    _timeOneLabel.text = ordermodel.order_time;
    
    _statusLabel.text = ordermodel.status_str;
    
    _timeTwoLabel.text = ordermodel.order_time;
    
    if (_ordermodel.status == 1)//预约中
    {
        
        _checkButton.hidden = YES;
        _addServiceButton.hidden = YES;
        
        [_sendButton setTitle:@"确认预约" forState:UIControlStateNormal];
        
        
    }
    else  //预约确认
    {
        _checkButton.hidden = NO;
        _addServiceButton.hidden = NO;
        
        [_sendButton setTitle:@"开始派工" forState:UIControlStateNormal];
    }
    
    
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
    return 0;
    
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
    
    cell.service_nameLabel.text = [[_ordermodel.services objectAtIndex:indexPath.section] objectForKey:@"name"];
    
    
    
    return cell;
    
    
}



- (IBAction)checkAction:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectedCarCheck:)]) {
        
        [self.delegate didSelectedCarCheck:_ordermodel];
        
    }
 
    
    
}
- (IBAction)sendAction:(id)sender {
    
   
 
    if (_ordermodel.status == 1)//预约中
    {
        if ([self.delegate respondsToSelector:@selector(startSendWorders:)]) {
            
            
            [self.delegate startSendWorders:_ordermodel];
            
            
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定开始派工吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alert.tag = 9999;
        
        [alert show];
    }

    
    
    
    
    
    
}
- (IBAction)addServiceAction:(id)sender {
    
   
    
    
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]init];
    
    [mudict setObject:@(_ordermodel.store_id) forKey:@"store_id"];
    [mudict setObject:@(_ordermodel.user_id) forKey:@"user_id"];
    [mudict setObject:@(_ordermodel.id) forKey:@"service_order_id"];
    [mudict setObject:@(_ordermodel.car_id) forKey:@"user_car_id"];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:kAddNewServiceType];

    
    [[NSUserDefaults standardUserDefaults] setObject:mudict forKey:kOrderInfo];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AddServiceNav"];
    
    
    [self.superViewController presentViewController:nav animated:YES completion:nil];
    
    
    
    
}


#pragma mark - 接收添加服务通知
-(void)addserviceNotice:(NSNotification*)note
{
    NSLog(@"object:%@",note.object);
    
    NSMutableArray *muarray = [[NSMutableArray alloc]init];
    
    [muarray addObjectsFromArray:_ordermodel.services];
    
    
    
    NSArray *newservices = note.object;
    
    for (int i = 0; i < newservices.count; i++) {
        
        NSDictionary *dict  = [newservices objectAtIndex:i];
        
        BOOL contented = NO;
        
        int service_id = [[dict objectForKey:@"id"]intValue];
        
        for (int d = 0; d < _ordermodel.services.count; d++) {
            
            NSDictionary *temdict = [_ordermodel.services objectAtIndex:d];
            
            int temid = [[temdict objectForKey:@"id"]intValue];
            
            if (temid == service_id) {
                
                contented = YES;
            }
        }
        
        if (!contented) {
            
            [muarray addObject:dict];
            
        }
    }
    
    
    
    
    
    _ordermodel.services = muarray;
    
    
    [_serviceTable reloadData];
    
    
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9999  && buttonIndex == 1) {
        
        if ([self.delegate respondsToSelector:@selector(startSendWorders:)]) {
            
            
            [self.delegate startSendWorders:_ordermodel];
            
            
        }
        
    }
}
@end
