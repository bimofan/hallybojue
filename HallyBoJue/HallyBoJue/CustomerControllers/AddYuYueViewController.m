//
//  AddYuYueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/16.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "AddYuYueViewController.h"
#import "AddYuYueCell.h"
#import "AddServiceViewController.h"
#import "ChoseWorkPlaceView.h"
#import "SelectTimeView.h"
#import "UserInfo.h"



@interface AddYuYueViewController ()<UITableViewDelegate,UITableViewDataSource,AddNewServiceDelegate,ChoseWorkPlaceDelegate,SelectTimeViewDelegate>


@property (nonatomic,strong) UIButton *addServiceButton;
@property (nonatomic,strong) UIButton *addTimeButton;
@property (nonatomic,strong) UIButton *addCarButton;
@property (nonatomic,assign) CGFloat buttonHeight;

@property (nonatomic,strong) NSMutableArray *serviceArray;
@property (nonatomic,strong) NSMutableArray *carsArray;
@property (nonatomic,strong) NSDictionary *selectedCarDict;

@property (nonatomic,strong) NSDate *oder_time;


@property (nonatomic,strong) ChoseWorkPlaceView *choseWorkPlaceView;


@property (nonatomic,strong) AddServiceViewController *addServiceViewController;

@property (nonatomic,strong) SelectTimeView *selectTimeView;



@end

@implementation AddYuYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _buttonHeight = 40.0;
    
    _summitButton.clipsToBounds = YES;
    _summitButton.layer.cornerRadius = kCornerRadous;
    
    _levelNameLabel.clipsToBounds = YES;
    _levelNameLabel.layer.cornerRadius = kCornerRadous;
    
    
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = CGRectGetHeight(_headImageView.frame)/2;
    
    _serviceTableView.delegate = self;
    _serviceTableView.dataSource = self;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddServiceNoti:) name:kAddServieNotice object:nil];
    
    
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAddServieNotice object:nil];
    
}



#pragma mark - SelectTimeView
-(SelectTimeView*)selectTimeView
{
    if (!_selectTimeView) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SelectTimeView" owner:self options:nil];
        
        _selectTimeView = [views firstObject];
        
        _selectTimeView.delegate = self;
        
        _selectTimeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        
       
    }
    
    return _selectTimeView;
    
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

-(AddServiceViewController*)addServiceViewController
{
    
    if (!_addServiceViewController) {
        
        _addServiceViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddServiceViewController"];
        
        _addServiceViewController.delegate = self;
        
    }
    
    return _addServiceViewController;
    
}

-(void)setCUserModel:(CUserModel *)cUserModel
{
    _cUserModel = cUserModel;
    
    if (_cUserModel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_cUserModel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
    }
    
    _realNameLabel.text = _cUserModel.nickname;
    
    _levelNameLabel.text = _cUserModel.level_name;
    _vipAddressLabel.text = _cUserModel.vip_address;
    

    
    [_serviceArray removeAllObjects];
    [_carsArray removeAllObjects];
    [_serviceTableView reloadData];
    
    _selectedCarDict = nil;
    _oder_time = nil;
    
    
    [self getusercars];
    
    
    
    
}

#pragma mark - 获取用户汽车
-(void)getusercars
{
    [[NetWorking shareNetWorking] RequestWithAction:kGetUserCars Params:@{@"user_id":_cUserModel.user_id} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            DataModel *model = (DataModel*)data;
            
            _carsArray = [[NSMutableArray alloc]init];
            
            [_carsArray addObjectsFromArray:model.items];
            
            
            
        }
    }];
}

-(UIButton*)addTimeButton
{
    if (!_addTimeButton) {
        
        _addTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _serviceTableView.frame.size.width, _buttonHeight)];
        
        _addTimeButton.backgroundColor = [UIColor whiteColor];
        
        [_addTimeButton setTitle:@"预约时间" forState:UIControlStateNormal];
        
        [_addTimeButton setTitleColor:kDarkTextColor forState:UIControlStateNormal];
        
        
    }
    
    return _addTimeButton;
    
}

-(UIButton*)addCarButton
{
    if (!_addCarButton) {
        
        _addCarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _serviceTableView.frame.size.width, _buttonHeight)];
        
        _addCarButton.backgroundColor = [UIColor whiteColor];
        
        [_addCarButton setTitle:@"选择车辆" forState:UIControlStateNormal];
        
        [_addCarButton setTitleColor:kDarkTextColor forState:UIControlStateNormal];
        
    }
    
    return _addCarButton;
}

-(UIButton*)addServiceButton
{
    if (!_addServiceButton) {
        
        _addServiceButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _addServiceButton.frame.size.width, _buttonHeight)];
        
        _addServiceButton.backgroundColor = [UIColor whiteColor];
        
        [_addServiceButton setTitleColor:kDarkTextColor forState:UIControlStateNormal];
        
        [_addServiceButton setTitle:@"选择服务" forState:UIControlStateNormal];
        
    }
    
    return _addServiceButton;
    
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _buttonHeight;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSString *text = @"";
    
    switch (section) {
        case 0:
        {
            text = @"  选择服务";
        
            
            
        }
            break;
        case 1:
        {
            
             text = @"  选择车辆";
          
        }
            break;
        case 2:
        {
            text = @"  预约时间";
        }
            break;
            
            
        default:
        {
         
            
        }
            break;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, _buttonHeight)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _buttonHeight -1, view.frame.size.width, 1)];
    
    lineView.backgroundColor = kBackgroundColor;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, _buttonHeight -1)];
    
    titleLabel.text = text;
    
    titleLabel.textColor = kDarkTextColor;
    
    titleLabel.font = FONT_17;
    
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [view addSubview:titleLabel];
    
//    [view addSubview:lineView];
    
    
    return view;
    
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    
    switch (section) {
        case 0:
        {
            
            if (_serviceArray.count == 0) {
                
                return 1;
            }
            return _serviceArray.count;
            
        }
            break;
        case 1:
        {
            
            
            return 1;
            
            
        }
            break;
        case 2:
        {
            
            return 1;
            
        }
            break;
            
            
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    AddYuYueCell *yueyueCell = [tableView dequeueReusableCellWithIdentifier:@"AddYuYueCell"];
    
    switch (indexPath.section) {
        case 0:
        {
           yueyueCell.typeLabel.text = @"选择服务";
            
            
            if (_serviceArray.count > 0) {
                
                NSDictionary *dict = [_serviceArray objectAtIndex:indexPath.row];
                
                yueyueCell.contentLabel.text = [dict objectForKey:@"name"];
                
                yueyueCell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"price"]];
                
            }
            else
            {
                yueyueCell.contentLabel.text = @"";
                
                
                yueyueCell.priceLabel.text = @"";
                
            }
        }
            break;
        case 1:
        {
            yueyueCell.typeLabel.text = @"选择车辆";
            
          
    
            if (_selectedCarDict) {
                
            yueyueCell.contentLabel.text = [NSString stringWithFormat:@"%@",[_selectedCarDict objectForKey:@"brand_name"]];
                
                
            yueyueCell.priceLabel.text = [_selectedCarDict objectForKey:@"plate_number"];
                
            }
            else
            {
                yueyueCell.contentLabel.text = @"";
                
                
                yueyueCell.priceLabel.text = @"";
            }
         
        }
            break;
        case 2:
        {
            yueyueCell.typeLabel.text = @"选择时间";
            
            
            if (_oder_time) {
                
                yueyueCell.contentLabel.text = [CommonMethods getYYYYMMddhhmmDateStr:_oder_time];
                
            }
            else
            {
                yueyueCell.contentLabel.text = @"";
                
                
            }
             yueyueCell.priceLabel.text = @"";
            
            
        }
            break;
            
            
        default:
            break;
    }
    
    return yueyueCell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
           
            
            if (_serviceArray.count > 0) {
                
            
            [[NSUserDefaults standardUserDefaults] setObject:_serviceArray forKey:kAddNewServiceSelectedList];
                
                
            }
            else
            {
                _serviceArray = [[NSMutableArray alloc]init];
                
                [[NSUserDefaults standardUserDefaults] setObject:_serviceArray forKey:kAddNewServiceSelectedList];
                
                
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:@(2) forKey:kAddNewServiceType];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AddServiceNav"];
            
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            
            
        }
            break;
        case 1:
        {

            
            
            self.choseWorkPlaceView.type = 4;
            
            self.choseWorkPlaceView.selectedDict = _selectedCarDict;
            
            self.choseWorkPlaceView.workDataSource = _carsArray;
            self.choseWorkPlaceView.titleLabel.text = @"车辆选择";
         
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
            
            
            
        }
            break;
        case 2:
        {
          
            if (_oder_time) {
                
                self.selectTimeView.selectedDate = _oder_time;
            }
            
          
            [[UIApplication sharedApplication].keyWindow addSubview:self.selectTimeView];
        }
            
        default:
            break;
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}


#pragma mark - AddNewServiceDelegate
-(void)didSelectedNewService:(NSArray *)array
{
   
    
}

-(void)didAddServiceNoti:(NSNotification*)note
{
     NSLog(@"add service array:%@",note.object);
    
    _serviceArray = [[NSMutableArray alloc]init];
    
    
    if ([note.object isKindOfClass:[NSArray class]]) {
        
          [_serviceArray addObjectsFromArray:note.object];
    }
    
    [_serviceTableView reloadData];
    
  
    
    
}

#pragma mark - ChoseWorkPlaceDelegate 
-(void)didChoseItems:(NSArray *)items
{
 
    
    _selectedCarDict = [items firstObject];
    
    [_serviceTableView reloadData];
    
}


#pragma makr - SelectTimeViewDelegate
-(void)didSelectedDate:(NSDate *)selectedDate
{
    _oder_time = selectedDate;
    
    [_serviceTableView reloadData];
    
}

- (IBAction)setRemindAction:(id)sender {
}

- (IBAction)summitAction:(id)sender {
    
    
    if (_serviceArray.count == 0) {
        
        [CommonMethods showDefaultErrorString:@"请选择服务"];
        
        return;
    }
    
    if (!_selectedCarDict) {
        
        [CommonMethods showDefaultErrorString:@"请选择车辆"];
        
        return;
    }
    
    if (!_oder_time) {
        
        [CommonMethods showDefaultErrorString:@"请选择预约时间"];
        
        return;
    }
    
    
    
    NSString *user_id = _cUserModel.user_id;
    
    int store_id = [UserInfo getstoreid];
    
    int keeper_id = [UserInfo getkeeperid];
    
    NSString *order_time = [CommonMethods getYYYYMMddhhmmDateStr:_oder_time];
    
    int car_id = [[_selectedCarDict objectForKey:@"id"]intValue];
    
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:_serviceArray options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonString = [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding ];
    
    
    NSDictionary *params = @{@"user_id":user_id,@"store_id":@(store_id),@"keeper_id":@(keeper_id),@"order_time":order_time,@"car_id":@(car_id),@"services":jsonString};
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kAddUserAppoint Params:params itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"预约提交成功"];
            
            
        }
    }];
    
    
    
}


@end
