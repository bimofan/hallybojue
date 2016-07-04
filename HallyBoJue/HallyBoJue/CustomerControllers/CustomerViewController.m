//
//  CustomerViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "CustomerViewController.h"
#import "CustomerCell.h"

@interface CustomerViewController ()
{
    int page;
    
    
}

@property (nonatomic,strong) NSMutableArray *customerArray;

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    page = 1;

    
    
    _addCustomButton.clipsToBounds = YES;
    _addCustomButton.layer.cornerRadius = kCornerRadous;
    
    _leftView.clipsToBounds = YES;
    _leftView.layer.cornerRadius = kCornerRadous;
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    
    
    
    [_leftTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(customerHeaderRefresh)];
    [_leftTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(customerFooterRefresh)];
    
    [_leftTableView.header beginRefreshing];
    
    
    
}

-(void)customerHeaderRefresh
{
    page = 1;
    
    [self getdata];
    
}

-(void)customerFooterRefresh
{
    page ++;
    [self getdata];
    
}




#pragma mark - 获取数据
-(void)getdata
{
     int keeper_id = [UserInfo getkeeperid];
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kMyCustomerList Params:@{@"page":@(page),@"pagesize":@(kPageSize),@"keeper_id":@(keeper_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        [_leftTableView.header endRefreshing ];
        [_leftTableView.footer endRefreshing];
        
        if (isSuccess) {
            
            
            if (page == 1) {
                
                _customerArray = [[NSMutableArray alloc]init];
                
        
            }
            
            DataModel *model = (DataModel*)data;
            
            if (page >= model.totalpage) {
                
                [_leftTableView.footer noticeNoMoreData];
            }
            else
            {
                [_leftTableView.footer resetNoMoreData];
                
                
            }
            
            for (int i = 0; i <model.items.count; i++) {
                
                NSDictionary *dict = [model.items objectAtIndex:i];
                
                CUserModel *usermodel = [[CUserModel alloc]init];
                
                [usermodel setValuesForKeysWithDictionary:dict];
                
                
                [_customerArray addObject:usermodel];
                
            }
            
            
            [_leftTableView reloadData];
            
            
            
            
        }
        
    }];
    
}







#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerCell"];
    
    if (_customerArray.count > indexPath.section) {
        
  
        CUserModel  *model = [_customerArray objectAtIndex:indexPath.section];
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[model.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
//        cell.carnameLabel.text = m
        cell.realnameLabel.text = model.user_real_name;
        
        
        
    }
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    
    return self.customerArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  5;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView*blankView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    
    blankView.backgroundColor =kBackgroundColor;
    
    
    return blankView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addCustomAction:(id)sender {
}
@end
