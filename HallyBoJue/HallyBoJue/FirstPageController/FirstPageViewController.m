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






@interface FirstPageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int pagesize;
    int page;
    
}

@property (nonatomic,strong) NSMutableArray *yuyueArray;
@property (nonatomic,strong) NSMutableArray *searchArray;



@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    
    [_leftTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(firstHeaderRefresh)];
    [_leftTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(firstFooterRefresh)];
    
    
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    
    
    page = 1;
    pagesize = 15;
    
    [self firstHeaderRefresh];
    
    
    
}


-(void)viewWillLayoutSubviews
{
    _leftView.clipsToBounds = YES;
    _leftView.layer.cornerRadius = 6.0;
    
    _rightView.clipsToBounds = YES;
    _rightView.layer.cornerRadius = 6.0;
    
    
    
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
    
   
    
    [[NetWorking shareNetWorking] RequestWithAction:kNewOrder Params:@{@"page":@(page),@"pagesize":@(pagesize)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
       
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
#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _leftTableView) {
        
        
        if (_yuyueArray.count == 0) {
            
            
            UITableViewCell *blankCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankcell"];
            
            blankCell.textLabel.text = @"暂无数据";
            blankCell.textLabel.textAlignment = NSTextAlignmentCenter;
            blankCell.textLabel.textColor = kBackgroundColor;
            
            blankCell.userInteractionEnabled = NO;
            
            
            return blankCell;
            
            
            
        }
        
        
        FirstLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstLeftCell"];
        
        
        if (_yuyueArray.count > indexPath.section) {
            
            OrderModel *model = [_yuyueArray objectAtIndex:indexPath.section];
            
            cell.nameLabel.text = model.usermodel.user_real_name;
    
            float lat = [[model.address_location objectForKey:@"lat"]floatValue];
            float lon = [[model.address_location objectForKey:@"lon"]floatValue];
            
            [[BaiduMapHelper shareHelper]getLocationAddressWithLat:31.3534 Lon:121.34234 resutl:^(NSString *address) {
                
                cell.addressLabel.text = address;
                
            }];
            
            
//            if (lat > 0) {
//                
//            [[BaiduMapHelper shareHelper]getLocationAddressWithLat:31.3534 Lon:121.34234 resutl:^(NSString *address) {
//              
//                cell.addressLabel.text = address;
//                
//            }];
//                
//                
//            }
//            
            

//            cell.addressLabel.text = model.order_address;
            
            
            
            
            cell.timeLabel.text = model.order_time;
            
            cell.serviceLabel.text = model.service_name;
            
            cell.catchButton.tag = indexPath.section;
            
            [cell.catchButton addTarget:self action:@selector(catchorder:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
        }

        
        return cell;
    }
    else
    {
        FirstRightCell* rightcell = [tableView dequeueReusableCellWithIdentifier:@"FirstRightCell"];
        
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
    
    if (tableView == _leftTableView) {
        if (_yuyueArray.count == 0) {
            
            return 0;
            
        }
        
        return  5;
        
        
    }
    else
    {
        return  5;
        
    }
 
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
        return 245;
        
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
    
    [[NetWorking shareNetWorking] RequestWithAction:kCatchOrder Params:@{@"order_id":@(order_id),@"keeper_id":@(model.id)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            [_yuyueArray removeObjectAtIndex:sender.tag];
            
            [CommonMethods showDefaultErrorString:@"抢单成功"];
            
            [_leftTableView reloadData];
            
            
            
        }
        
    }];
    
    
}





@end
