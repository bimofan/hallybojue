//
//  AddServiceViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/13.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "AddServiceViewController.h"
#import "NetWorking.h"
#import "Constants.h"
#import "DataModel.h"
#import "AddServiceThirdCell.h"



@interface AddServiceViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) NSMutableArray *serviceslist;
@property (nonatomic,strong) NSMutableArray *rightServicelist;
@property (nonatomic,strong) NSMutableArray *selecteServicelist;

@property (nonatomic,assign) NSInteger leftSelectedIndex;
@property (nonatomic,assign) NSInteger rightSelectedIndex;




@end

@implementation AddServiceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.title = @"添加服务";
    
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    _secondTableView.delegate = self;
    _secondTableView.dataSource = self;
    
    _thirdTableView.delegate = self;
    _thirdTableView.dataSource = self;
    
    
    
    UIBarButtonItem *dismisButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismisVC)];
    
    self.navigationItem.leftBarButtonItem = dismisButton;
    

        
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(summitData)];
        
        self.navigationItem.rightBarButtonItem = doneButton;
  

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _showType = [[[NSUserDefaults standardUserDefaults] objectForKey:kAddNewServiceType]integerValue];
    
    if (_showType == 2) {
        
        _selecteServicelist = [[NSMutableArray alloc]init];
        
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kAddNewServiceSelectedList];
        
        [_selecteServicelist addObjectsFromArray:array];
        
        
    }
    else if (_showType == 3)
    {
        _selectedService = [[NSUserDefaults standardUserDefaults] objectForKey:kPushServiceSelectedService];
        
        if (_selectedService) {
            
            [_selecteServicelist addObject:_selectedService];
            
        }
        
    }
   
    
    
    [self getData];
}

-(void)dismisVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 提交数据
-(void)summitData
{
    if (_selecteServicelist.count ==0) {
        
        [CommonMethods showDefaultErrorString:@"请选择服务"];
        
        return;
    }
    
    

    if (_showType == 1) {
        
        [self addmoreservice];
        
    }
    
    else if (_showType == 2)
    {
        [self addnewservice];
        
    }
    else if(_showType == 3)
    {
        
        [self addPushService];
        
    }

    
    
}

-(void)addPushService
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kPushServiceSelectedNoti object:_selectedService];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)addnewservice
{

    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddServieNotice object:_selecteServicelist];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}


-(void)addmoreservice
{
    
    NSDictionary *orderinfo = [[NSUserDefaults standardUserDefaults] objectForKey:kOrderInfo];
    
    
    NSMutableArray *noticearray = [[NSMutableArray array]init];
    
    NSMutableArray *summitArray = [[NSMutableArray alloc]init];
    
    
    int order_id = [[orderinfo objectForKey:@"service_order_id"]intValue];
    
    
    for (int i = 0; i < _selecteServicelist.count; i++) {
        
        NSDictionary *selectedDict = [_selecteServicelist objectAtIndex:i];
        
        int service_id = [[selectedDict objectForKey:@"id"]intValue];
        
        NSMutableDictionary *mudict = [[NSMutableDictionary alloc]init];
        
        [mudict setObject:@(service_id) forKey:@"service_id"];
        [mudict setObject:@(order_id) forKey:@"order_id"];
        
        [summitArray addObject:mudict];
        
        
        NSMutableDictionary *munotidict = [[NSMutableDictionary alloc]init];
        
        [munotidict setObject:@(service_id) forKey:@"id"];
        
        NSString *name = [selectedDict objectForKey:@"name"];
        
        [munotidict setObject:name forKey:@"name"];
        NSString * price = [selectedDict objectForKey:@"price"];
        
        [munotidict setObject:price forKey:@"price"];
        
        int category_id = [[selectedDict objectForKey:@"category_id"]intValue];
        
        [munotidict setObject:@(category_id) forKey:@"category_id"];
        
        [noticearray addObject:munotidict];
        
        
    }
    
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddServieNotice object:noticearray];
    
    
    
    //提交数据
    NSData *summitData = [NSJSONSerialization dataWithJSONObject:summitArray options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *summitString = [[NSString alloc]initWithData:summitData encoding:NSUTF8StringEncoding];
    
    NSDictionary *params = @{@"services":summitString};
    
    [[NetWorking shareNetWorking] RequestWithAction:kAddService Params:params itemModel:nil result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"服务提交成功"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }];
}

-(void)getData
{
    [[NetWorking shareNetWorking] RequestWithAction:kServiceList Params:nil itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            DataModel *model = (DataModel*)data;
            
            _serviceslist = [[NSMutableArray alloc]init];
            
            [_serviceslist addObjectsFromArray:model.items];
            
            
            NSDictionary *firstcat = [_serviceslist firstObject];
            
            NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:firstcat];
            
            [mudict setObject:@(1) forKey:@"selected"];
            
            [_serviceslist replaceObjectAtIndex:0 withObject:mudict];
            
            _selectedLeftDict = firstcat;
            

            
            _leftSelectedIndex = 0;
            
            if (_showType == 2) {
                
                  [self sortRightSelected];
                
                
            }
            else if (_showType == 1 )
            {
                
                _rightServicelist = [[NSMutableArray alloc]init];
                
                [_rightServicelist addObjectsFromArray:[firstcat objectForKey:@"items"]];
                
                [_firstTableView reloadData];
                [_secondTableView reloadData];
            }
            else if (_showType == 3)
            {
              
                [self sortShowTypeThirdData];
                
            }
     
    
            
      
            
            
        }
    }];
}

#pragma mark - _showType == 3 sortdata
-(void)sortShowTypeThirdData
{
    for (int i = 0 ; i <_serviceslist.count ; i++) {
        
        NSDictionary *temleftDict = [_serviceslist objectAtIndex:i];
        
        NSMutableDictionary *mutemleftDict = [[NSMutableDictionary alloc]initWithDictionary:temleftDict];
        
        NSString *category_name = [mutemleftDict objectForKey:@"category_name"];
        
        NSArray *items = [temleftDict objectForKey:@"items"];
        
        NSMutableArray *muitems = [[NSMutableArray alloc]init];
        
        [muitems addObjectsFromArray:items];
        
        for (int d = 0;  d < muitems.count; d++) {
            
            NSDictionary *temrightdict = [muitems objectAtIndex:d];
            NSMutableDictionary *mutemrightdict = [[NSMutableDictionary alloc]initWithDictionary:temrightdict];
            
            [mutemrightdict setObject:category_name forKey:@"category_name"];
            
            [muitems replaceObjectAtIndex:d withObject:mutemrightdict];
            
        }
        
        [mutemleftDict setObject:muitems forKey:@"items"];
        
        [_serviceslist replaceObjectAtIndex:i withObject:mutemleftDict];
        
    }
    
    NSDictionary *firstcat = [_serviceslist firstObject];
    
    _rightServicelist = [[NSMutableArray alloc]init];
    
    [_rightServicelist addObjectsFromArray:[firstcat objectForKey:@"items"]];
    
    
    [_firstTableView reloadData];
    [_secondTableView reloadData];
    
}


#pragma mark - _showType ==2 sort right selected
-(void)sortRightSelected
{
    
    
         NSLog(@"_serviceslist:%@",_serviceslist);
    
    for (int d = 0; d < _selecteServicelist.count; d++) {
        
        NSDictionary *dict = [_selecteServicelist objectAtIndex:d];
        
        int temcategory_id = [[dict objectForKey:@"category_id"]intValue];
        
        int temservice_id = [[dict objectForKey:@"id"]intValue];
        
        for (int i = 0; i < _serviceslist.count; i ++) {
            
            NSDictionary *leftDict = [_serviceslist objectAtIndex:i];
            
       
            
            NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:leftDict];
            
            int category_id = [[mudict objectForKey:@"id"]intValue];
            
            
            NSArray *rightitems = [mudict objectForKey:@"items"];
            
            NSMutableArray *murightitems = [[NSMutableArray alloc]init];
            [murightitems addObjectsFromArray:rightitems];
            
            if (category_id == temcategory_id) {
                
                for (int h = 0; h < rightitems.count; h++) {
                    
                    NSDictionary *itemDict = [rightitems objectAtIndex:h];
                    
                    NSMutableDictionary *muitemdict = [[NSMutableDictionary alloc]initWithDictionary:itemDict];
                    
                    int service_id = [[muitemdict objectForKey:@"id"]intValue];
                    
                    if (service_id == temservice_id) {
                        
                        [muitemdict setObject:@(1) forKey:@"selected"];
                        
                        [murightitems replaceObjectAtIndex:h withObject:muitemdict];
                    }
                }
                
             }
            
            [mudict setObject:murightitems forKey:@"items"];
            
            
            
            [_serviceslist replaceObjectAtIndex:i withObject:mudict];
//            
        
            
        }
        
    
        
    }
    
    
    
        NSDictionary *firstcat = [_serviceslist firstObject];
    
    _rightServicelist = [[NSMutableArray alloc]init];
    
    [_rightServicelist addObjectsFromArray:[firstcat objectForKey:@"items"]];
    
    [_firstTableView reloadData];
    [_secondTableView reloadData];
    
    
    

}

#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    view.backgroundColor = kBackgroundColor;
    
    
    return view;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _firstTableView) {
        
        return 50;
    }
    else if (tableView == _secondTableView)
    {
        return 50;
    }
    else
    {
        return 80;
        
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _firstTableView) {
        
        return _serviceslist.count;
    }
    else if (tableView == _secondTableView)
    {
        return _rightServicelist.count;
    }
    else
    {
        return _selecteServicelist.count;
        
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (tableView == _firstTableView) {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
            

        }
        
        NSDictionary *firstdict  = [_serviceslist objectAtIndex:indexPath.section];
        
        BOOL selected = [[firstdict objectForKey:@"selected"]boolValue];
        
        if (selected) {
            
            cell.backgroundColor = kLightBlueColor;
            
            cell.textLabel.textColor = [UIColor whiteColor];
            
        }
        else
        {
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = kDarkTextColor;
            
            
        }
        
        cell.textLabel.text = [firstdict objectForKey:@"category_name"];
        
        
        
        
        return cell;
        
    }
    
    else if (tableView == _secondTableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondCell"];
            
 
            
        }
        
        NSDictionary *second  = [_rightServicelist objectAtIndex:indexPath.section];
        
        BOOL selected = [[second objectForKey:@"selected"]boolValue];
        
        if (selected) {
            
              cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }
        else
        {
              cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        
        cell.textLabel.text = [second objectForKey:@"name"];
        
        
        
        return cell;
    }
    
    else
    {
        
        AddServiceThirdCell  *thirdCell = [tableView dequeueReusableCellWithIdentifier:@"AddServiceThirdCell"];
        
        
        NSDictionary *dict = [_selecteServicelist objectAtIndex:indexPath.section];
        
        thirdCell.serviceNameLabel.text =  [NSString stringWithFormat:@"%@-%@",[dict objectForKey:@"category_name"],[dict objectForKey:@"name"]];
        
        thirdCell.servicePriceLabel.text = [NSString stringWithFormat:@"%@元",[dict objectForKey:@"price"]];
        
        return thirdCell;
        
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == _firstTableView) {
        
     
        _leftSelectedIndex = indexPath.section;
        
        
        NSMutableArray *muArray = [[NSMutableArray alloc]init];
        
        
        for (int i = 0; i < _serviceslist.count; i++) {
            
            NSDictionary *dict = [_serviceslist objectAtIndex:i];
            
            NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
            
            if (i == indexPath.section) {
                
                [mudict setObject:@(1) forKey:@"selected"];
                
                _rightServicelist = [[NSMutableArray alloc]init];
                
                
                [_rightServicelist addObjectsFromArray:[mudict objectForKey:@"items"]];
                
                
                
            }
            else
            {
                [mudict setObject:@(0) forKey:@"selected"];
                
            }
            
            [muArray addObject:mudict];
            
        }
        
        
        _serviceslist = muArray;
        
        [_firstTableView reloadData];
        
        [_secondTableView reloadData];
        
        
        
        
    }
    
    
    if (_secondTableView == tableView) {
        

        if (_showType == 1  ||_showType == 2) {
            
            [self mutilSelected:indexPath.section];
            
        }
        
        if (_showType == 3) {
            
            [self singleSelected:indexPath.section];
            
        }
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 单选
-(void)singleSelected:(NSInteger)index
{
    
    _selectedService = [_rightServicelist objectAtIndex:index];
    
    for (int i = 0; i < _rightServicelist.count; i++) {
        
        NSDictionary *dict = [_rightServicelist objectAtIndex:i];
        
        NSMutableDictionary *muDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
        
      
        
        int service_id = [[muDict objectForKey:@"id"]intValue];
        
        int selected_id = [[_selectedService objectForKey:@"id"]intValue];
        
        if (service_id == selected_id) {
            
            [muDict setObject:@(1) forKey:@"selected"];
        }
        else
        {
            [muDict setObject:@(0) forKey:@"selected"];
            
        }
        
        [_rightServicelist replaceObjectAtIndex:i withObject:muDict];
        
    }
    
    
    _selecteServicelist = [[NSMutableArray array]init];
    
    
    [_selecteServicelist addObject:_selectedService];
    
    [_secondTableView reloadData];
    
    [_thirdTableView reloadData];
    
    
    
    
}

#pragma mark - 多选
-(void)mutilSelected:(NSInteger)index
{
    NSMutableArray *murightArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _rightServicelist.count; i++) {
        
        NSDictionary *dict = [_rightServicelist objectAtIndex:i];
        
        NSMutableDictionary *muDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
        
        
        if (i == index) {
            
            BOOL selected = [[dict objectForKey:@"selected"]boolValue];
            
            [muDict setObject:@(!selected) forKey:@"selected"];
            
        }
        
        [murightArray addObject:muDict];
        
    }
    
    _rightServicelist = murightArray;
    
    
    NSDictionary *dict = [_rightServicelist objectAtIndex:index];
    
    NSInteger category_id = [[dict objectForKey:@"category_id"]integerValue];
    
    NSMutableArray *muservicelist = [[NSMutableArray alloc]init];
    [muservicelist addObjectsFromArray:_serviceslist];
    
    for (int i = 0; i < muservicelist.count; i++) {
        
        NSDictionary *leftdict = [muservicelist objectAtIndex:i];
        
        NSInteger id = [[leftdict objectForKey:@"id"]integerValue];
        
        if (id == category_id) {
            
            NSMutableDictionary *muleftDict = [[NSMutableDictionary alloc]init];
            
            NSString *category_name = [leftdict objectForKey:@"category_name"];
            int cate_id = [[leftdict objectForKey:@"id"]intValue];
            
            
            [muleftDict setObject:category_name forKey:@"category_name"];
            [muleftDict setObject:@(cate_id) forKey:@"id"];
            
            [muleftDict setObject:_rightServicelist forKey:@"items"];
            
            
            [muservicelist replaceObjectAtIndex:i withObject:muleftDict];
            
            
        }
        
    }
    
    _serviceslist = muservicelist;
    
    
    
    
    [self sortSelectedData];
    
    [_secondTableView reloadData];
}


-(void)sortSelectedData
{

    
    NSMutableArray *muselectedArray = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < _serviceslist.count; i++) {
        
        NSDictionary *dict = [_serviceslist objectAtIndex:i];
        
        NSString *category_name = [dict objectForKey:@"category_name"]
        ;
       
        NSArray *secondArray = [dict objectForKey:@"items"];
        
        for (int d = 0; d < secondArray.count; d++) {
            
            NSDictionary *secondDict = [secondArray objectAtIndex:d];
            
            BOOL selected = [[secondDict objectForKey:@"selected"]boolValue];
            
            if (selected) {
                
                NSMutableDictionary *mutemDict = [[NSMutableDictionary alloc]initWithDictionary:secondDict];
                
                [mutemDict setObject:category_name forKey:@"category_name"];
                
                [muselectedArray addObject:mutemDict];
                
            }
        }
    }
    
    
    _selecteServicelist = muselectedArray;
    
    
    [_thirdTableView reloadData];
    
    
}


@end
