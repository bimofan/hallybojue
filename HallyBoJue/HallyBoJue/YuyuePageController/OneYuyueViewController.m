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
    
    _addServiceButton.clipsToBounds = YES;
    _addServiceButton.layer.cornerRadius = kCornerRadous;
    
    
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
    
    
    _realnameLabel.text = ordermodel.usermodel.user_real_name;
    
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
    
    

    
    if ([self.delegate respondsToSelector:@selector(startSendWorders:)]) {
        
        
        [self.delegate startSendWorders:_ordermodel];
        
        
    }
    
    
    
    
}
- (IBAction)addServiceAction:(id)sender {
    
   
    
    
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]init];
    
    [mudict setObject:@(_ordermodel.store_id) forKey:@"store_id"];
    [mudict setObject:@(_ordermodel.user_id) forKey:@"user_id"];
    [mudict setObject:@(_ordermodel.id) forKey:@"service_order_id"];
    [mudict setObject:@(_ordermodel.car_id) forKey:@"user_car_id"];
    
    
    
    
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
    
    [muarray addObjectsFromArray:note.object];
    
    _ordermodel.services = muarray;
    
    
    [_serviceTable reloadData];
    
    
}
@end
