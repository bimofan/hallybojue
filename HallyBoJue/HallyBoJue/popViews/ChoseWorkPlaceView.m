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
    
    
    self.alpha = 1;
   
  
    if (_workDataSource.count == 0)
    {
        
           [self getdata];
    }
    else
    {
        [_workTableView reloadData];
        
    }
 
    

    
    
}

-(void)getdata
{
    [[NetWorking shareNetWorking] RequestWithAction:kWorkList Params:nil itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
           
            DataModel*dataModel = (DataModel*)data;
            
            _workDataSource = dataModel.items;
            
            
            [_workTableView reloadData];
            
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
    
    
    cell.textLabel.text = [dict objectForKey:@"name"];
    
    if (_hadSeletedItems.count > 0 && _selectedIndex == indexPath.section) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    
    return 0;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    
    label.textColor = kDarkTextColor;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    
    label.text = @"工位选择";
    
    return label;
    
    
}
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
    
    
    _selectedIndex = indexPath.section;
    
    
    if ([self.delegate respondsToSelector:@selector(didChoseItems:)]) {
        
        
        
        [self.delegate didChoseItems: [_workDataSource objectAtIndex:indexPath.section]];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
