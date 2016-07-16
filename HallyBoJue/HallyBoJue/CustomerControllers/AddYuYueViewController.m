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

@interface AddYuYueViewController ()<UITableViewDelegate,UITableViewDataSource,AddNewServiceDelegate>


@property (nonatomic,strong) UIButton *addServiceButton;
@property (nonatomic,strong) UIButton *addTimeButton;
@property (nonatomic,strong) UIButton *addCarButton;
@property (nonatomic,assign) CGFloat buttonHeight;

@property (nonatomic,strong) NSMutableArray *serviceArray;
@property (nonatomic,strong) NSMutableArray *carsArray;
@property (nonatomic,strong) NSDate *oder_time;

@property (nonatomic,strong) AddServiceViewController *addServiceViewController;




@end

@implementation AddYuYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _buttonHeight = 40.0;
    
    _summitButton.clipsToBounds = YES;
    _summitButton.layer.cornerRadius = kCornerRadous;
    
    _serviceTableView.delegate = self;
    _serviceTableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddServiceNoti:) name:kAddServieNotice object:nil];
    
    
    
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAddServieNotice object:nil];
    
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
    
    _realNameLabel.text = _cUserModel.user_real_name;
    
    _levelNameLabel.text = _cUserModel.level_str;
    
    
    
    
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
            
            if (_carsArray.count == 0) {
                
                return 1;
                
            }
            return _carsArray.count;
            
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
        }
            break;
        case 1:
        {
            yueyueCell.typeLabel.text = @"选择车辆";
        }
            break;
        case 2:
        {
            yueyueCell.typeLabel.text = @"选择时间";
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
           
            [[NSUserDefaults standardUserDefaults] setObject:@(2) forKey:kAddNewServiceType];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AddServiceNav"];
            
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            
            
        }
            break;
        case 1:
        {
            
        }
            break;
            
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
    
}


- (IBAction)summitAction:(id)sender {
}
@end
