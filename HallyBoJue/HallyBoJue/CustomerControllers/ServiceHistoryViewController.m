//
//  ServiceHistoryViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/18.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ServiceHistoryViewController.h"
#import "FollowServiceListCell.h"

@interface ServiceHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation ServiceHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _historyTable.delegate =self;
    _historyTable.dataSource = self;
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    _vipNameLabel.clipsToBounds = YES;
    _vipNameLabel.layer.cornerRadius = kCornerRadous;
    
    _setRemindButton.clipsToBounds = YES;
    _setRemindButton.layer.cornerRadius = kCornerRadous;
    
    
    
    
}


-(void)setCUsermodel:(CUserModel *)cUsermodel
{
    _cUsermodel = cUsermodel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_cUsermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    _realNameLabel.text = _cUsermodel.user_real_name;
    
    _vipNameLabel.text = _cUsermodel.level_name;
    _vipAddressLabel.text = _cUsermodel.vip_address;
    
    
    [_historyTable reloadData];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *oneService_order = [_cUsermodel.service_orders objectAtIndex:indexPath.section];
    
    NSArray *services = [oneService_order objectForKey:@"services"];
    
    return 130 + services.count *40 ;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cUsermodel.service_orders.count;
    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    FollowServiceListCell *servicelistCell = [tableView dequeueReusableCellWithIdentifier:@"FollowServiceListCell"];
    
    NSDictionary *oneService_order = [_cUsermodel.service_orders objectAtIndex:indexPath.section];
    
    NSArray *services = [oneService_order objectForKey:@"services"];
    
    servicelistCell.servicesLabelHeigh.constant = 40 * services.count;
    
    NSMutableString *muString = [[NSMutableString alloc]init];
    
    for (int i = 0; i < services.count; i ++) {
        
        NSDictionary *dict = [services objectAtIndex:i];
        
        NSString *servcie_name = [dict objectForKey:@"service_name"];
        
        if (muString.length == 0) {
            
            [muString appendString:servcie_name];
        }
        else
        {
            [muString appendFormat:@"\n \n%@",servcie_name ] ;
                                              
        }
        
        
    }
    
    servicelistCell.servicesLabel.text = muString;
    servicelistCell.storeNameLabel.text = [oneService_order objectForKey:@"store_name"];
    servicelistCell.keeper_nameLabel.text = [oneService_order objectForKey:@"keeper_name"];
    
    
    servicelistCell.timeLabel.text = [oneService_order objectForKey:@"order_time"];

    
    
    return servicelistCell;
}




- (IBAction)setRemindAction:(id)sender {
}
@end
