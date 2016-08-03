//
//  FiveYuYueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/16.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FiveYuYueViewController.h"
#import "FiveYuYueCell.h"
#import "PayTypeView.h"
#import "TwoViewController.h"


@interface FiveYuYueViewController ()<UITableViewDelegate,UITableViewDataSource,PayTypeDelegate>

@property (nonatomic,strong) PayTypeView *payTypeView;
@property (nonatomic,assign) NSInteger payType;

@property (nonatomic,strong) TwoViewController *twoViewController;



@end

@implementation FiveYuYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _statusLabel.clipsToBounds = YES;
    _statusLabel.layer.cornerRadius = kCornerRadous;
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _serviceTableView.delegate = self;
    _serviceTableView.dataSource = self;
    
    _changepaytypeButton.clipsToBounds = YES;
    _changepaytypeButton.layer.cornerRadius = kCornerRadous;
    _changepaytypeButton.layer.borderColor = kBorderColor.CGColor;
    _changepaytypeButton.layer.borderWidth = 1;
    
    _sendWorkerButton.clipsToBounds  = YES;
    _sendWorkerButton.layer.cornerRadius = kCornerRadous;
    _sendWorkerButton.layer.borderColor = kBorderColor.CGColor;
    _sendWorkerButton.layer.borderWidth = 1;
    
    
    
    
    
}

-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    if (_orderModel.usermodel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_orderModel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
        
    }
    else
    {
        _headImageView.image = kDefaultHeadImage;
        
    }
    
    _realNameLabel.text = _orderModel.usermodel.nickname;
    
    _plate_numLabel.text = _orderModel.car_plate_num;
    
    _mobileLabel.text = _orderModel.usermodel.mobile;
    
    _timeLabel.text = _orderModel.order_time;
    
    _statusLabel.text = [NSString stringWithFormat:@"支付状态:%@", _orderModel.status_str];
    
    _payType = _orderModel.pay_type;
    
    NSString *paytype_str = @"";
    switch (_orderModel.pay_type) {
        case 1:
        {
            paytype_str = @"支付方式:在线支付";
        }
        break;
        case 2:
        {
            paytype_str = @"支付方式:线下支付";
        }
        break;
        case 3:
        {
            paytype_str = @"支付方式:异常支付";
        }
        break;
        
        default:
        break;
    }
    
    _paytypeLabel.text = paytype_str;
    
    
    _order_amount_Label.text = [NSString stringWithFormat:@"￥%.2f",_orderModel.order_amount];
    
     _order_old_amount_Label.text = [NSString stringWithFormat:@"￥%.2f",_orderModel.order_old_amount];
    
    if (_orderModel.status == 6) {
        
        _changepaytypeButton.hidden = NO;
        
    }
    else
    {
        _changepaytypeButton.hidden = YES;
        
    }
    
     _vipcard_Label.text = [NSString stringWithFormat:@" %@ %@",orderModel.usermodel.vipcard_name,orderModel.usermodel.vip_address];
    
    _orderSNLabel.text = [NSString stringWithFormat:@"订单号:%@",_orderModel.so_number];
    _orderSNLabel.adjustsFontSizeToFitWidth =YES;
    
    
    if (_orderModel.sendworker) {
        
        _sendWorkerButton.hidden = YES;
        
    }
    else
    {
        _sendWorkerButton.hidden = NO;
        
    }
    [_serviceTableView reloadData];
    
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _orderModel.services.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FiveYuYueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiveYuYueCell"];
    
    if (_orderModel.services.count > indexPath.section) {
        
        NSDictionary *service = [_orderModel .services objectAtIndex:indexPath.section];
        
        cell.serviceNameLabel.text = [service objectForKey:@"name"];
        
    }
    
    
    return cell;
    
    
}



#pragma mark - twoViewController
-(TwoViewController*)twoViewController
{
    if (!_twoViewController) {
        
        _twoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TwoViewController"];
        _twoViewController.view.frame = self.view.frame;
    }
    
    return _twoViewController;
    
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


#pragma mark - PayTypeDelegate
-(void)didSelectedPayType:(int)payType
{
    _payType = payType;
    
    
}

-(void)doneSelectedPayType:(NSDictionary*)dict
{
    
    if (_payType == 0) {
        
        _payType = 1;
    }
    if (_payType > 3) {
        
        _payType = 1;
        
    }
     
    NSString *note = [dict objectForKey:@"note"];
    
    int order_id = _orderModel.id;
    
    NSDictionary *params = @{@"order_id":@(order_id),@"pay_type":@(_payType),@"note":note};
    
    [[NetWorking shareNetWorking] RequestWithAction:kChangePayType Params:params itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"支付方式修改成功"];
            
            _orderModel.pay_type = _payType;
            
            [self setOrderModel:_orderModel];
            
            
        }
    }];
}


- (IBAction)changepaytypeAction:(id)sender {
    
    
    self.payTypeView.pay_type = _payType;
    
    self.payTypeView.totalMoney = _orderModel.order_amount;
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.payTypeView];
    
}
- (IBAction)sendWorkerAction:(id)sender {
    
    self.twoViewController.orderModel = _orderModel;
    
    [self.view.superview addSubview:self.twoViewController.view];
    
    [self.view removeFromSuperview];
    
    

    
    
}
@end
