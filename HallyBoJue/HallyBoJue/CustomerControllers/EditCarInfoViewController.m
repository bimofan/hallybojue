//
//  EditCarInfoViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/24.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "EditCarInfoViewController.h"
#import "PushServiceCell.h"
#import "ChoseWorkPlaceView.h"


@interface EditCarInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ChoseWorkPlaceDelegate>

@property (nonatomic,strong) ChoseWorkPlaceView *choseWorkPlaceView;
@property (nonatomic,strong) NSDictionary *selectedCarDict;


@end

@implementation EditCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _headImageView.clipsToBounds= YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _saveCarInfoButton.clipsToBounds= YES;
    _saveCarInfoButton.layer.cornerRadius = kCornerRadous;
    
    _saveCarInfoButton.layer.borderColor = kBorderColor.CGColor;
    _saveCarInfoButton.layer.borderWidth = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _carSelectTableView.delegate= self;
    _carSelectTableView.dataSource = self;
    
    _vipCarLabel.clipsToBounds = YES;
    _vipCarLabel.layer.cornerRadius = kCornerRadous;
    
    
    _vi_numberTF.delegate = self;
    _vi_numberTF.tag = 1;
    
    _engine_numberTF.delegate = self;
    _engine_numberTF.tag = 2;
    
    _mileage_TF.delegate = self;
    _mileage_TF.tag = 3;
    
    _color_TextField.delegate = self;
    _color_TextField.tag = 4;
    
    _tire_TextField.delegate = self;
    _tire_TextField.tag = 5;
    
    _car_license_TextField.delegate = self;
    _car_license_TextField.tag = 6;
    
    _driver_license_TextField.delegate = self;
    _driver_license_TextField.tag = 7;
    
    
    
    
}

-(void)setCUserModel:(CUserModel *)cUserModel
{
    _cUserModel = cUserModel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_cUserModel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _nameLabel.text = _cUserModel.nickname;
    
    _vipCarLabel.text = _cUserModel.level_name;
    
    _vipAddressLabel.text = _cUserModel.vip_address;
    
    _vi_numberTF.text = nil;
    _engine_numberTF.text = nil;
    _mileage_TF.text = nil;
    _car_license_TextField.text = nil;
    _driver_license_TextField.text = nil;
    _color_TextField.text = nil;
    _tire_TextField.text = nil;
    
    
    _selectedCarDict = nil;
    
    [_carSelectTableView reloadData];
    
    
    
     
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PushServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PushServiceCell"];
    
    if (_selectedCarDict) {
        
        cell.titleLabel.text = [_selectedCarDict objectForKey:@"brand_name"];
        cell.priceLabel.text = [_selectedCarDict objectForKey:@"plate_number"];
    }
    else
    {
        cell.titleLabel.text = nil;
        cell.priceLabel.text = nil;
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self showcarchoseView];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)showcarchoseView
{
    self.choseWorkPlaceView.type = 4;
    
    self.choseWorkPlaceView.selectedDict = _selectedCarDict;
    
    self.choseWorkPlaceView.workDataSource = _cUserModel.cars;
    self.choseWorkPlaceView.titleLabel.text = @"车辆选择";
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
    
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

#pragma mark  - ChoseWorkPlaceDelegate
-(void)didChoseItems:(NSArray *)items
{
    _selectedCarDict = [items firstObject];
    
    [_carSelectTableView reloadData];
    
    _mileage_TF.text = [_selectedCarDict objectForKey:@"mileage"];
    
    _vi_numberTF.text = [_selectedCarDict objectForKey:@"vi_number"];
    
    _engine_numberTF.text = [_selectedCarDict objectForKey:@"engine_number"];
    
    _tire_TextField.text = [_selectedCarDict objectForKey:@"tire_model"];
    
    _color_TextField.text = [_selectedCarDict objectForKey:@"car_color"];
    
    _driver_license_TextField.text = [_selectedCarDict objectForKey:@"driver_license"];
    
    _car_license_TextField.text  = [_selectedCarDict objectForKey:@"car_license"];
    
    
    
    
    
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
       
        
        self.view.bounds = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 50*textField.tag, self.view.bounds.size.width, self.view.bounds.size.height);
        

        
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.3 animations:^{
       
       self.view.bounds =  CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y - 50*textField.tag, self.view.bounds.size.width, self.view.bounds.size.height);
        
      
    }];
    
    
  
}


- (IBAction)saveCarInfoAction:(id)sender {
    
    if (!_selectedCarDict) {
        
        [CommonMethods showDefaultErrorString:@"请选择车辆"];
        
        return;
    }
    
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]init];
    
    int car_id = [[_selectedCarDict objectForKey:@"id"]intValue];
    
    [mudict setObject:@(car_id) forKey:@"id"];
    
    if (_vi_numberTF.text.length > 0) {
        
        [mudict setObject:_vi_numberTF.text forKey:@"vi_number"];
    }
    
    if (_engine_numberTF.text.length > 0) {
        
        [mudict setObject:_engine_numberTF.text forKey:@"engine_number"];
    }
    
    if (_mileage_TF.text.length > 0) {
        
        [mudict setObject:_mileage_TF.text forKey:@"mileage"];
        
        
    }
    
    if (_color_TextField.text.length > 0) {
        
        [mudict setObject:_color_TextField.text forKey:@"car_color"];
    }
    if (_car_license_TextField.text.length  > 0) {
        
        [mudict setObject:_car_license_TextField.text forKey:@"car_license"];
    }
    if (_driver_license_TextField.text.length > 0) {
        
        [mudict setObject:_driver_license_TextField.text forKey:@"driver_license"];
    }
    
    if (_tire_TextField.text.length > 0) {
        
        [mudict setObject:_tire_TextField.text forKey:@"tire_model"];
    }
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kChangedcarinfo Params:mudict itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"车辆信息更新成功!"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kSuccessUpdateCarInfo object:nil];
            
        }
    }];
    
}
@end
