//
//  SetRemindViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/19.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "SetRemindViewController.h"
#import "RemindCell.h"
#import "ChoseWorkPlaceView.h"
#import "SelectTimeView.h"


@interface SetRemindViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ChoseWorkPlaceDelegate,SelectTimeViewDelegate>

@property (nonatomic,strong) NSDictionary *selectedCarDict;
@property (nonatomic,strong) NSDate *next_time;
@property (nonatomic,strong) NSString *next_service;
@property (nonatomic,strong) ChoseWorkPlaceView *choseWorkPlaceView;
@property (nonatomic,strong) NSMutableArray *carsArray;
@property (nonatomic,strong) NSDate *order_time;
@property (nonatomic,strong) SelectTimeView *selectTimeView;
@property (nonatomic,strong) NSDate *remindTime;
@property (nonatomic,assign) NSInteger showType;







@end

@implementation SetRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _remindTableView.delegate = self;
    
    _remindTableView.dataSource = self;
    
    _remindcontentTextField.delegate = self;
    
//    _remindcontentTextField.clipsToBounds = YES;
//    _remindcontentTextField.layer.cornerRadius = kCornerRadous;
//    
//    _remindcontentTextField.layer.borderColor = kGrayBackColor.CGColor;
//    _remindcontentTextField.layer.borderWidth = 1;
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _vipnameLabel.clipsToBounds = YES;
    _vipnameLabel.layer.cornerRadius = kCornerRadous;
    
    _summitButton.clipsToBounds = YES;
    _summitButton.layer.cornerRadius = kCornerRadous;
    _summitButton.layer.borderWidth = 1;
    _summitButton.layer.borderColor = kBorderColor.CGColor;
    
    
    

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

-(void)setCUserModel:(CUserModel *)cUserModel
{
    _cUserModel = cUserModel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_cUserModel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _realnameLabel.text = _cUserModel.nickname;
    
    _vipnameLabel.text = _cUserModel.level_name;
    
    _selectedCarDict = nil;
    _order_time = nil;
    _remindTime = nil;
    
    [_remindTableView reloadData];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RemindCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RemindCell"];
    
    if (indexPath.section == 0) {
        
        cell.placeholderLabel.text = @"选择车辆";
        
        if (_selectedCarDict) {
            
            cell.contentLabel.text = [NSString stringWithFormat:@"%@   %@",[_selectedCarDict objectForKey:@"brand_name"],[_selectedCarDict objectForKey:@"plate_number"]];
            
            

            
        }
        else
        {
            cell.contentLabel.text = @"";
            
    
        }
        
        
    }
    else if(indexPath.section == 1)
    {
        cell.placeholderLabel.text = @"下次服务时间";
        
        if (_order_time) {
            
            cell.contentLabel.text = [CommonMethods getYYYYMMddhhmmDateStr:_order_time];
            
        }
        else
        {
            cell.contentLabel.text = @"";
            
            
        }
    }
    else if (indexPath.section == 2)
    {
        cell.placeholderLabel.text = @"提醒时间";
        
        if (_remindTime) {
            
            cell.contentLabel.text = [CommonMethods getYYYYMMddhhmmDateStr:_remindTime];
            
        }
        else
        {
            cell.contentLabel.text = @"";
            
            
        }
    }
    
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    blankView.backgroundColor = kGrayBackColor;
    

    return blankView;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        
        if (_carsArray.count >0) {
            
            self.choseWorkPlaceView.type = 4;
            
            self.choseWorkPlaceView.selectedDict = _selectedCarDict;
            
            self.choseWorkPlaceView.workDataSource = _carsArray;
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"未查到该用户的车辆信息"];
            
        }

    }
    else if(indexPath.section == 1)
    {
        
        _showType = 1;
        
        if (_order_time) {
            
            self.selectTimeView.selectedDate = _order_time;
        }
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.selectTimeView];
    }
    else if(indexPath.section == 2)
    {
        _showType = 2;
        
        if (_remindTime) {
            
            self.selectTimeView.selectedDate = _remindTime;
        }
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.selectTimeView];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - ChoseWorkPlaceDelegate
-(void)didChoseItems:(NSArray *)items
{
    _selectedCarDict = [items firstObject];
    
    [_remindTableView reloadData];
    
}


#pragma mark - SelectTimeViewDelegate
-(void)didSelectedDate:(NSDate *)selectedDate
{
    
    if (_showType == 1) {
        
         _order_time = selectedDate;
    }
    else
    {
        _remindTime = selectedDate;
        
    }
   
    
    [_remindTableView reloadData];
    
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)summitAction:(id)sender {
    
    
    if (!_order_time) {
        
        [CommonMethods showDefaultErrorString:@"请选择下次服务时间"];
        
        return;
    }
    
    if (!_selectedCarDict) {
        
        [CommonMethods showDefaultErrorString:@"请选择车辆"];
        
        return;
    }
    
    if (_remindcontentTextField.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写提醒内容"];
        
        return;
    }
    
    if (!_remindTime) {
        
        [CommonMethods showDefaultErrorString:@"请填写提醒时间"];
        
        return;
        
    }
    
    int keeper_id = [UserInfo getkeeperid];
    
    NSString * user_id = _cUserModel.user_id;
    
    NSString *next_time =  [CommonMethods getYYYYMMddhhmmDateStr:_order_time];
    
    NSString *car_id = [_selectedCarDict objectForKey:@"id"];
    
    NSString *remind_time = [CommonMethods getYYYYMMddHHmmssDateStr:_remindTime];
    
    
    
    NSDictionary *params = @{@"user_id":user_id,@"keeper_id":@(keeper_id),@"car_id":car_id,@"next_service":_remindcontentTextField.text,@"next_time":next_time,@"remind_time":remind_time};
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kAddFollow Params:params itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"跟进提醒提交成功"];
            
            
            if ([self.delegate respondsToSelector:@selector(didSetRemind)]) {
                
                [self.delegate didSetRemind];
                
            }
        }
        
    }];
    
    
}
@end
