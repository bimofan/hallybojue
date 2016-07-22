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
#import "PayTypeView.h"
#import "UserInfo.h"






@interface FourYuYueViewController ()<UITableViewDelegate,UITableViewDataSource,PayTypeDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray *vipArray;

@property (nonatomic,assign) CGFloat totalMoney;

@property (nonatomic,strong) PayTypeView *payTypeView;

@property (nonatomic,assign) int payType;



@end

@implementation FourYuYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _statusLabel.clipsToBounds = YES;
    _statusLabel.layer.cornerRadius = kCornerRadous;
    
    _summitButton.clipsToBounds = YES;
    _summitButton.layer.cornerRadius = kCornerRadous;
    _summitButton.layer.borderColor = kBorderColor.CGColor;
    _summitButton.layer.borderWidth = 1;
    
    
    _headImageView.clipsToBounds= YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    
    
    _serviceTable.delegate = self;
    _serviceTable.dataSource = self;

    
    
    _payType = 1;
    
    
}

#pragma mark - PayTypeView
-(PayTypeView*)payTypeView
{
    if (!_payTypeView) {
        
        _payTypeView = [[[NSBundle mainBundle] loadNibNamed:@"PayTypeView" owner:self options:nil] firstObject];
        
        _payTypeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        _payTypeView.delegate = self;
        
    }
    
    return _payTypeView;
    
    
}

-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    if (_orderModel.usermodel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_orderModel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
        
    }
    
    _realnameLabel.text = _orderModel.usermodel.nickname;
    
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
            
            
            if (data) {
                
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
        
        int vip_id = [[vipDict objectForKey:@"id"]intValue];
        
        int vipservice_id = [[vipDict objectForKey:@"service_id"]intValue];
        
        NSInteger service_count = [[vipDict objectForKey:@"service_count"]integerValue];
        
        BOOL selected = [[vipDict objectForKey:@"selected"]boolValue];
        
        if (service_count > 0) {
            
        
        if (!selected) {
            
        //先把其他相同的变成未选中
        for (int i = 0 ; i < _vipArray.count; i++) {
            
            NSDictionary *temdict = [_vipArray objectAtIndex:i];
            
            int temService_id = [[temdict objectForKey:@"service_id"]intValue];
            
            int tem_id = [[temdict objectForKey:@"id"]intValue];
            
            
            if (vipservice_id == temService_id && vip_id != tem_id) {
                
                NSMutableDictionary *mutemdict = [[NSMutableDictionary alloc]initWithDictionary:temdict];
                
                [mutemdict setObject:@(0) forKey:@"selected"];
                
                
                [_vipArray replaceObjectAtIndex:i withObject:mutemdict];
                
                
            }
            
        }
            
        }
            
        
        
            //替换 选中的 _vipArray
        NSMutableDictionary *mutemdict = [[NSMutableDictionary alloc]initWithDictionary:vipDict];
            
        [mutemdict setObject:@(!selected) forKey:@"selected"];
            
            
        [_vipArray replaceObjectAtIndex:indexPath.row withObject:mutemdict];
    
            
            
            
            NSMutableArray *muArray = [[NSMutableArray alloc]init];
            [muArray addObjectsFromArray:_orderModel.services];
            
            for (int i = 0; i < muArray.count; i++) {
                
                NSDictionary *oneServiceDict = [muArray objectAtIndex:i];
                
                NSMutableDictionary  *mudict = [[NSMutableDictionary alloc]initWithDictionary:oneServiceDict];
                
                int oneService_id = [[oneServiceDict objectForKey:@"id"]intValue];
                
                
                id insideDict = [oneServiceDict objectForKey:@"vipdict"];
                
                int inside_id = 0;
                
                if ([insideDict isKindOfClass:[NSDictionary class]]) {
                    
                    inside_id = [[insideDict objectForKey:@"id"]intValue];
                    
                }
                
                for (int d = 0; d < _vipArray.count; d++) {
                    
                    NSDictionary *temvipDict = [_vipArray objectAtIndex:d];
                    
                    int temvipService_id =[[temvipDict objectForKey:@"service_id"]intValue];
                    
                    BOOL selected = [[temvipDict objectForKey:@"selected"]boolValue];
                    
                   

                    int outside_id = [[temvipDict objectForKey:@"id"]intValue];
                    
                    
                    if (temvipService_id == oneService_id ) {
                        
                        if (selected) {
                            
                            [mudict setObject:temvipDict forKey:@"vipdict"];
                            
                            [muArray replaceObjectAtIndex:i withObject:mudict];
                            
                            inside_id = [[temvipDict objectForKey:@"id"]intValue];
                            
                            
                        }
                        else
                        {
                            
                            if (inside_id == outside_id) {
                                
                                 [mudict setObject:@"" forKey:@"vipdict"];
                                
                                
                                 [muArray replaceObjectAtIndex:i withObject:mudict];
                            }
                           
                            
                        }
                        
                        
                       
                        
                     }
                    
                    
                }
                
            }
        
            
            _orderModel.services = muArray;
            
            
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
    
        
        CGFloat onePrice = [[oneService objectForKey:@"price"]floatValue];
        
        BOOL contented = NO;
        
        id vipdict = [oneService objectForKey:@"vipdict"];
        
        if ([vipdict isKindOfClass:[NSDictionary class]]) {
            
            contented = YES;
            
            int type = [[vipdict objectForKey:@"service_type"]intValue];
            
            CGFloat discount = [[vipdict objectForKey:@"discount"]floatValue];
            
         
            
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
    
    
    
    self.payTypeView.totalMoney = _totalMoney;
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.payTypeView];
    
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

}

-(NSDictionary*)getparams
{
    int order_id = _orderModel.id;
    int user_id = _orderModel.user_id;
    
    
    int keeper_id = [UserInfo getkeeperid];
    
    NSMutableArray *services = [[NSMutableArray alloc]init];
    
    
    CGFloat old_Amount = 0;
    
    for (int i = 0; i < _orderModel.services.count; i++) {
        
        NSDictionary *oneService = [_orderModel.services objectAtIndex:i];
        
        
        NSMutableDictionary *muservice = [[NSMutableDictionary alloc]init];
        
        int serviceId = [[oneService objectForKey:@"id"]intValue];
        
        CGFloat price = [[oneService objectForKey:@"price"]floatValue];
        
        old_Amount += price;
        
        
        [muservice setObject:@(serviceId) forKey:@"service_id"];
        
        id vipdict = [oneService objectForKey:@"vipdict"];
        
        if ([vipdict isKindOfClass:[NSDictionary class]]) {
            
            int vip_id = [[vipdict objectForKey:@"id"]intValue];
            
            int card_id = [[vipdict objectForKey:@"card_id"]intValue];
            
            [muservice setObject:@(card_id) forKey:@"card_id"];
            
            [muservice setObject:@(vip_id) forKey:@"vip_service_id"];
            
            [muservice setObject:@(1) forKey:@"used_vip"];
            
            
            
        }
        else
        {
            [muservice setObject:@(0) forKey:@"used_vip"];
        }
        
        [services addObject:muservice];
        
        
    }
    
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:services options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *services_string = [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
    
    
    NSString *keeper_note = _payTypeView.noteTextView.text;
    
    if (!keeper_note) {
        keeper_note = @"";
        
    }
    
    return @{@"order_id":@(order_id),@"user_id":@(user_id),@"keeper_id":@(keeper_id),@"services":services_string,@"total_price":@(_totalMoney),@"old_amount":@(old_Amount),@"pay_type":@(_payType),@"keeper_note":keeper_note};
    
    
    
    
    
    
}


#pragma mark - PayTypeDelegate
-(void)didSelectedPayType:(int)payType
{
    _payType = payType;
    
    
}

-(void)doneSelectedPayType
{
    NSDictionary *params = [self getparams];
    
    [[NetWorking shareNetWorking] RequestWithAction:kSummitOrder Params:params itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            _orderModel.status = 6;
            _orderModel.status_str = @"待支付";
            
            if ([self.delegate respondsToSelector:@selector(didSummitOrder:)]) {
                
                [self.delegate didSummitOrder:_orderModel];
                
                
            }
            
            
        }
    }];
}
@end
