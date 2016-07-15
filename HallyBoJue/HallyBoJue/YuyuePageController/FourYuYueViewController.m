//
//  FourYuYueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/14.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FourYuYueViewController.h"
#import "FourVIPCell.h"
#import "FourServiceCell.h"
#import "NetWorking.h"



@interface FourYuYueViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *vipArray;

@property (nonatomic,assign) CGFloat totalMoney;

@end

@implementation FourYuYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _serviceTable.delegate = self;
    _serviceTable.dataSource = self;

    
    
   
    
}


-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    if (_orderModel.usermodel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_orderModel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
        
    }
    
    _realnameLabel.text = _orderModel.usermodel.user_real_name;
    
    _plate_numLabel.text = _orderModel.car_plate_num;
    
    _mobileLabel.text = _orderModel.usermodel.mobile;
    
    _timeLabel.text = _orderModel.order_time;
    
    _statusLabel.text = _orderModel.status_str;
    
    _totalMoney = 0.0;
    
    for (int i =0; i < _orderModel.services.count; i++) {
        
        NSDictionary *oneService = [_orderModel.services objectAtIndex:i];
        
        CGFloat oneprice = [[oneService objectForKey:@"price"]floatValue];
        
        _totalMoney += oneprice;
        
    }
    
    
    _totalMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",_totalMoney];
    
    
     [self getvipcard];
    
    
    
}
-(void)getvipcard
{
    [[NetWorking shareNetWorking] RequestWithAction:kGetUserVipCard Params:@{@"user_id":@(_orderModel.user_id),@"car_id":@(_orderModel.car_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            DataModel *model = (DataModel*)data;
            
            _vipArray = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < model.items.count; i++) {
                
                NSDictionary *dict = [model.items objectAtIndex:i];
                int temservice_id = [[dict objectForKey:@"service_id"]intValue];
                
                for (int d = 0; d < _orderModel.services.count; d++) {
                    
                    NSDictionary *service = [_orderModel.services objectAtIndex:d];
                    
                    int service_id = [[service objectForKey:@"id"]intValue];
                    
                    if (service_id == temservice_id) {
                        
                        [_vipArray addObject:dict];
                        
                    }
                    
                }
            }
            
            
            [_serviceTable reloadData];
            
        }
        
    }];
}




#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    
    if (section == 0) {
        
        return _orderModel.services.count;
    }
    else
    {
        return _vipArray.count;
        
    }
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50.0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    label.backgroundColor = [UIColor whiteColor];
    
    if (section == 0) {
        
        label.text = @" 服务内容:";
    }
    else
    {
        label.text = @" 可使用会员卡信息:";
    }
    
    label.textColor = kDarkTextColor;
    
    label.textAlignment = NSTextAlignmentLeft;
    
    label.font = FONT_17;
    
    return label;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
        if (indexPath.section == 0) {
            
            FourServiceCell *serviceCell = [tableView dequeueReusableCellWithIdentifier:@"FourServiceCell"];
            
            if (indexPath.row < _orderModel.services.count) {
                
                NSDictionary *dict = [_orderModel.services objectAtIndex:indexPath.row];
                
                
                serviceCell.servicenameLabel.text = [dict objectForKey:@"name"];
                
                serviceCell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"price"]];
                
                
                
            }

            return serviceCell;
            
        }
        else
        {
            FourVIPCell *vipCell = [tableView dequeueReusableCellWithIdentifier:@"FourVIPCell"];
            
            if (indexPath.row < _vipArray.count) {
                
                NSDictionary *vipdict = [_vipArray objectAtIndex:indexPath.row];
                
                vipCell.vipNameLabel.text = [vipdict objectForKey:@"service_name"];
                
                int service_count = [[vipdict objectForKey:@"service_count"]intValue];
                
                vipCell.vipNumLabel.text = [NSString stringWithFormat:@"%d张",service_count];
                
                BOOL selected = [[vipdict objectForKey:@"selected"]boolValue];
                
                if (selected) {
                    
                    vipCell.selectedImageView.image = [UIImage imageNamed:@"jiesuan_xuanz"];
                    
                    
                }
                else
                {
                   vipCell.selectedImageView.image = [UIImage imageNamed:@"jiesuan_weixuanz"];
                }
                
                int service_type = [[vipdict objectForKey:@"service_type"]intValue];
                
                switch (service_type) {
                    case 1:
                    {
                        
                        float discount =[[vipdict objectForKey:@"discount"]floatValue]*10;
                  
                        vipCell.viptypeLabel.text = [NSString stringWithFormat:@"%.1f折",discount];
                        
                       
                        
                    }
                        break;
                    case 2:
                    {
                        vipCell.viptypeLabel.text = [NSString stringWithFormat:@"抵扣￥%.2f",[[vipdict objectForKey:@"discount"]floatValue]];
                        
                    }
                        break;
                    case 3:
                    {
                        NSDictionary *gift = [[vipdict objectForKey:@"gift"]firstObject];
                        NSString *giftname = [gift objectForKey:@"service_name"];
                        
                         vipCell.viptypeLabel.text = [NSString stringWithFormat:@"买1送:%@",giftname];
                         vipCell.viptypeLabel.adjustsFontSizeToFitWidth = YES;
                        
                        
                        
                        
                        
                    }
                        break;
                        
                        
                    default:
                        break;
                }
                
            }
            
            return vipCell;
            
        }
        
      
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 1) {
        
        
        NSDictionary *vipDict = [_vipArray objectAtIndex:indexPath.row];
        
        NSInteger service_count = [[vipDict objectForKey:@"service_count"]integerValue];
        
        if (service_count > 0) {
            
            BOOL selected = ![[vipDict objectForKey:@"selected"]boolValue];
            
            
            NSMutableArray *muArray = [[NSMutableArray alloc]init];
            [muArray addObjectsFromArray:_orderModel.services];
            
            for (int i = 0; i < muArray.count; i++) {
                
                NSDictionary *oneServiceDict = [muArray objectAtIndex:i];
                
                NSMutableDictionary  *mudict = [[NSMutableDictionary alloc]initWithDictionary:oneServiceDict];
                
                if (selected) {
                    
                    [mudict setObject:vipDict forKey:@"vipdict"];
                    
                }
                else
                {
                    [mudict setObject:@"" forKey:@"vipdict"];
                    
                }
                
            }
        
            
            [self caculeteMoney];
            
            [_serviceTable reloadData];
            
        }

        
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
}


-(void)caculeteMoney
{
    _totalMoney = 0.0;
    
    
  
    
    
    for (int i = 0 ; i < _orderModel.services.count; i++) {
        
        NSDictionary *oneService = [_orderModel.services objectAtIndex:i];
        
        int temservice_id = [[oneService objectForKey:@"id"]intValue];
        
        CGFloat onePrice = [[oneService objectForKey:@"price"]floatValue];
        
        BOOL contented = NO;
        
        for (int d = 0; d < _vipArray.count; d++) {
            
        
            NSDictionary *vipdict = [_vipArray objectAtIndex:d];
            
            int service_id = [[vipdict objectForKey:@"service_id"]intValue];
            
            BOOL selected = [[vipdict objectForKey:@"selected"]boolValue];
            
            
            
            
            if (service_id == temservice_id && selected ) {
                
                contented = YES;
            
                
                
            float discount = [[vipdict objectForKey:@"discount"]floatValue];
            
            int type = [[vipdict objectForKey:@"service_type"]intValue];
            
            switch (type) {
                case 1:  //折扣
                {
                    _totalMoney += onePrice *discount;
                }
                    break;
                case 2:  //抵扣金额
                {
                    _totalMoney -= discount;
                    
                }
                    break;
                case 3:  //买一送一
                {
                    _totalMoney +=onePrice;
                    
                }
                    break;
                    
                    
                default:
                {
                      _totalMoney +=onePrice;
                }
                    break;
              }
            
             
            
                
                
            
            }
            
        }
        
        
        if (!contented) {
            
            _totalMoney +=onePrice;
            
        }
    }
    
    [self setTotalMoneyLabel];
    
    

}

-(void)setTotalMoneyLabel
{
    _totalMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",_totalMoney];
    
}



- (IBAction)summitAction:(id)sender {
    
    
    
    
    
}
@end
