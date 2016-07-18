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
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
    
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
        
        
        
        
    }
//
//    servicelistCell.servicesLabel.text = muStrig;
//    
//    servicelistCell.storeNameLabel.text = model.store_name;
//    servicelistCell.keeper_nameLabel.text = model.keeper_name;
//    servicelistCell.timeLabel.text = model.order_time;
//    
    
    
    return servicelistCell;
}




- (IBAction)setRemindAction:(id)sender {
}
@end
