//
//  FirstPageViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FirstPageViewController.h"
#import "FirstLeftCell.h"
#import "FirstRightCell.h"
#import "MJRefresh.h"
#import "OrderModel.h"
#import "UserInfo.h"
#import "BaiduMapHelper.h"
#import "AddYuYueViewController.h"







@interface FirstPageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIAlertViewDelegate>
{
    int pagesize;
    int page;
    
    BOOL hadFirstRequest;
    
    NSString *selected_user_id;
    
    
    
}
@property (nonatomic,strong) AddYuYueViewController *addYuYueViewController;
@property (nonatomic,strong) NSMutableArray *yuyueArray;
@property (nonatomic,strong) NSMutableArray *searchArray;




@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _rightSearchBar.delegate =self;
    
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recevieNewOrder:) name:kRecevieNewOrderNoti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNoti:) name:kLogoutNotification object:nil];
    
    
    
    [_leftTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(firstHeaderRefresh)];
    [_leftTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(firstFooterRefresh)];
    
    
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    
    
    page = 1;
    pagesize = 15;
    
    hadFirstRequest = NO;
    
    [_leftTableView.header beginRefreshing];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_searchArray removeAllObjects];
    
    [_rightTableView reloadData];
    

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
  
    if (_yuyueArray.count == 0) {
        
        [_leftTableView.header beginRefreshing];
        
       
    }
}

-(void)viewWillLayoutSubviews
{
    _leftView.clipsToBounds = YES;
    _leftView.layer.cornerRadius = kCornerRadous;
    
    _rightView.clipsToBounds = YES;
    _rightView.layer.cornerRadius = kCornerRadous;
    
    
    
}

-(void)firstHeaderRefresh
{
    page = 1;
    
    [self getneworder];
    
}

-(void)firstFooterRefresh
{
    page++;
    
    [self getneworder];
    
}

-(void)endFirstHeaderRefresh
{
     [_leftTableView.header endRefreshing];
}
-(void)endHeaderRefresh
{
    [_leftTableView.footer endRefreshing];
}


#pragma mark - 获取数据
-(void)getneworder
{
    int store_id = [UserInfo getstoreid];
    
   
    [[NetWorking shareNetWorking] RequestWithAction:kNewOrder Params:@{@"page":@(page),@"pagesize":@(pagesize),@"store_id":@(store_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
       
        [_leftTableView.header endRefreshing];
        [_leftTableView.footer endRefreshing];
        
        if (isSuccess ) {
            
            
         
            if (page == 1) {
                
                _yuyueArray = [[NSMutableArray alloc]init];
            
                
            }
            
            DataModel *dataModel = (DataModel*)data;
            
            if (page >= dataModel.totalpage) {
                
                [_leftTableView.footer noticeNoMoreData];
                
                
                
            }
            else
            {
                [_leftTableView.footer resetNoMoreData];
                
            }
            
            if ([dataModel.items isKindOfClass:[NSArray class]]) {
                
                
                for (int i = 0; i < dataModel.items.count; i++) {
                    
                     OrderModel *ordermodel = [[OrderModel alloc ]init];
                    
                    NSDictionary *dict = [dataModel.items objectAtIndex:i];
                    
                    [ordermodel setValuesForKeysWithDictionary:dict];
                    
                    ordermodel.usermodel = [[CUserModel alloc]init];
                    
                    [ordermodel.usermodel setValuesForKeysWithDictionary:ordermodel.user];
                    
                    [_yuyueArray addObject:ordermodel];
                    
                    
                }
                
            }

            
    
            [_leftTableView reloadData];
            
            
        }
    }];
}

#pragma mark - 搜索用户
-(void)searchCustomer
{
    if (_rightSearchBar.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请输入关键字"];
        
        return;
    }
    
    [[NetWorking shareNetWorking] RequestWithAction:kSearchCustomer Params:@{@"keyword":_rightSearchBar.text} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        
        if (isSuccess) {
            
            DataModel *datamodel = (DataModel*)data;
            
            _searchArray  = [[NSMutableArray alloc]init];
            
            
            for (int i = 0 ; i < datamodel.items.count; i++) {
                
                NSDictionary *dict = [datamodel.items objectAtIndex:i];
                
                CUserModel *cusermodel = [[CUserModel alloc]init];
                
                [cusermodel setValuesForKeysWithDictionary:dict];
                
                [_searchArray addObject:cusermodel];
                
            }
            
            [_rightTableView reloadData];
            
            
            
            
        }
        
        
    }];
}


#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _leftTableView) {
        
        
        if (_yuyueArray.count == 0) {
            
            
            UITableViewCell *blankCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankcell"];
            
            blankCell.textLabel.text = @"暂无数据";
            blankCell.textLabel.textAlignment = NSTextAlignmentCenter;
            blankCell.textLabel.textColor = kSecondeDarkTextColor;
            blankCell.textLabel.font = FONT_14;
            
            blankCell.userInteractionEnabled = NO;
            
            
            return blankCell;
            
            
            
        }
        
        
        FirstLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstLeftCell"];
        
        
        if (_yuyueArray.count > indexPath.section) {
            
            OrderModel *model = [_yuyueArray objectAtIndex:indexPath.section];
            
            cell.nameLabel.text = model.usermodel.nickname;
    
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[model.usermodel.avatar  objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
            float lat = [[model.address_location objectForKey:@"lat"]floatValue];
            float lon = [[model.address_location objectForKey:@"lon"]floatValue];
            
//            [[BaiduMapHelper shareHelper]getLocationAddressWithLat:31.3534 Lon:121.34234 resutl:^(NSString *address) {
//                
//                cell.addressLabel.text = address;
//                
//            }];
            
            
            
         
            
            
            if (lat > 0) {
                
            [[BaiduMapHelper shareHelper]getLocationAddressWithLat:lat Lon:lon resutl:^(NSString *address) {
              
                cell.addressLabel.text = address;
                
            }];
                
                
            }
            
            
            
            NSMutableString *muserviceString = [[NSMutableString alloc]init];
            
            
            for (int i = 0; i < model.services.count; i++) {
                
                NSDictionary *dict = [model.services objectAtIndex:i];
                
                NSString *service_name = [dict objectForKey:@"name"];
                
                if (muserviceString.length == 0) {
                    
                    [muserviceString appendString:service_name];
                }
                else
                {
                    [muserviceString appendFormat:@"\n \n%@",service_name];
                    
                }
            }
            cell.serviceLabel.text = muserviceString;
            
            cell.orderHeight.constant = 40 * model.services.count;
            
            cell.serviceBackViewHeight.constant = 40 * model.services.count;
            
            cell.timeLabel.text = model.order_time;
            
            
      
            cell.catchButton.tag = indexPath.section;
            
            [cell.catchButton addTarget:self action:@selector(catchorder:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
        }

        
        return cell;
     }
    else
    {
        FirstRightCell* rightcell = [tableView dequeueReusableCellWithIdentifier:@"FirstRightCell"];
        
        
        if (_searchArray.count > indexPath.section) {
            
            CUserModel *_cusermodel = [_searchArray objectAtIndex:indexPath.section];
            
            [rightcell.headImageView sd_setImageWithURL:[NSURL URLWithString:[_cusermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
            
            rightcell.nameLabel.text = _cusermodel.nickname;
            
            NSDictionary *firstcar = [_cusermodel.cars firstObject];
            
            rightcell.carLabel.text =  [NSString stringWithFormat:@"%@  %@",[firstcar objectForKey:@"brand_name"],[firstcar objectForKey:@"plate_number"]];
            
            rightcell.levelLabel.text = _cusermodel.level_name;
            
            
            NSDictionary *firstservice = [_cusermodel.service_orders firstObject];
            
            rightcell.lastTimeLabel.text = [NSString stringWithFormat:@"最近一次服务时间:%@",[firstservice objectForKey:@"order_time"]?[firstservice objectForKey:@"order_time"]:@""];
            
            NSArray *services = [firstservice objectForKey:@"services"];
            NSDictionary *first = [services firstObject];
            
            rightcell.lastServiceLabel.text = [NSString stringWithFormat:@"服务名称:%@",[first objectForKey:@"service_name"]?[first objectForKey:@"service_name"]:@""];
            
            
            if (_cusermodel.keeper) {
                rightcell.keeperView.hidden = NO;
                
                rightcell.keeperName.text = [_cusermodel.keeper objectForKey:@"real_name"];
                
                [rightcell.keeperHeadImageView sd_setImageWithURL:[NSURL URLWithString:[[_cusermodel.keeper objectForKey:@"avatar_img"] objectForKey:@"origin" ]] placeholderImage:kDefaultHeadImage];
                
            }
            else
            {
                rightcell.keeperView.hidden = YES;
                
            }
       
            
            
            int keeper_id = [UserInfo getkeeperid];
            if (keeper_id != _cusermodel.keeper_id) {
                
                rightcell.changedButton.hidden = NO;
                rightcell.changedButton.tag = indexPath.section;
                [rightcell.changedButton addTarget:self action:@selector(changedKeeper:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                rightcell.changedButton.hidden = YES;
          
            }
            
            
            rightcell.addAppointButton.tag = indexPath.section;
            [rightcell.addAppointButton addTarget:self action:@selector(addYuYueAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            
            

            
            
        
            
             
            
        }
        
        
        return rightcell ;
        
        
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView == _leftTableView) {
        
        
        if (_yuyueArray.count == 0) {
            
            return 1;
            
        }
         return self.yuyueArray.count;
    }
    else
    {
        return _searchArray.count;
        
    }
    

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    
    return  0;
    
    
//    if (tableView == _leftTableView) {
//        if (_yuyueArray.count == 0) {
//            
//            return 0;
//            
//        }
//        
//        if (section == _yuyueArray.count -1) {
//            
//            return 0;
//            
//        }
//        
//        return  5;
//        
//        
//    }
//    else
//    {
//        return  5;
//        
//    }
 
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*blankView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    
    blankView.backgroundColor = kBackgroundColor;
    
    
    return blankView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _leftTableView) {
        
        
        if (_yuyueArray.count == 0) {
            
            return 44;
            
        }
        
          OrderModel *model = [_yuyueArray objectAtIndex:indexPath.section];
        
          
        return 165 + 40 * model.services.count;
        
    }
    else
    {
        return 140;
        
    }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - 抢单
-(void)catchorder:(UIButton*)sender
{
    
    OrderModel *order = [_yuyueArray objectAtIndex:sender.tag];
    
    int order_id = order.id;
    
    Usermodel *model = [UserInfo getUserModel];
    
    [[NetWorking shareNetWorking] RequestWithAction:kCatchOrder Params:@{@"order_id":@(order_id),@"keeper_id":@(model.keeper_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            [_yuyueArray removeObjectAtIndex:sender.tag];
            
            [CommonMethods showDefaultErrorString:@"抢单成功"];
            
            [_leftTableView reloadData];
            
            order.status = 2;
            order.status_str = @"预约确认";
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kSuccesCatchOrder object:order];
            
            
            
            
        }
        
    }];
    
    
}

#pragma mark - UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.view endEditing:YES];
    
    [self searchCustomer];
    
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 999 && buttonIndex == 1) {
        
        [self changkeeper];
        
    }
}


#pragma mark - 点击变更管家
-(void)changedKeeper:(UIButton*)sender
{
        CUserModel *_cusermodel = [_searchArray objectAtIndex:sender.tag];
    
    selected_user_id = _cusermodel.user_id;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定变更管家吗?" delegate:self  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 999;
    
    [alert show];
    
    
    
}

#pragma mark - 变更管家
-(void)changkeeper
{
    
    int keeper_id = [UserInfo getkeeperid];
    
    NSDictionary *param = @{@"keeper_id":@(keeper_id),@"user_id":selected_user_id};
    
    [[NetWorking shareNetWorking]RequestWithAction:kChangedKeeper Params:param itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"管家变更成功,请到【预约管理】查看新的预约"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kRecevieNewOrderNoti object:nil];
            
            if (_rightSearchBar.text.length > 0) {
                
                [self searchCustomer];
                
            }
        }
    }];
}

#pragma mark - 添加预约动作
-(void)addYuYueAction:(UIButton*)sender
{
    
    
//    for (UIView *view in _rightView.subviews) {
//        
//        [view removeFromSuperview];
//        
//    }
    
    
    CUserModel *_cusermodel = [_searchArray objectAtIndex:sender.tag];
    
    
    self.addYuYueViewController.cUserModel = _cusermodel;
    
    
    
    [_rightView addSubview:self.addYuYueViewController.view];
    
    
    

}
#pragma mark - 添加预约界面
-(AddYuYueViewController*)addYuYueViewController
{
    if (!_addYuYueViewController) {
        
        _addYuYueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddYuYueViewController"];
        
        _addYuYueViewController.view.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
    }
    
    return  _addYuYueViewController;
    
}



#pragma mark - 新订单推送
-(void)recevieNewOrder:(NSNotification*)note
{
    [_leftTableView.header beginRefreshing];
    
}

#pragma mark - 退出登录
-(void)logoutNoti:(NSNotification*)note
{
    [_yuyueArray removeAllObjects];
    
    [_leftTableView reloadData];
    
}





@end
