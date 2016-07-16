//
//  CustomerViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "CustomerViewController.h"
#import "CustomerCell.h"
#import "AddCustomerController.h"
#import "CUserInfoController.h"
#import "AddYuYueViewController.h"


@interface CustomerViewController ()<AddCustomerDelegate>
{
    int page;
    
    
}

@property (nonatomic,strong) AddCustomerController*addCustomerController;
@property (nonatomic,strong) CUserInfoController *cUserInfoController;
@property (nonatomic,strong) AddYuYueViewController *addYuYueViewController;



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
    
    _rightView.clipsToBounds = YES;
    _rightView.layer.cornerRadius = kCornerRadous;
    
    
    [_leftTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(customerHeaderRefresh)];
    [_leftTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(customerFooterRefresh)];
    
    [_leftTableView.header beginRefreshing];
    
    
    
}

#pragma mark - 添加预约
-(AddYuYueViewController*)addYuYueViewController
{
    if (!_addYuYueViewController) {
        
        _addYuYueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddYuYueViewController"];
        
        _addYuYueViewController.view.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
    }
    
    return  _addYuYueViewController;
    
}

#pragma makr - 用户详情页
-(CUserInfoController*)cUserInfoController
{
    if (!_cUserInfoController) {
        
        _cUserInfoController = [self.storyboard instantiateViewControllerWithIdentifier:@"CUserInfoController"];
        
        _cUserInfoController.view.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
        
    
    
        
        
        
    }
    
    return _cUserInfoController;
}

#pragma mark - 新建客户
-(AddCustomerController*)addCustomerController
{
    if (!_addCustomerController) {
        
        _addCustomerController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCustomerController"];
        
        _addCustomerController.view.frame =CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
        
        _addCustomerController.addCustomerDelegate = self;
        
    }
    
    return _addCustomerController;
    
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
        
        NSDictionary *firstcar = [model.cars firstObject];
        
        if (firstcar) {
            
             cell.carnameLabel.text = [firstcar objectForKey:@"brand_name"];
            
        }
        else
        {
            cell.carnameLabel.text = @"";
            
        }
        
        NSDictionary *firstservice = [model.service_orders firstObject];
        
        cell.lastserviceLabel.text = [NSString stringWithFormat:@"最近一次服务时间:%@",[firstservice objectForKey:@"order_time" ]?[firstservice objectForKey:@"order_time" ]:@""];
        
        
        cell.addApointButton.tag = indexPath.section;
        
        [cell.addApointButton addTarget:self action:@selector(addYuYueAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.viplabel.text = model.level_name;
        
        
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
    
    if (section == _customerArray.count -1) {
        
        return 0;
        
    }
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
    
    
    CUserModel *usermodel = [_customerArray objectAtIndex:indexPath.section];
    
    self.cUserInfoController.cUserModel =usermodel;
    
    for (UIView *subview in _rightView.subviews) {
        
        [subview removeFromSuperview];
        
    }
    
    [_rightView addSubview:self.cUserInfoController.view];
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}



#pragma mark - 添加客户 action
- (IBAction)addCustomAction:(id)sender {
    
    
    for (UIView *subview in _rightView.subviews) {
        
        [subview removeFromSuperview];
        
    }
    
    [_rightView addSubview:self.addCustomerController.view];
    
    
}

#pragma mark - addCustomerDelegate
-(void)didAddCustomer
{
      [self.addCustomerController.view removeFromSuperview];
    
    [_leftTableView.header beginRefreshing];
    
  
    
    
}


#pragma mark - 添加预约
-(void)addYuYueAction:(UIButton*)sender
{
    
    for (UIView *view in _rightView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    
     CUserModel  *model = [_customerArray objectAtIndex:sender.tag];
    
    
    self.addYuYueViewController.cUserModel = model;
    
    
    [_rightView addSubview:self.addYuYueViewController.view];
    
}
@end
