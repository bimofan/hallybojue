//
//  FollowUserController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FollowUserController.h"
#import "FollowUserCell.h"
#import "FollowModel.h"
#import "CommonMethods.h"
#import "FollowServiceListCell.h"
#import "SetRemindViewController.h"
#import "BlankCell.h"



@interface FollowUserController ()<UITableViewDelegate,UITableViewDataSource,SetRemindViewDelegate,UISearchBarDelegate>
{
    NSInteger page ;
    NSInteger pagesize;
    
}
@property (nonatomic,strong)NSMutableArray *followsArray;

@property (nonatomic,strong) FollowModel *selectedModel;



@property (nonatomic,strong) SetRemindViewController *setRemindViewController;



@end

@implementation FollowUserController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    page = 1;
    pagesize = 15;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNoti:) name:kLogoutNotification object:nil];
    
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    
    
    _leftView.clipsToBounds =YES;
    _leftView.layer.cornerRadius = kCornerRadous;
    
    _rightView.clipsToBounds = YES;
    _rightView.layer.cornerRadius = kCornerRadous;
    
    _rightView.hidden = YES;
    
    
    _setButton.clipsToBounds = YES;
    _setButton.layer.cornerRadius = kCornerRadous;
    _setButton.layer.borderColor = kBorderColor.CGColor;
    _setButton.layer.borderWidth = 1;
    
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _vipNameLabel.clipsToBounds= YES;
    _vipNameLabel.layer.cornerRadius = kCornerRadous;
    
    
    _setfollowButton.clipsToBounds = YES;
    _setfollowButton.layer.cornerRadius = kCornerRadous;
    _setfollowButton.layer.borderColor = kBorderColor.CGColor;
    _setfollowButton.layer.borderWidth = 1;
    
    
    _rightView.hidden = YES;
    
    
    _historyserviceTable.delegate = self;
    _historyserviceTable.dataSource = self;
    
    
    _searchBar.delegate = self;
    
    
    [_userTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    [_userTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_followsArray.count == 0) {
        
        [_userTableView.header beginRefreshing];
        
    }
}


-(SetRemindViewController*)setRemindViewController
{
    if (!_setRemindViewController) {
        
        _setRemindViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"SetRemindViewController"];
        
        _setRemindViewController.view.frame = _rightView.frame;
        
        _setRemindViewController.delegate = self;
        
        
    }
    
    return _setRemindViewController;
    
}

-(void)headerRefresh
{
    page = 1;
    
    [self getData];
    
}

-(void)footerRefresh
{
    page ++;
    
}
-(void)getData
{
    
    int keeper_id = [UserInfo getkeeperid];
    
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kGetFollowlist Params:@{@"keeper_id":@(keeper_id),@"page":@(page),@"pagesize":@(pagesize)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        
        [_userTableView.header endRefreshing];
        [_userTableView.footer endRefreshing];
        

        
        if (isSuccess) {
            
            
            if (page == 1) {
                
                _followsArray = [[NSMutableArray alloc]init];
                
                
            }
            
            DataModel *dataModel = (DataModel*)data;
            
            if (page >= dataModel.totalpage) {
                
                [_userTableView.footer noticeNoMoreData];
                
                
                
            }
            else
            {
                [_userTableView.footer resetNoMoreData];
                
            }
       
            
            for (int i = 0; i < dataModel.items.count; i++) {
                
                NSDictionary *dict = [dataModel.items objectAtIndex:i];
                
                FollowModel *model = [[FollowModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                CUserModel *cuserModel = [[CUserModel alloc]init];
                
                if ([[dict objectForKey:@"user"] isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *cUserDict = [dict objectForKey:@"user"];
                    
                    [cuserModel setValuesForKeysWithDictionary:cUserDict];
                    
                    model.cUserModel = cuserModel;
                }
                
                
                [_followsArray addObject:model];
                
                
            }
            
            
            
            if (page == 1) {
                
                _selectedModel = [_followsArray firstObject];
                
                if (_followsArray.count == 0) {
                    
                    _rightView.hidden = YES;
                    
                }
                else
                {
                    _rightView.hidden = NO;
                    
                }
                
                [self setHeader];
                
                
            }
            
            
          
            
            [_userTableView reloadData];
            
            
            
        }
        
        
    }];
    
}


#pragma mark - 搜索我的跟进
-(void)getmyfollowsearch
{
    int keeper_id = [UserInfo getkeeperid];
    
    NSString *keyword = _searchBar.text;
    
    [[NetWorking shareNetWorking] RequestWithAction:kMyFollowSearch Params:@{@"keeper_id":@(keeper_id),@"keyword":keyword} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            _followsArray = [[NSMutableArray alloc]init];
            
             DataModel *dataModel = (DataModel*)data;
            
            for (int i = 0; i < dataModel.items.count; i++) {
                
                NSDictionary *dict = [dataModel.items objectAtIndex:i];
                
                FollowModel *model = [[FollowModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                CUserModel *cuserModel = [[CUserModel alloc]init];
                
                if ([[dict objectForKey:@"user"] isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *cUserDict = [dict objectForKey:@"user"];
                    
                    [cuserModel setValuesForKeysWithDictionary:cUserDict];
                    
                    model.cUserModel = cuserModel;
                }
                
                
                [_followsArray addObject:model];
                
                
             }
            
            
            [_userTableView reloadData];
            
        }
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_followsArray.count == 0) {
        
        
        return 60;
    }
    
    if (tableView == _userTableView) {
        
         return 160;
    }
    else
    {
      
        
        NSDictionary *service = _selectedModel.service_order;
        
        
        NSArray *services = [service objectForKey:@"services"];
        

        
        return 100 + services.count * 28;
        
        
    }
   
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == _userTableView) {
        
          return 1;
    }
  else
  {
      return 1;
      
//      FollowModel *model = _selectedModel;
//      
//      NSDictionary *service = model.service_order;
//      
//      
//      NSArray *services = [service objectForKey:@"services"];
//      
//      return services.count;
      
      

  }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (_followsArray.count == 0) {
        
        return 1;
        
    }
    if (tableView == _userTableView) {
        
        
        return _followsArray.count;
    }
    else
    {
        return 1;
        
    }
 
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    if (_followsArray.count == 0) {
        
        
        BlankCell *_blankCell = [[[NSBundle mainBundle] loadNibNamed:@"BlankCell" owner:self options:nil]firstObject];
        
        _blankCell.userInteractionEnabled = NO;
        
        return _blankCell;
        
        
        
    }
    
    
    
    if (tableView == _userTableView) {
        
        
   
    FollowUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowUserCell"];
    
    if (indexPath.section  < _followsArray.count) {
        
        FollowModel *model = [_followsArray objectAtIndex:indexPath.section];
        
        if (model.cUserModel.avatar) {
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[model.cUserModel.avatar  objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
            
        }
  
        
        cell.realNameLabel.text = model.cUserModel.nickname;
        
        cell.vipCardLabel.text = model.cUserModel.level_name;
        
        cell.carnameLabel.text = [model.car objectForKey:@"series"];
        
        NSDate *date = [CommonMethods getYYYYMMddhhmmssFromString:model.next_time];
        
        NSString *nextdateString = [CommonMethods getYYYYMMddFromDefaultDateStr:date];
        
        cell.nextServcietimeLabel.text = [NSString stringWithFormat:@"下次服务时间:   %@", nextdateString];
        
        cell.nextserviceNameLabel.text = model.next_service;
        
        
        
    }
    
    return cell;
    
         }
    else
    {
     
        
        FollowModel *model = _selectedModel;
        
        NSDictionary *service = model.service_order;
        
        
        NSArray *services = [service objectForKey:@"services"];
        
        NSMutableString *muStrig = [[NSMutableString alloc]init];
        
        for (int i = 0; i < services.count; i++) {
            
            NSDictionary *oneService = [services objectAtIndex:i];
            
            NSString *service_name = [oneService objectForKey:@"service_name"];
            
            if (muStrig.length == 0) {
                
                [muStrig appendString:service_name];
            }
            else
            {
                [muStrig appendFormat:@"\n \n%@ ",service_name];
                
            }
        }
        
        FollowServiceListCell *servicelistCell = [tableView dequeueReusableCellWithIdentifier:@"FollowServiceListCell"];
        
        servicelistCell.servicesLabelHeigh.constant = 28* services.count;
        
        servicelistCell.servicesLabel.text = muStrig;
        
        servicelistCell.storeNameLabel.text = model.store_name;
        servicelistCell.keeper_nameLabel.text = model.keeper_name;
        servicelistCell.timeLabel.text = [service objectForKey:@"order_time"];
        
        
        
        return servicelistCell;
        
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (tableView == _userTableView) {
        
        _selectedModel = [_followsArray objectAtIndex:indexPath.section];
        
        _rightView.hidden = NO;
        
        
        [self setHeader];
        
    
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

-(void)setHeader
{
    
    
    
    [self.setRemindViewController.view removeFromSuperview];
    
    
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    if (_selectedModel.cUserModel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_selectedModel.cUserModel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
    }
    
    _realNameLabel.text = _selectedModel.cUserModel.nickname;
    
    _vipNameLabel.text = _selectedModel.cUserModel.level_name;
    
    _vipAddressLabel.text = _selectedModel.cUserModel.vip_address;
    
    _phoneLabel.text = [NSString stringWithFormat:@" 联系电话:%@",_selectedModel.cUserModel.mobile];
    
    
    
    
    [_historyserviceTable reloadData];
    
    
}


#pragma mark - UISearchBarDelegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self getmyfollowsearch];
    
}


- (IBAction)setAction:(id)sender {
    
    
    _rightView.hidden = YES;
    
    self.setRemindViewController.cUserModel = _selectedModel.cUserModel;
    
    [self.view addSubview:self.setRemindViewController.view];
    
    
}

#pragma mark - SetRemindViewDelegate
-(void)didSetRemind
{
      [_userTableView.header beginRefreshing];
}

#pragma mark - 退出登录
-(void)logoutNoti:(NSNotification*)note
{
    [_followsArray removeAllObjects];
    
    [_userTableView reloadData];
    
    _rightView.hidden = YES;
    
    
    
}


- (IBAction)setfollowAction:(id)sender {
    
    int follow_id = _selectedModel.follow_id;
    
    [[NetWorking shareNetWorking] RequestWithAction:kUpdateFollow Params:@{@"follow_id":@(follow_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"跟进提醒成功"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kHadUpdateFollowNoti object:nil];
            
            
              _rightView.hidden = YES;
            
            [_userTableView.header beginRefreshing];
            
            
            
        }
    }];
    
}
@end
