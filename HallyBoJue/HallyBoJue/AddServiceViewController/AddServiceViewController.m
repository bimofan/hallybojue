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
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(dismisVC)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getData];
}

-(void)dismisVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
            
            
            _rightServicelist = [[NSMutableArray alloc]init];
            
            [_rightServicelist addObjectsFromArray:[firstcat objectForKey:@"items"]];
            
            _leftSelectedIndex = 0;
            
            
            
            [_firstTableView reloadData];
            [_secondTableView reloadData];
            
            
        }
    }];
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
        
        NSMutableArray *murightArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < _rightServicelist.count; i++) {
            
            NSDictionary *dict = [_rightServicelist objectAtIndex:i];
            
            NSMutableDictionary *muDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
            
            
            if (i == indexPath.section) {
                
                BOOL selected = [[dict objectForKey:@"selected"]boolValue];
                
                [muDict setObject:@(!selected) forKey:@"selected"];
                
            }
            
            [murightArray addObject:muDict];
            
         }
        
        _rightServicelist = murightArray;
        
        
          NSDictionary *dict = [_rightServicelist objectAtIndex:indexPath.section];
        
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
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
