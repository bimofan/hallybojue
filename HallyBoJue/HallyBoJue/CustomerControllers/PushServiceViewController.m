//
//  PushServiceViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/21.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "PushServiceViewController.h"
#import "PushServiceCell.h"
#import "AddServiceViewController.h"
#import "ChoseWorkPlaceView.h"


@interface PushServiceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ChoseWorkPlaceDelegate>

@property (nonatomic,strong) NSDictionary *selectedService;

@property (nonatomic,strong) ChoseWorkPlaceView *choseWorkPlaceView;

@property (nonatomic,strong) NSDictionary *selectedCarDict;

@property (nonatomic,strong) NSMutableArray *carsArray;

@end

@implementation PushServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _summitButton.clipsToBounds = YES;
    _summitButton.layer.cornerRadius = kCornerRadous;
    _summitButton.layer.borderColor = kBorderColor.CGColor;
    _summitButton.layer.borderWidth = 1;
    
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    _vipCardLabel.clipsToBounds= YES;
    _vipCardLabel.layer.cornerRadius = kCornerRadous;
    
    
    
    _serviceTableView.delegate = self;
    _serviceTableView.dataSource = self;
    
    _noteLabel.delegate =self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didselectedServiceNoti:) name:kPushServiceSelectedNoti object:nil];
    
    
    
    
}

-(void)didselectedServiceNoti:(NSNotification*)noti
{
    _selectedService = noti.object;
    
    [_serviceTableView reloadData];
    
    
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

-(void)setCUserModel:(CUserModel *)cUserModel
{
    _cUserModel = cUserModel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[cUserModel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _realNameLabel.text = _cUserModel.nickname;
    
    _vipCardLabel.text = _cUserModel.level_name;
    
    _vipcardAddresslabel.text = _cUserModel.vip_address;
    
    
  
    _selectedService = nil;
    _selectedCarDict = nil;
    _noteLabel.text = nil;
    
    
    [_serviceTableView reloadData];
    
    [self getusercars];
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        
        return 0;
        
    }
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    blankView.backgroundColor = kBackgroundColor;
    
    return blankView;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PushServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PushServiceCell"];
    
    if (indexPath.section == 0) {
        
        cell.placeHolderLabel.text = @"选择服务";
        if (_selectedService) {
            
            cell.titleLabel.text = [_selectedService objectForKey:@"name"];
            
            cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[_selectedService objectForKey:@"price"]];
            
        }
        else
        {
            cell.titleLabel.text = nil;
            cell.priceLabel.text = nil;
            
        }
    }
    else
    {
        cell.placeHolderLabel.text = @"选择车辆";
        
        if (_selectedCarDict) {
            
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",[_selectedCarDict objectForKey:@"brand_name"]];
            
            
            cell.priceLabel.text = [_selectedCarDict objectForKey:@"plate_number"];
        }
        else
        {
            cell.titleLabel.text = nil;
            cell.priceLabel.text = nil;
        }
       
        
    }

    
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@(3) forKey:kAddNewServiceType];
        
        if (_selectedService) {
            
            [[NSUserDefaults standardUserDefaults] setObject:_selectedService forKey:kPushServiceSelectedService];
            
            
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AddServiceNav"];
        
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        
        
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else
    {
        self.choseWorkPlaceView.type = 4;
        
        self.choseWorkPlaceView.selectedDict = _selectedCarDict;
        
        self.choseWorkPlaceView.workDataSource = _carsArray;
        
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
    }
  
    
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

#pragma mark - ChoseWorkPlaceDelegate
-(void)didChoseItems:(NSArray *)items
{
    _selectedCarDict = [items firstObject];
    
    [_serviceTableView reloadData];
    
    
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
        
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
        
    }];
}




- (IBAction)summitAction:(id)sender {
    
    
    if (_selectedCarDict == nil) {
        
        [CommonMethods showDefaultErrorString:@"请选择车辆"];
        return;
    }
 
    
    if (_noteLabel.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写备注"];
        
        return;
        
    }
    
    int keeper_id = [UserInfo getkeeperid];
    NSString *user_id = _cUserModel.user_id;
    NSString *service_id = [_selectedService objectForKey:@"id"];
    NSString *service_name = [_selectedService objectForKey:@"name"];
    NSString *notes = _noteLabel.text;
    NSString *car_id = [_selectedCarDict objectForKey:@"id"];
    
    if (!service_id) {
        
        service_id = @"";
    }
    if (!service_name) {
        
        service_name = @"";
    }
    
    NSDictionary *params = @{@"keeper_id":@(keeper_id),@"user_id":user_id,@"service_id":service_id,@"service_name":service_name,@"notes":notes,@"user_car_id":car_id};
    
    [[NetWorking shareNetWorking] RequestWithAction:kPushService Params:params itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"服务推荐提交成功!"];
            
        }
    }];
    
    
}
@end
