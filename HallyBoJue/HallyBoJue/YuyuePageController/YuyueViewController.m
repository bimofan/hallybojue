//
//  YuyueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "YuyueViewController.h"
#import "YuyueLeftCell.h"
#import "UserInfo.h"
#import "MJRefresh.h"



@interface YuyueViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int pagesize;
    int page;
    
}
@property(nonatomic,strong) NSMutableArray*myYuyueArray;

@end

@implementation YuyueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    pagesize = 15;
    page = 1;
    
    _leftView.clipsToBounds = YES;
    _leftView.layer.cornerRadius = kCornerRadous;
    
    _rightView.clipsToBounds = YES;
    _rightView.layer.cornerRadius = kCornerRadous;
    
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    

    [_leftTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(yuyueHeaderRefresh)];
    [_leftTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(yuyueFooterRefresh)];
    
    
    [_leftTableView.header beginRefreshing];
    
}


-(void)yuyueHeaderRefresh
{
    page = 1;
    
    [self getmyorders];
    
    
}

-(void)yuyueFooterRefresh
{
    page ++;
    
    [self getmyorders];
    
    
}

-(void)getmyorders
{
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kMyOrderList Params:@{@"page":@(page),@"pagesize":@(pagesize),@"keeper_id":@([UserInfo getkeeperid])}itemModel:nil result:^(BOOL isSuccess, id data) {
        [_leftTableView.header endRefreshing];
        [_leftTableView.footer endRefreshing];
        
        if (isSuccess ) {
            
            
            
            if (page == 1) {
                
                _myYuyueArray = [[NSMutableArray alloc]init];
                
                
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
                    
                    [_myYuyueArray addObject:ordermodel];
                    
                    
                }
                
            }
            
            
            
            [_leftTableView reloadData];
            
            
        }
        
    }];
}


#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YuyueLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YuyueLeftCell"];
    
    if (_myYuyueArray.count > indexPath.section) {
        
        OrderModel *model = [_myYuyueArray objectAtIndex:indexPath.section];
        
        cell.namecarnumLabel.text = model.usermodel.user_real_name;
        
        cell.timeLabel.text = model.order_time;
        
        cell.serviceLabel.text = model.service_name;
        
        cell.serviceStatusLabel.text = model.status_str;
        
        
    }

    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return self.myYuyueArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  5;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView*blankView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    
    blankView.backgroundColor = [UIColor clearColor];
    

    return blankView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 215;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
