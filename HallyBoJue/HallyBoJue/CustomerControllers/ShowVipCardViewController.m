//
//  ShowVipCardViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/8/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ShowVipCardViewController.h"
#import "ShowVipCardCell.h"
#import "ChoseVipLeftCellTableViewCell.h"

@interface ShowVipCardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_vipcards;
    
    NSArray *_services;
    
    NSDictionary *_selecteddict;
    
    
}
@end

@implementation ShowVipCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"客户会籍卡信息";
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.navigationItem.leftBarButtonItem = cancel;
    
    _serviceTableView.delegate = self;
    _serviceTableView.dataSource = self;
    _vipcardTableView.delegate = self;
    _vipcardTableView.dataSource = self;
    
    
}
-(void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    
    [self getvipcards];
    
}
-(void)getvipcards
{
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:kGetVipCardUser_id];
    
    [[NetWorking shareNetWorking] RequestWithAction:kCustomerUservipcardinfo Params:@{@"user_id":user_id} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            DataModel *model = (DataModel*)data;
            
            _vipcards = model.items;
            
            if (_vipcards.count > 0) {
                
                _selecteddict = [_vipcards firstObject];
                [self setheaderView];
                
                _services = [_selecteddict objectForKey:@"services"];
                
            }
            
            [_vipcardTableView reloadData];
            [_serviceTableView reloadData];
            
            
            
            
        }
    }];
    
}

-(void)setheaderView
{
    _vipcardnameLabel.text = [_selecteddict objectForKey:@"card_name"];
    _validateLabel.text = [_selecteddict objectForKey:@"expire_time"];
    
    NSDictionary *car = [_selecteddict objectForKey:@"car"];
    NSDictionary *brand = [_selecteddict objectForKey:@"brand"];
    
    
    _carinfoLabel.text = [NSString stringWithFormat:@"%@ %@",[car objectForKey:@"plate_number"],[brand objectForKey:@"series"]?[brand objectForKey:@"series"]:@""];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _vipcardTableView) {
        
        return _vipcards.count;
        
    }
    else
    {
        return _services.count;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _vipcardTableView) {
        
        return 140;
    }
    else
    {
        return 60;
        
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _vipcardTableView) {
        
        ChoseVipLeftCellTableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:@"ChoseVipLeftCellTableViewCell"];
        
        NSDictionary *onecarddict = [_vipcards objectAtIndex:indexPath.row];
        
        [leftCell.vipImageView sd_setImageWithURL:[NSURL URLWithString:[[onecarddict objectForKey:@"template_image"]objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
        if ([[onecarddict objectForKey:@"card_id"] integerValue] == [[_selecteddict objectForKey:@"card_id"]integerValue]) {
            
            leftCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            leftCell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        
        return leftCell;
        
    }
    else
    {
        
        ShowVipCardCell *rightCell = [tableView dequeueReusableCellWithIdentifier:@"ShowVipCardCell"];
        
        NSDictionary *servicedict = [_services objectAtIndex:indexPath.row];
        
        rightCell.nameLabel.text = [servicedict objectForKey:@"service_name"];
        
        rightCell.leftTimeLabel.text = [NSString stringWithFormat:@"剩余:%d张  ",[[servicedict objectForKey:@"service_count"]intValue]];
        
        
        int type = [[servicedict objectForKey:@"service_type"]intValue];
        
        switch (type) {
            case 1:
            {
                rightCell.discountLabel.text =  [NSString stringWithFormat:@"%.1f折",[[servicedict objectForKey:@"discount"]floatValue] ];
            }
                break;
            case 2:
            {
                rightCell.discountLabel.text = [NSString stringWithFormat:@"抵扣￥%.2f",[[servicedict objectForKey:@"discount"]floatValue]];
            }
                break;
            case 3:
            {
                NSMutableString *vipString = [[NSMutableString alloc]init];
                
                NSArray *gift = [servicedict objectForKey:@"gift"];
                if (gift) {
                    
                    for (int i = 0; i < gift.count; i++) {
                        
                        NSDictionary *oneGift = [gift objectAtIndex:i];
                        
                        CGFloat price = [[oneGift objectForKey:@"price"]floatValue];
                        
                        NSString *service_name = [oneGift objectForKey:@"service_name"];
                        
                        int number = [[oneGift objectForKey:@"number"]intValue];
                        
                        NSString *onegiftString = [NSString stringWithFormat:@"%d份价值%.0f元的【%@】",number,price,service_name];
                        
                        if (vipString.length == 0) {
                            
                            [vipString appendString:onegiftString];
                        }
                        else
                        {
                            [vipString appendFormat:@"\n%@",onegiftString];
                        }
                    }
                    
                }
                
                rightCell.discountLabel.text = [NSString stringWithFormat:@"买1送:%@",vipString];
                
                
            }
                break;
                
                
            default:
                break;
        }
        
        
        return rightCell;
        
        
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _vipcardTableView) {
        
         _selecteddict = [_vipcards objectAtIndex:indexPath.row];
        
        _services = [_selecteddict objectForKey:@"services"];
        
        [_serviceTableView reloadData];
        [_vipcardTableView reloadData];
        
        
        
        
    }
   
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
