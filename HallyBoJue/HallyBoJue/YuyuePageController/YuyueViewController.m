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
#import "OneYuyueViewController.h"
#import "TwoViewController.h"
#import "ThirdYuYueViewController.h"
#import "FourYuYueViewController.h"
#import "FiveYuYueViewController.h"




@interface YuyueViewController ()<UITableViewDelegate,UITableViewDataSource,OneYuyueDelegate,TwoViewDelegate,ThirdViewDelegate,FourYuYueDelegate>
{
    int pagesize;
    int page;
    
    NSInteger selectedIndexSection;
    
    
}
@property(nonatomic,strong) NSMutableArray*myYuyueArray;
@property (nonatomic,strong)OneYuyueViewController *oneYuyueViewController;
@property (nonatomic,strong) TwoViewController *twoViewController;  //开始派工
@property (nonatomic,strong) ThirdYuYueViewController *thirdYuYueViewController;
@property (nonatomic,strong) FourYuYueViewController *fourYuYueViewController;
@property (nonatomic,strong) FiveYuYueViewController *fiveYuYueViewController;






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
    
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addnewservicenotice:) name:kAddServieNotice object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(catchOrderSucces:) name:kSuccesCatchOrder object:nil];
    
    
    [_leftTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(yuyueHeaderRefresh)];
    [_leftTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(yuyueFooterRefresh)];
    
    
    [_leftTableView.header beginRefreshing];
    
    
    
}

#pragma mark - 完成
-(FiveYuYueViewController*)fiveYuYueViewController
{
    
    if (!_fiveYuYueViewController) {
        
        _fiveYuYueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FiveYuYueViewController"];
        
        _fiveYuYueViewController.view.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
        
    }
    
    return _fiveYuYueViewController;
    
}


#pragma mark - 待支付
-(FourYuYueViewController*)fourYuYueViewController
{
    if (!_fourYuYueViewController) {
        
        _fourYuYueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FourYuYueViewController"];
        
        _fourYuYueViewController.view.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
        
        _fourYuYueViewController.delegate = self;
        
        
        
    }
    
    return  _fourYuYueViewController;
    
}

#pragma mark - 派工中
-(ThirdYuYueViewController*)thirdYuYueViewController
{
    if (!_thirdYuYueViewController) {
        
        _thirdYuYueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdYuYueViewController"];
        
        _thirdYuYueViewController.view.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
        
        _thirdYuYueViewController.delegate =self;
        
        
    }
    
    return _thirdYuYueViewController;
    
}



#pragma mark -派工
-(TwoViewController*)twoViewController
{
    if (!_twoViewController) {
        
        
        _twoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TwoViewController"];
        
        _twoViewController.view.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
        
        _twoViewController.delegate = self;
        
        
        
    }
    
    return _twoViewController;
}

#pragma mark - 预约确认界面
-(OneYuyueViewController*)oneYuyueViewController
{
    if (!_oneYuyueViewController) {
        
        _oneYuyueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OneYuyueViewController"];
        
        _oneYuyueViewController.view.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height);
        
        _oneYuyueViewController.delegate = self;
        
        
    }
    
    
    return _oneYuyueViewController;
    
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
        
        cell.namecarnumLabel.text = [NSString stringWithFormat:@"%@   %@",model.usermodel.nickname,model.car_plate_num];
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[model.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
        
        NSMutableString *service_str = [[NSMutableString alloc]init];
        
        for (int i = 0; i < model.services.count; i++) {
            
            NSDictionary *service = [model.services objectAtIndex:i];
            
            NSString *servicename = [service objectForKey:@"name"];
            
            if (service_str.length == 0) {
                
                [service_str appendString:servicename];
            }
            else
            {
                [service_str appendFormat:@"\n \n%@",servicename];
                
            }
            
            

        }
        
        cell.serivceviewheight.constant = 50 *model.services.count;
        cell.serviceLabelHeigh.constant = 50*model.services.count;
        
        
        cell.timeLabel.text = model.order_time;
        
        cell.serviceLabel.text = service_str;
        
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
    
    return 0;
    
//    if (section == _myYuyueArray.count -1) {
//        
//        return 0;
//        
//    }
//    return  5;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView*blankView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    
    blankView.backgroundColor = kBackgroundColor;
    

    return blankView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderModel *model = [_myYuyueArray objectAtIndex:indexPath.section];
    
    return 150 + 40 *model.services.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (_myYuyueArray.count > indexPath.section) {
        
        [self setorderview:indexPath.section];
        
        

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

#pragma mark - setorderview
-(void)setorderview:(NSInteger)section
{
    
      selectedIndexSection = section;
    
    OrderModel *model = [_myYuyueArray objectAtIndex:section];
    
    for (UIView *view in _rightView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    switch (model.status) {
        case 1: //预约中
        {
            self.oneYuyueViewController.ordermodel = model;
            
            [self.rightView addSubview:self.oneYuyueViewController.view];
        }
            break;
        case 2://预约确认
        {
            self.oneYuyueViewController.ordermodel = model;
            self.oneYuyueViewController.superViewController = self.superViewController;
            
            [self.rightView addSubview:self.oneYuyueViewController.view];
            
        }
            break;
        case 3: //派工中
        {
            self.twoViewController.orderModel = model;
            
            self.twoViewController.delegate = self;
            
            [self.rightView addSubview:self.twoViewController.view];
            
            
        }
            break;
        case 4: //服务中
        {
            self.thirdYuYueViewController.orderModel = model;
            
            self.thirdYuYueViewController.superViewController = self.superViewController;
            
            
            [self.rightView addSubview:self.thirdYuYueViewController.view];
            
            
            
        }
            break;
        case 5: //服务结束
        {
            self.fourYuYueViewController.orderModel = model;
            
            [self.thirdYuYueViewController.view removeFromSuperview];
            
            [self.rightView addSubview:self.fourYuYueViewController.view];
        }
            break;
        case 6: //  - 待支付
        {
            self.fiveYuYueViewController.orderModel = model;
            
            
            [self.rightView addSubview:self.fiveYuYueViewController.view];
        }
            break;
        case 7:
        {
            self.fiveYuYueViewController.orderModel = model;
            
            
            [self.rightView addSubview:self.fiveYuYueViewController.view];
        }
            break;
        case 8: //完全结束
        {
            self.fiveYuYueViewController.orderModel = model;
            
            
            [self.rightView addSubview:self.fiveYuYueViewController.view];
        }
            break;
        case 9: //异常支付
        {
            self.fiveYuYueViewController.orderModel = model;
            
            
            [self.rightView addSubview:self.fiveYuYueViewController.view];
        }
            break;
        case 10: //订单取消
        {
            self.fiveYuYueViewController.orderModel = model;
            
            
            [self.rightView addSubview:self.fiveYuYueViewController.view];
        }
            break;
            
            
            
        default:
            break;
    }
}

#pragma mark - OneYuyueDelegate
-(void)didSelectedCarCheck:(OrderModel*)ordermodel
{
    

    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]init];
    
    [mudict setObject:@(ordermodel.store_id) forKey:@"store_id"];
    [mudict setObject:@(ordermodel.user_id) forKey:@"user_id"];
    [mudict setObject:@(ordermodel.id) forKey:@"service_order_id"];
    [mudict setObject:@(ordermodel.car_id) forKey:@"user_car_id"];
    
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:mudict forKey:kOrderInfo];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"CarCheckNav"];
    
    [self.superViewController presentViewController:nav animated:YES completion:nil];
    
    
}



#pragma mark -  预约确认 或者 开始派工
-(void)startSendWorders:(OrderModel*)model
{
    
    if (model.status == 1) //预约中  确认预约
    {
        
        [self checkappoint:model];
        
    }
    else if (model.status == 2) //预约确认 开始派工
    {
        
        [self startSend:model];
        
        
    }

}

#pragma mark - 开始派工
-(void)startSend:(OrderModel*)model
{
    
    [[NetWorking shareNetWorking] RequestWithAction:kCheckappoint Params:@{@"order_id":@(model.id),@"status":@(3)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            
            for (int i = 0; i < _myYuyueArray.count; i++) {
                
                OrderModel *temmodel = [_myYuyueArray objectAtIndex:i];
                
                if (temmodel.id == model.id) {
                    
                    
                    temmodel.status = 3;
                    
                    temmodel.status_str = @"派工中";
                    
                    [_myYuyueArray replaceObjectAtIndex:i withObject:temmodel];
                    
                    [_leftTableView reloadData];
                    
                    
                }
            }
            
            
            
            
            model.status_str = @"派工中";
            model.status = 3;
            
            self.twoViewController.delegate = self;
            
            self.twoViewController.orderModel = model;
            
            [self.oneYuyueViewController.view removeFromSuperview];
            
            [self.rightView addSubview:self.twoViewController.view];
            
            
            
        }
        
    }];
    
    
    
   
}

#pragma mark - 确认预约
-(void)checkappoint:(OrderModel*)model
{

    [[NetWorking shareNetWorking] RequestWithAction:kCheckappoint Params:@{@"order_id":@(model.id),@"status":@(2)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            
            for (int i = 0; i < _myYuyueArray.count; i++) {
                
                OrderModel *temmodel = [_myYuyueArray objectAtIndex:i];
                
                if (temmodel.id == model.id) {
                    
                    
                    temmodel.status = 2;
                    
                    temmodel.status_str = @"预约确认";
                    
                    [_myYuyueArray replaceObjectAtIndex:i withObject:temmodel];
                    
                    [_leftTableView reloadData];
                    
                    
                }
            }
            
            
            
            
            model.status_str = @"预约确认";
            model.status = 2;
            
            self.oneYuyueViewController.superViewController = self.superViewController;
            
            self.oneYuyueViewController.ordermodel = model;
            
            
            
            
        }
        
    }];
}


#pragma mark - 开始派工
-(void)sendworkers:(OrderModel*)ordermodel
{
    
}



#pragma mark -添加服务通知
-(void)addnewservicenotice:(NSNotification*)note
{
    
//    OrderModel *model = [_myYuyueArray objectAtIndex:selectedIndexSection];
//    
//    NSMutableArray *muArray = [[NSMutableArray alloc]init];
//    
//    [muArray addObjectsFromArray:model.services];
//    
//    [muArray addObjectsFromArray:note.object];
//    
//    model.services = muArray;
//    
//    
//    [_myYuyueArray replaceObjectAtIndex:selectedIndexSection withObject:model];
    
    [_leftTableView reloadData];
    
}


#pragma mark - TwoViewDelegate
-(void)didStartService:(OrderModel *)ordermodel
{
    
    self.thirdYuYueViewController.orderModel = ordermodel;
    
    self.thirdYuYueViewController.superViewController = self.superViewController;
    
    [self.twoViewController.view removeFromSuperview];
    
    [self.rightView addSubview:self.thirdYuYueViewController.view];
    
    
    [_leftTableView reloadData];
    
    
}


#pragma mark - ThirdViewDelegate
-(void)didDoneService:(OrderModel *)orderModel
{
  
    
    self.fourYuYueViewController.orderModel = orderModel;
    
    [self.thirdYuYueViewController.view removeFromSuperview];
    
    [self.rightView addSubview:self.fourYuYueViewController.view];
    
    
    [_leftTableView reloadData];
    
}


#pragma mark - FourYuYueDelegate
-(void)didSummitOrder:(OrderModel *)orderModel
{
    self.fiveYuYueViewController.orderModel = orderModel;
    
    [self.fourYuYueViewController.view removeFromSuperview];
    
    [self.rightView addSubview:self.fiveYuYueViewController.view];
    
    [_leftTableView reloadData];
    
    
}


#pragma mark - 抢单成功
-(void)catchOrderSucces:(NSNotification*)note
{
    
    NSMutableArray *muarray = [[NSMutableArray alloc]init];
    
    [muarray addObject:note.object];
    [muarray addObjectsFromArray:_myYuyueArray];
    
    _myYuyueArray = muarray;
    
    [_leftTableView reloadData];
    
    [self setorderview:0];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
