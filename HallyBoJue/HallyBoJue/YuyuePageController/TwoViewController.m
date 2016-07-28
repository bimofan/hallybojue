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

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource,ChoseWorkPlaceDelegate,UITextFieldDelegate>


@property (nonatomic,strong) ChoseWorkPlaceView *choseWorkPlaceView;

@property (nonatomic,strong) NSArray *selectedWorkers;

@property (nonatomic,strong) NSDictionary *selectedworkplace;

@property (nonatomic,assign) NSInteger selectedSection;

@property (nonatomic,strong) NSMutableArray *servicesArray;




@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _workerTableView.delegate = self;
    _workerTableView.dataSource = self;
    
    _statusLabel.clipsToBounds  = YES;
    _statusLabel.layer.cornerRadius = kCornerRadous;
    
    _startService.clipsToBounds =  YES;
    _startService.layer.cornerRadius = kCornerRadous;
    _startService.layer.borderColor = kBorderColor.CGColor;
    _startService.layer.borderWidth = 1;
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    _timeTextField.delegate = self;
    
    
    
    
}


-(ChoseWorkPlaceView*)choseWorkPlaceView
{
    if (!_choseWorkPlaceView) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ChoseWorkPlaceView" owner:self options:nil];
        
        _choseWorkPlaceView = [views firstObject];
        
        _choseWorkPlaceView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        
        _choseWorkPlaceView.type = 1;
        
        [_choseWorkPlaceView show];
        
        
        _choseWorkPlaceView.delegate = self;
        
        
    }
    
    return _choseWorkPlaceView;
    
    
    
}
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[orderModel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _statusLabel.text = orderModel.status_str;
    
    
    _realNameLabel.text = orderModel.usermodel.nickname;
    
    _plateNumLabel.text = orderModel.car_plate_num;
    
    _mobileLabel.text = orderModel.usermodel.mobile;
    
    _timeLabel.text = orderModel.order_time;
    
        _vipcard_Label.text = [NSString stringWithFormat:@" %@ %@",orderModel.usermodel.vipcard_name,orderModel.usermodel.vip_address];
    _servicesArray = [[NSMutableArray alloc]init];
    
    [_servicesArray addObjectsFromArray:_orderModel.services];
    
    
    [_workerTableView reloadData];
    
    
   
    
}



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return  _servicesArray.count;
    

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
  
    
    
    NSDictionary *service = [_servicesArray objectAtIndex:section];
    
    NSString *serviceName = [service objectForKey:@"name"];
    
    UILabel *serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    
    serviceLabel.text = serviceName;
    
    serviceLabel.textColor = kDarkTextColor;
    
    serviceLabel.backgroundColor = [UIColor whiteColor];
    
    serviceLabel.textAlignment = NSTextAlignmentCenter;
    
    
    serviceLabel.clipsToBounds = YES;
    serviceLabel.layer.cornerRadius = kCornerRadous;
    
    
    
    return  serviceLabel;
    
    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkerCell"];
    
    
    if (indexPath.row == 0) {
        
        
        NSDictionary *dict = [_servicesArray objectAtIndex:indexPath.section];
        
        NSDictionary *workplace = [dict objectForKey:@"workplace"];
        
        
        if (workplace) {
            
             cell.workerLabel.text = [workplace objectForKey:@"name"];
        }
        else
        {
            cell.workerLabel.text = @"";
            
        }
       
        
        
        cell.placeholderLabel.text = @"选择车位";
             
      
        
        
        
    }
    else if (indexPath.row == 1)
    {
        
      
            
    
            NSDictionary *dict = [_servicesArray objectAtIndex:indexPath.section];
            
            NSArray *workers = [dict objectForKey:@"workers"];
            
            NSMutableString *workerStr = [[NSMutableString alloc]init];
            
            for ( int i = 0; i < workers.count; i++) {
                
                NSDictionary *workerDict = [workers objectAtIndex:i];
                
                if (workerStr.length == 0) {
                    if ([workerDict objectForKey:@"worker_real_name"]) {
                        
                        [workerStr appendString:[NSString stringWithFormat:@"%@",[workerDict objectForKey:@"worker_real_name"]]];
                    }
                    
                }
                else
                {
                    
                    if ([workerDict objectForKey:@"worker_real_name"]) {
                        
                        [workerStr appendString:[NSString stringWithFormat:@"  %@",[workerDict objectForKey:@"worker_real_name"]]];
                    }
                    
                    
                
                }
              
              
            
                
                
            }
            
            cell.workerLabel.text = workerStr;
            
            cell.placeholderLabel.text = @"选择技师";
            
            
     
        
  
         
        
    }
  
    
   
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    _selectedSection = indexPath.section;
    
    NSDictionary *oneservice = [_servicesArray objectAtIndex:indexPath.section];
    
    
    if (indexPath.row == 0) {
        
        if (self.choseWorkPlaceView.type == 2) {
            
            self.choseWorkPlaceView.workDataSource = nil;
            
        }
        
        NSDictionary *workplace = [oneservice objectForKey:@"workplace"];
        
        if (workplace) {
            
            self.choseWorkPlaceView.selectedArray = @[workplace];
        }
        else
        {
            self.choseWorkPlaceView.selectedArray = @[];

        }
        
        
        
        self.choseWorkPlaceView.type = 1;
        
        self.choseWorkPlaceView.store_id = _orderModel.store_id;
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
        
        
    }
    else
    {
        
   
    
    if (self.choseWorkPlaceView.type == 1 ||  _selectedSection != indexPath.section) {
        
        self.choseWorkPlaceView.workDataSource = nil;
        
    }
    
    

    
    if ([oneservice objectForKey:@"workers"]) {
        
        self.choseWorkPlaceView.selectedArray = [oneservice objectForKey:@"workers"];
        
    }
    else
    {
        self.choseWorkPlaceView.selectedArray = nil;
        
    }
    self.choseWorkPlaceView.store_id = _orderModel.store_id;
    
    self.choseWorkPlaceView.type = 2;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
        
        
     }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - ChoseWorkPlaceDelegate
-(void)didChoseItems:(NSArray *)items
{
    if (items.count > 0) {
        
        
        if (self.choseWorkPlaceView.type ==1) {
            
            
            NSDictionary * selectedworkplace = [items firstObject];
            
            
            NSDictionary *dict = [_servicesArray objectAtIndex:_selectedSection];
            
            NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
            
            [mudict setObject:selectedworkplace forKey:@"workplace"];
            NSString *workplacename = [selectedworkplace objectForKey:@"name"];
            [mudict setObject:workplacename forKey:@"workplace_name"];
            
            
            [_servicesArray replaceObjectAtIndex:_selectedSection withObject:mudict];
            
            
            [_workerTableView reloadData];
            
            
            
        }
        else
        {
            
            
            NSDictionary *dict = [_servicesArray objectAtIndex:_selectedSection];
            
            NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
            
            [mudict setObject:items forKey:@"workers"];
            
            
            [_servicesArray replaceObjectAtIndex:_selectedSection withObject:mudict];
            
            
            [_workerTableView reloadData];
            
        }
     
        
    }
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 450);
        
    }];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 450);
        
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return  YES;
    
}




- (IBAction)startServiceAction:(id)sender {
    
    
    if (_timeTextField.text.length == 0  || [_timeTextField.text integerValue] == 0) {
        
        
        [CommonMethods showDefaultErrorString:@"请填写预估服务时间"];
        
        return ;
        
        
    }
    
    
    
    for (int i = 0; i < _servicesArray.count; i++) {
        
        NSDictionary *servicedict = [_servicesArray objectAtIndex:i];
        
        NSDictionary *workplace = [servicedict objectForKey:@"workplace"];
        
        NSArray *workers = [servicedict objectForKey:@"workers"];
        
        
        if (!workplace) {
            
            [CommonMethods showDefaultErrorString:@"请选择服务车位"];
            
            return;
        }
        
        if (workers.count == 0) {
            
            [CommonMethods showDefaultErrorString:@"请选择技师"];
            
            return;
            
        }
    }
    
    
    
   
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_servicesArray options:NSJSONWritingPrettyPrinted error:nil];
    
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"jsonString:%@",jsonString);
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kOrderStartService Params:@{@"order_id":@(_orderModel.id),@"services":jsonString,@"expecte_time":_timeTextField.text} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            _orderModel.status = 4;
            _orderModel.status_str = @"服务中";
            _orderModel.services = _servicesArray;
            
            if ([self.delegate respondsToSelector:@selector(didStartService:)]) {
                
                [self.delegate didStartService:_orderModel];
                
            }
        }
    }];
    
}



@end
