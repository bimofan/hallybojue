//
//  AddVipCardViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/20.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "AddVipCardViewController.h"
#import "AddVipCardCell.h"
#import "ChoseWorkPlaceView.h"
#import "AddVipCardViewController.h"



@interface AddVipCardViewController ()<UITableViewDelegate,UITableViewDataSource,ChoseWorkPlaceDelegate>

@property (nonatomic,strong) NSMutableArray *vipCardTemplates;
@property (nonatomic,strong) NSMutableArray *carsArray;
@property (nonatomic,strong) ChoseWorkPlaceView *choseWorkPlaceView;
@property (nonatomic,strong) NSDictionary *selectedCarDict;
@property (nonatomic,strong) NSDictionary *vipCardDict;








@end

@implementation AddVipCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _headImageView.clipsToBounds= YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _vipLabel.clipsToBounds = YES;
    _vipLabel.layer.cornerRadius = kCornerRadous;
    
    _summitButton.clipsToBounds = YES;
    _summitButton.layer.cornerRadius = kCornerRadous;
    
   
    _vipTableView.delegate = self;
    _vipTableView.dataSource = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didselectedVipCard:) name:kDidSelectedVipCardNoti object:nil];
    
    
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidSelectedVipCardNoti object:nil];
    
    
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

-(void)getvipcards
{
    
    [[NetWorking shareNetWorking] RequestWithAction:kGetVipCardTemplates Params:nil itemModel:nil result:^(BOOL isSuccess, DataModel * data) {
       
        if (isSuccess) {
            
            _vipCardTemplates = [[NSMutableArray alloc]init];
            
            [_vipCardTemplates addObjectsFromArray:data.items];
            
            
            
        }
    }];
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
    
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_cUserModel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _nameLabel.text = _cUserModel.nickname;
    
    _vipLabel.text = _cUserModel.level_name;
    
    _vipCardAddressLabel.text = _cUserModel.vip_address;
    
    
    if (_vipCardTemplates.count == 0) {
        
        [self getvipcards];
    }
    
    
    [self getusercars];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    view.backgroundColor = kBackgroundColor;
    
    return view;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddVipCardCell"];
    
    switch (indexPath.section) {
        case 0:
        {
            
            cell.placeHolderLabel.text = @"选择会籍卡";
            if (_vipCardDict) {
                
                cell.nameLabel.text = [_vipCardDict objectForKey:@"template_name"];
                cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[_vipCardDict objectForKey:@"price"]];
                
            }
            else
                
            {
                cell.nameLabel.text = nil;
                cell.priceLabel.text = nil;
                
            }
        }
            break;
        case 1:
        {
             cell.placeHolderLabel.text = @"选择车辆";
            
            if (_selectedCarDict) {
                
                cell.nameLabel.text = [_selectedCarDict objectForKey:@"brand_name"];
                cell.priceLabel.text = [_selectedCarDict objectForKey:@"plate_number"];
            }
            else
            {
                cell.nameLabel.text = nil;
                cell.priceLabel.text = nil;
                
            }
        
            
        }
            break;
            
            
        default:
            break;
    }

    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        
        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"ChoseVipNav"];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        
        
    }
    
    if (indexPath.section == 1) {
        
        self.choseWorkPlaceView.type = 4;
        
        self.choseWorkPlaceView.selectedDict = _selectedCarDict;
        
        self.choseWorkPlaceView.workDataSource = _carsArray;
        
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - ChoseWorkPlaceDelegate
-(void)didChoseItems:(NSArray *)items
{
    _selectedCarDict = [items firstObject];
    
    [_vipTableView reloadData];
    
}

#pragma mark - 选择了会籍卡
-(void)didselectedVipCard:(NSNotification*)noti
{
    _vipCardDict = noti.object;
    
    [_vipTableView reloadData];
    
}



- (IBAction)summitAction:(id)sender {
    
    
    if (!_vipCardDict) {
        
        [CommonMethods showDefaultErrorString:@"请选择会籍卡类型"];
        
        return;
        
    }
    
    if (!_selectedCarDict) {
        
        [CommonMethods showDefaultErrorString:@"请选择车辆"];
        
        return;
    }
    
    NSString *user_id = _cUserModel.user_id;
    
    int vipcard_template_id = [[_vipCardDict objectForKey:@"template_id"]intValue];
    
    float amount = [[_vipCardDict objectForKey:@"price"]floatValue];
    
    int keeper_id = [UserInfo getkeeperid];
    
    int car_id = [[_selectedCarDict objectForKey:@"id"]intValue];
    
    int store_id = [UserInfo getstoreid];
    
    
    NSDictionary *params = @{@"user_id":user_id,@"vipcard_template_id":@(vipcard_template_id),@"amount":@(amount),@"keeper_id":@(keeper_id),@"car_id":@(car_id),@"store_id":@(store_id)};
    
    [[NetWorking shareNetWorking] RequestWithAction:kAddVipCard Params:params itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"会籍卡申请提交成功"];
            
        }
    }];
    
    
    
    
}
@end
