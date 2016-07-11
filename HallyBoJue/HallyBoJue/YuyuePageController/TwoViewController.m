//
//  TwoViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/10.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "TwoViewController.h"
#import "WorkerCell.h"
#import "ChoseWorkPlaceView.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource,ChoseWorkPlaceDelegate>


@property (nonatomic,strong) ChoseWorkPlaceView *choseWorkPlaceView;


@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _workerTableView.delegate = self;
    _workerTableView.dataSource = self;
    
}


-(ChoseWorkPlaceView*)choseWorkPlaceView
{
    if (!_choseWorkPlaceView) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ChoseWorkPlaceView" owner:self options:nil];
        
        _choseWorkPlaceView = [views firstObject];
        
        _choseWorkPlaceView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        [_choseWorkPlaceView show];
        
        
        _choseWorkPlaceView.delegate = self;
        
        
    }
    
    return _choseWorkPlaceView;
    
    
    
}
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[orderModel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _statusLabel.text = orderModel.status_str;
    
    
    _realNameLabel.text = orderModel.usermodel.user_real_name;
    
    _plateNumLabel.text = orderModel.car_plate_num;
    
    _mobileLabel.text = orderModel.usermodel.mobile;
    
    _timeLabel.text = orderModel.order_time;
    
    
    [_workerTableView reloadData];
    
    
   
    
}



#pragma mark - UITableViewDataSource
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    
    
    return  50;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
    NSDictionary *service = [_orderModel.services objectAtIndex:section];
    
    NSString *serviceName = [service objectForKey:@"service_name"];
    
    UILabel *serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    
    serviceLabel.text = serviceName;
    
    serviceLabel.textColor = kDarkTextColor;
    
    serviceLabel.backgroundColor = [UIColor whiteColor];
    
    
    return  serviceLabel;
    
    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkerCell"];
    

    
    
    
    return cell;
    
}


#pragma mark - ChoseWorkPlaceDelegate
-(void)didChoseWorkPlace:(NSDictionary *)workplace
{
    
}


- (IBAction)choseWorkPlaceAction:(id)sender {
    
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
    
    
    
    
    
    
}
@end
