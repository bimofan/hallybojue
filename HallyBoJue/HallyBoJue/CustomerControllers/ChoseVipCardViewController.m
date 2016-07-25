//
//  ChoseVipCardViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/20.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ChoseVipCardViewController.h"
#import "ChoseVipRightCell.h"
#import "ChoseVipLeftCellTableViewCell.h"

@interface ChoseVipCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *vipCardsArray;
@property (nonatomic,strong) NSDictionary *selectedVipDict;

@property (nonatomic,strong) NSMutableArray *selectedServiceArray;


@end

@implementation ChoseVipCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    
    _vipServiceTableView.delegate = self;
    _vipServiceTableView.dataSource = self;
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.navigationItem.leftBarButtonItem = cancel;
    
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(ok)];
    
    self.navigationItem.rightBarButtonItem = okButton;
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    
    if (_vipCardsArray.count == 0) {
        
         [self getvipdatas];
        
    }
    
        

}

-(void)ok
{
    
    if (_selectedVipDict) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidSelectedVipCardNoti object:_selectedVipDict];
    }
    
    
    
     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)getvipdatas
{
    [[NetWorking shareNetWorking] RequestWithAction:kGetVipCardTemplates Params:nil itemModel:nil result:^(BOOL isSuccess, DataModel* data) {
       
        if (isSuccess) {
            
            _vipCardsArray = [[NSMutableArray alloc]init];
            
            [_vipCardsArray addObjectsFromArray:data.items];
            
            _selectedVipDict = [_vipCardsArray firstObject];
            
            _selectedServiceArray = [_selectedVipDict objectForKey:@"services"];
            
            
            
             [self setheaderView];
            
            [_leftTableView reloadData];
            [_vipServiceTableView reloadData];
            
            
        }
        
    }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _leftTableView) {
        
        return _vipCardsArray.count;
    }
    else
    {
        return _selectedServiceArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        
        ChoseVipLeftCellTableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:@"ChoseVipLeftCellTableViewCell"];
        
        NSDictionary *dict = [_vipCardsArray objectAtIndex:indexPath.section];
        
        NSString *imageurl = [[dict objectForKey:@"template_image"] objectForKey:@"origin"];
        
        leftCell.contentView.contentMode = UIViewContentModeScaleAspectFill;
        
//        leftCell.vipImageView.contentMode = UIViewContentModeCenter;
        
        [leftCell.vipImageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:kDefaultHeadImage];
        
        
        int template_id = [[dict objectForKey:@"template_id"]intValue];
        
        int selected_id = [[_selectedVipDict objectForKey:@"template_id"]intValue];
        
        if (template_id == selected_id) {
            
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
       ChoseVipRightCell *rightCell = [tableView dequeueReusableCellWithIdentifier:@"ChoseVipRightCell"];
       
       NSDictionary *serviceDict = [_selectedServiceArray objectAtIndex:indexPath.section];
       
       rightCell.nameLabel.text = [serviceDict objectForKey:@"service_name"];
       
       rightCell.countLabel.text = [NSString stringWithFormat:@"%d张",[[serviceDict objectForKey:@"service_count"]intValue]];
       
       
       int type = [[serviceDict objectForKey:@"service_type"]intValue];
       
       switch (type) {
           case 1:
           {
                 rightCell.discountLabel.text =  [NSString stringWithFormat:@"%.1f折",[[serviceDict objectForKey:@"discount"]floatValue] ];
           }
               break;
            case 2:
           {
               rightCell.discountLabel.text = [NSString stringWithFormat:@"抵扣￥%.2f",[[serviceDict objectForKey:@"discount"]floatValue]];
           }
               break;
            case 3:
           {
               NSMutableString *vipString = [[NSMutableString alloc]init];
               
               NSArray *gift = [serviceDict objectForKey:@"gift"];
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
    
    if (tableView == _leftTableView) {
        
        _selectedVipDict = [_vipCardsArray objectAtIndex:indexPath.section];
        
        _selectedServiceArray = [_selectedVipDict objectForKey:@"services"];
        
        if ([self.delegate respondsToSelector:@selector(didSelectedVipCard:)]) {
            
            [self.delegate didSelectedVipCard:_selectedVipDict];
            
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidSelectedVipCardNoti object:_selectedVipDict];
        
        [self setheaderView];
        
        
        [_leftTableView reloadData];
        
        [_vipServiceTableView reloadData];
        
    }
    else
    {
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)setheaderView
{
    _vipNameLabel.text = [_selectedVipDict objectForKey:@"template_name"];
    
    _vipDescLabel.text = [_selectedVipDict objectForKey:@"template_desc"];
    
    _vipPriceLabel.text = [NSString stringWithFormat:@"￥%@",[_selectedVipDict objectForKey:@"price"]];
    
    _expirDayLabel.text = [NSString stringWithFormat:@"%@天",[_selectedVipDict objectForKey:@"exp_day"]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
