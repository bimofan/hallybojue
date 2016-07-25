//
//  ChoseWorkPlaceView.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/11.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ChoseWorkPlaceView.h"
#import "Constants.h"
#import "NetWorking.h"
#import "APIConstants.h"
#import "DataModel.h"
#import "CommonMethods.h"



@implementation ChoseWorkPlaceView


-(void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        
    }];
}
-(void)show
{
    
    self.backgroundColor = kLighGrayBackColor;
    
    UIControl *touchControl = [[UIControl alloc]initWithFrame:self.frame];
    
    touchControl.backgroundColor = kLighGrayBackColor;
    
    [touchControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:touchControl];
    
    
    [self bringSubviewToFront:_backView];
    
    
    
    
    _backView.clipsToBounds = YES;
    _backView.layer.cornerRadius = kCornerRadous;
    
    
    _workTableView.delegate = self;
    _workTableView.dataSource = self;
    
    
    
}
-(void)layoutSubviews
{
    
    
    _okButton.clipsToBounds = YES;
    _okButton.layer.cornerRadius = kCornerRadous;
    _okButton.layer.borderWidth = 1;
    _okButton.layer.borderColor = kBorderColor.CGColor;
    
    self.alpha = 1;
   
  
    if (_workDataSource.count == 0)
    {
        
          [_workTableView reloadData];
        
        if (_type ==1) {
            
             [self getdata];
        }
        else if(_type == 2)
        {
            [self getworkerlist];
            
        }
        else if (_type == 3)
        {
            
        }
        else if (_type == 4)
        {
            
        }
        
    }
    else
    {
        
        if (_type == 1) {
            
            
            [self dealWorkPlace:_workDataSource];
            
            
            
        }
        else if (_type == 2)
        {
            
            
            [self dealWorkersSelected:_workDataSource];
            
            
            
        }
        else if (_type == 3)
        {
            
        }
 
        else if (_type == 4)
        {
            _titleLabel.text = @"选择车辆";
            
            NSMutableArray *muArray  = [[NSMutableArray alloc]init];
            
            [muArray addObjectsFromArray:_workDataSource];
            
            for (int i = 0; i < muArray.count; i++) {
                
                NSDictionary *temdict = [muArray objectAtIndex:i];
                
                NSMutableDictionary *mutemdict = [[NSMutableDictionary alloc]initWithDictionary:temdict];
                
                int tem_id = [[mutemdict objectForKey:@"id"]intValue];
                
                int selected_id = [[_selectedDict objectForKey:@"id"]intValue];
                
                if (tem_id == selected_id ) {
                    
                    
                    BOOL selected = [[mutemdict objectForKey:@"selected"]boolValue];
                    
                    [mutemdict setObject:@(!selected) forKey:@"selected"];
                    
                    
                }
                else
                {
                    [mutemdict setObject:@(0) forKey:@"selected"];
                    
                }
                
                
                [muArray replaceObjectAtIndex:i  withObject:mutemdict];
                
                
             }
            
            
            _workDataSource = muArray;
            
            
        }
        
        [_workTableView reloadData];
        
    }
 
    

    
}


-(void)dealWorkPlace:(NSArray*)workplace
{
    
    NSMutableArray *muarray = [[NSMutableArray alloc]init];
    
    [muarray addObjectsFromArray:workplace];
    
    for (int i = 0 ; i < muarray.count; i++) {
        
        NSDictionary *temDict = [ muarray objectAtIndex:i];
        
        NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:temDict];
        
        int mudict_id = [[mudict objectForKey:@"workplace_id"]intValue];
        
        
        BOOL contented = NO;
        
        for (int d = 0; d < _selectedArray.count; d++) {
            
            NSDictionary *selectDict = [_selectedArray objectAtIndex:d];
            
            int workplace_id = [[selectDict objectForKey:@"workplace_id"]intValue];
            
            
            if (mudict_id == workplace_id) {
                
                contented = YES;
                
                
            }
            
            
        }
        
        if (contented ) {
            
            [mudict setObject:@(1) forKey:@"selected"];
        }
        else
        {
            [mudict setObject:@(0) forKey:@"selected"];
        }
        
        
        [muarray replaceObjectAtIndex:i withObject:mudict];
        
        
        
        
    }
    
    _workDataSource  = muarray;
    
    
    
    [_workTableView reloadData];
    
    
}

-(void)dealWorkersSelected:(NSArray *)workers
{
    NSMutableArray *muArray = [[NSMutableArray alloc]init];
    
    [muArray addObjectsFromArray:workers];
    
    for (int i = 0; i < muArray.count; i++) {
        
        NSDictionary *dict = [muArray objectAtIndex:i];
        
        NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
        
        int worker_id = [[mudict objectForKey:@"worker_id"]intValue];
        
        
        BOOL contented  = NO;
        
        for (int d = 0; d < _selectedArray.count; d++) {
            
            NSDictionary *selectedDict = [_selectedArray objectAtIndex:d];
            
            int selectworder_id = [[selectedDict objectForKey:@"worker_id"]intValue];
            
            if (selectworder_id == worker_id) {
                
                contented = YES;
                
            }
            
        }
        
        if (contented) {
            
            [mudict setObject:@(1) forKey:@"selected"];
        }
        else
        {
            [mudict setObject:@(0) forKey:@"selected"];
        }
        
        
        
        [muArray replaceObjectAtIndex:i withObject:mudict];
        
        
        
        
    }
    
    _workDataSource = muArray;
    
    
    
    [_workTableView reloadData];
}


#pragma mark -工位
-(void)getdata
{
    
    [[NetWorking shareNetWorking] RequestWithAction:kWorkPlaceList Params:@{@"store_id":@(_store_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
           
            DataModel*dataModel = (DataModel*)data;
            
            
            
            [self dealWorkPlace:dataModel.items];
            
  
            
        }
        
    }];
}

#pragma mark -技师
-(void)getworkerlist
{
    [[NetWorking shareNetWorking] RequestWithAction:kWorkerList Params:@{@"store_id":@(_store_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        
        if (isSuccess) {
            
            DataModel*dataModel = (DataModel*)data;
            
    
            
            [self dealWorkersSelected:dataModel.items];
            
            
        
        }
        
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _workDataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        
    }
    
    NSDictionary *dict = [_workDataSource objectAtIndex:indexPath.section];
    
    
    if (_type ==1) {
        
        cell.textLabel.text = [dict objectForKey:@"name"];
        
        if ([[dict objectForKey:@"selected"]boolValue]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
    }

    else if(_type == 2)
    {
        cell.textLabel.text = [dict objectForKey:@"worker_real_name"];
        
        if ([[dict objectForKey:@"selected"]boolValue]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
    }
    else if (_type == 3)
    {
        cell.textLabel.text = [dict objectForKey:@"advise"];
        
        NSInteger advise_id = [[dict objectForKey:@"advise_id"]integerValue];
        
        NSInteger selected_advise_id = [[_selectedDict objectForKey:@"advise_id"]integerValue];
        
    
        if (selected_advise_id == advise_id) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        
    }
    else if (_type == 4)
    {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@   %@",[dict objectForKey:@"brand_name"],[dict objectForKey:@"plate_number"]];
        
        
        if ([[dict objectForKey:@"selected"]boolValue]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
    }
    
    cell.textLabel.font = FONT_14;
    cell.textLabel.textColor = kDarkTextColor;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    
    return 0;
    
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
//    
//    label.textColor = kDarkTextColor;
//    
//    label.textAlignment = NSTextAlignmentCenter;
//    
//    
//    label.text = @"工位选择";
//    
//    return label;
//    
//    
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSMutableArray *muArray = [[NSMutableArray alloc]init];
    
    [muArray addObjectsFromArray:_workDataSource];
    
    NSDictionary *selectedDict = [muArray objectAtIndex:indexPath.section];
    
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:selectedDict];
    
    
    if (_type == 1) {
        
        for (int i = 0; i < muArray.count; i++) {
            
            NSDictionary *temdict = [muArray objectAtIndex:i];
            
            NSMutableDictionary *mutemdict = [[NSMutableDictionary alloc]initWithDictionary:temdict];
            
            if (i == indexPath.section) {
                
                
                BOOL selected = [[mutemdict objectForKey:@"selected"]boolValue];
                
                [mutemdict setObject:@(!selected) forKey:@"selected"];
                
                
            }
            else
            {
                [mutemdict setObject:@(0) forKey:@"selected"];
                
            }
            
            
            [muArray replaceObjectAtIndex:i  withObject:mutemdict];
        
            
        }
        
        
        _workDataSource = muArray;
        
        
    }
    
    else if(_type == 2)
    {
        BOOL selected = [[mudict objectForKey:@"selected"]boolValue];
        
        [mudict setObject:@(!selected) forKey:@"selected"];
        
        [muArray replaceObjectAtIndex:indexPath.section withObject:mudict];
        
        
        _workDataSource = muArray;
    }
    
    else if (_type == 3)
    {
        
        NSInteger advise_id = [[mudict objectForKey:@"advise_id"]integerValue];
        
        NSInteger selected_advise_id = [[_selectedDict objectForKey:@"advise_id"]integerValue];
        
        if (selected_advise_id == advise_id) {
            
            _selectedDict = nil;
        }
        else
        {
            _selectedDict = mudict;
            
            
        }
        
    }
    
    else if (_type == 4)
    {
        for (int i = 0; i < muArray.count; i++) {
            
            NSDictionary *temdict = [muArray objectAtIndex:i];
            
            NSMutableDictionary *mutemdict = [[NSMutableDictionary alloc]initWithDictionary:temdict];
            
            if (i == indexPath.section) {
                
                
                BOOL selected = [[mutemdict objectForKey:@"selected"]boolValue];
                
                [mutemdict setObject:@(!selected) forKey:@"selected"];
                
                
            }
            else
            {
                [mutemdict setObject:@(0) forKey:@"selected"];
                
            }
            
            
            [muArray replaceObjectAtIndex:i  withObject:mutemdict];
            
            
        }
        
        
        _workDataSource = muArray;
    }

    
    
    
    [_workTableView reloadData];
    


    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}






- (IBAction)okAction:(id)sender {
    
    
    
    if ([self.delegate respondsToSelector:@selector(didChoseItems:)]) {
        
        
        
        if (_type == 3) {
            
            if (!_selectedDict) {
                
                [CommonMethods showDefaultErrorString:@"请选择服务建议"];
                
                return;
                
            }
            
            [self.delegate didChoseItems:@[_selectedDict]];
            
        }
        else
        {
            
     
        
        NSMutableArray *selectedItems = [[NSMutableArray alloc]init];
        
        for (int i = 0 ; i < _workDataSource.count; i++) {
            
            NSDictionary *dict = [_workDataSource objectAtIndex:i];
            
            if ([[dict objectForKey:@"selected"]boolValue]) {
                
                [selectedItems addObject:dict];
                
            }
        }
        
        
        
        if (selectedItems.count == 0) {
            
            NSString *alertStr = @"";
            
            if (_type == 1) {
                
                alertStr = @"请选择车位";
                
            }
            else if (_type == 2)
            {
                alertStr = @"请选择技师";
            }
            else if (_type == 3)

            {
                
            }
            else if (_type == 4)
            {
                 alertStr = @"请选择车辆";
            }
            [CommonMethods showDefaultErrorString:alertStr];
            
            return;
            
            
            
        }
        
        
        
        [self.delegate didChoseItems:selectedItems];
            
        
        }
        
        
    }
    
    
    
    [self dismiss];
    
    
}
@end
