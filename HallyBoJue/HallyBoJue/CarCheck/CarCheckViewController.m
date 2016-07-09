//
//  CarCheckViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/9.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "CarCheckViewController.h"

@interface CarCheckViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) NSMutableArray *leftDataArray;
@property (nonatomic,strong) NSMutableArray *rightDataArray;

@property (nonatomic,assign) NSInteger leftSelectedindex;
@property (nonatomic,assign) NSInteger rightSelectedindex;



@end

@implementation CarCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *dismisButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismisactin)];
    
    self.navigationItem.leftBarButtonItem = dismisButton;
    
    
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    _secondTableView.delegate = self;
    _secondTableView.dataSource =self;
    
    [self getchecklist];
    
    
    
}


-(void)getchecklist
{
    [[NetWorking shareNetWorking] RequestWithAction:kChecklist Params:nil itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            DataModel *datamodel = (DataModel*)data;
            
            _leftDataArray = [[NSMutableArray alloc]init];
            
            [_leftDataArray addObjectsFromArray:datamodel.items];
            
            
            NSMutableArray *temleftArray = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < _leftDataArray.count; i++) {
                
                NSDictionary *dict = [_leftDataArray objectAtIndex:i];
                
                NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
                
                [mudict setObject:@(0) forKey:@"seleted"];
                
            
                
                NSArray *subchecks = [dict objectForKey:@"subchecks"];
                
                NSMutableArray *musubchecks = [[NSMutableArray alloc]init];
                
                for (int d = 0; d < subchecks.count; d++) {
                    
                    NSDictionary *subdict = [subchecks objectAtIndex:d];
                    
                    NSMutableDictionary *musubdict = [[NSMutableDictionary alloc]initWithDictionary:subdict];
                    
                    [musubdict setObject:@(0) forKey:@"selected"];
                    
                    [musubchecks addObject:musubdict];
                    
                }
                
                
                [mudict setObject:musubchecks forKey:@"subchecks"];
                
                
                [temleftArray addObject:mudict];
                
            
                
            }
            
            _leftDataArray = temleftArray;
            
            
            
            
            _leftSelectedindex = 0;
            
            [_firstTableView reloadData];
            
            NSDictionary *first = [_leftDataArray firstObject];
            
            
            _rightDataArray = [[NSMutableArray alloc]init];
            
            [_rightDataArray addObjectsFromArray:[first objectForKey:@"subchecks"]];
            
        
            
            [_secondTableView reloadData];
            
            
            
        }
        
    }];
}



#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    return view;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _firstTableView) {
        
        return  _leftDataArray.count;
    
    }
    else if (tableView == _secondTableView)
    {
        return _rightDataArray.count;
    }
    else
    {
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (!cell) {
        
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    if (tableView == _firstTableView) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        if (_leftDataArray.count > indexPath.section) {
            
            NSDictionary *dict = [_leftDataArray objectAtIndex:indexPath.section];
            
            cell.textLabel.text = [dict objectForKey:@"desc"];
            
            
        }
        
        
        
        //选中背景颜色
        if (indexPath.section == _leftSelectedindex) {
            
            cell.backgroundColor = kLightBlueColor;
            
            cell.textLabel.textColor = [UIColor whiteColor];
            
        }
        else
        {
            cell.backgroundColor = [UIColor whiteColor];
            
            cell.textLabel.textColor = kDarkTextColor;
            
            
            
        }
        
        
        
        
    }
    
    else if (tableView == _secondTableView)
    {
        
        if (_rightDataArray.count > indexPath.section) {
           
            
            NSDictionary *dict = [_rightDataArray objectAtIndex:indexPath.section];
            
            cell.textLabel.text = [dict objectForKey:@"desc"];
            
            
             cell.textLabel.textColor = kDarkTextColor;
            
            BOOL selected = [[dict objectForKey:@"selected"]boolValue];
            
            if (selected) {
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            
        }
        
    }
    else
    {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _firstTableView) {
        
        
        NSDictionary *dict = [_leftDataArray objectAtIndex:indexPath.section];
        
        _rightDataArray  = [dict objectForKey:@"subchecks"];
        
        [_secondTableView reloadData];
        
        
        
        _leftSelectedindex = indexPath.section;
        
        [_firstTableView reloadData];
        
        
    }
    
    if (tableView == _secondTableView) {
        
        NSDictionary *dict = [_rightDataArray objectAtIndex:indexPath.section];
        
        NSMutableDictionary *mudict = [[ NSMutableDictionary alloc]initWithDictionary:dict];
        
        BOOL selected = [[mudict objectForKey:@"selected"]boolValue];
     
        
        [mudict setObject:@(!selected) forKey:@"selected"];
        
        
        [_rightDataArray replaceObjectAtIndex:indexPath.section withObject:mudict];
        
        [_secondTableView reloadData];
        
        
        NSDictionary *leftdict = [_leftDataArray objectAtIndex:_leftSelectedindex];
        
        NSMutableDictionary *muleftdict = [[NSMutableDictionary alloc]initWithDictionary:leftdict];
        
        [muleftdict setObject:_rightDataArray forKey:@"subchecks"];
        
        
        
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (IBAction)photoAction:(id)sender {
    
    
    
}

-(void)dismisactin
{
     [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)summitAction:(id)sender {
    
    
    
}
@end
