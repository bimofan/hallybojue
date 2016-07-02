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



@interface FirstPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *yuyueArray;


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

}

-(void)firstFooterRefresh
{
    
}

-(void)endFirstHeaderRefresh
{
     [_leftTableView.header endRefreshing];
}
-(void)endHeaderRefresh
{
    [_leftTableView.footer endRefreshing];
}

#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _leftTableView) {
        
        FirstLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstLeftCell"];
        
        

        
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
        
        return 3;
    }
    else
    {
        return 3;
        
    }
    
    return self.yuyueArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  5;
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





@end
