//
//  KeeperSortViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "KeeperSortViewController.h"
#import "KeepersortCell.h"
#import "Constants.h"

@interface KeeperSortViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *firstTableView;
@property (nonatomic,strong) UITableView *secondTableView;
@property (nonatomic,strong) UITableView *thirdTableView;
@property (nonatomic,assign) CGFloat tableWidth;
@property (nonatomic,assign) CGFloat tableHeight;


@end

@implementation KeeperSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _tableWidth = (self.view.frame.size.width - 2*kViewOffset)/3.0;
    
    _tableHeight = self.view.frame.size.height;
    
    
    self.firstTableView.clipsToBounds = YES;
    self.firstTableView.layer.cornerRadius = kCornerRadous;
    
    self.secondTableView.clipsToBounds = YES;
    self.secondTableView.layer.cornerRadius = kCornerRadous;
    
    self.thirdTableView.clipsToBounds= YES;
    self.thirdTableView.layer.cornerRadius = kCornerRadous;
    
    
    [self.view addSubview:self.firstTableView];
    
    [self.view addSubview:self.secondTableView];
    [self.view addSubview:self.thirdTableView];
}

-(UITableView*)firstTableView
{
    if (!_firstTableView) {
        
        _firstTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _tableWidth,_tableHeight) style:UITableViewStylePlain];
        
        _firstTableView.delegate = self;
        _firstTableView.dataSource = self;
        _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _firstTableView.backgroundColor = [UIColor whiteColor];
        
        _firstTableView.showsVerticalScrollIndicator = NO;
        
        
       
        
    }
    
    return _firstTableView;
    
}

-(UITableView*)secondTableView
{
    if (!_secondTableView) {
        
        _secondTableView =[[UITableView alloc]initWithFrame:CGRectMake(_tableWidth + kViewOffset, 0, _tableWidth,_tableHeight) style:UITableViewStylePlain];
        
        _secondTableView.delegate =self;
        _secondTableView.dataSource = self;
        
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _secondTableView.backgroundColor = [UIColor whiteColor];
        
        _secondTableView.showsVerticalScrollIndicator = NO;
        
        
    }
    
    return _secondTableView;
    
}

-(UITableView*)thirdTableView
{
    if (!_thirdTableView) {
        
        _thirdTableView = [[UITableView alloc]initWithFrame:CGRectMake(_tableWidth*2 + 2*kViewOffset, 0, _tableWidth,_tableHeight) style:UITableViewStylePlain];
        
        _thirdTableView.delegate = self;
        _thirdTableView.dataSource = self;
        
        _thirdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _thirdTableView.backgroundColor = [UIColor whiteColor];
        
        _thirdTableView.showsVerticalScrollIndicator = NO;
        
        
    }
    
    return _thirdTableView;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, tableView.frame.size.width, 1)];
    line.backgroundColor = kGrayBackColor;
    
  
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    titleLable.text = @"";
    
    titleLable.textColor = kDarkTextColor;
    
    titleLable.font = FONT_17;
    
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    
    if (tableView == _firstTableView) {
        
        titleLable.text = @"今日业绩";
    }
    
    if (tableView == _secondTableView) {
        
        titleLable.text = @"今日新增客户排行";
    }
    
    if (tableView == _thirdTableView) {
        
        titleLable.text = @"本月业绩排行";
    }
    
    
    [headerView addSubview:titleLable];
    
    
    [headerView addSubview:line];
    
    
    return headerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KeepersortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KeepersortCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KeepersortCell" owner:self options:nil]firstObject];
        
        
    }
    
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
    
    
    return cell;
}



@end