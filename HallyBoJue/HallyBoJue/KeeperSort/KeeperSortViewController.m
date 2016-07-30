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
#import "BlankCell.h"

@interface KeeperSortViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *firstTableView;
@property (nonatomic,strong) UITableView *secondTableView;
@property (nonatomic,strong) UITableView *thirdTableView;
@property (nonatomic,assign) CGFloat tableWidth;
@property (nonatomic,assign) CGFloat tableHeight;
@property (nonatomic,strong) NSArray *money_today;
@property (nonatomic,strong) NSArray *money_month;
@property (nonatomic,strong) NSArray *users_today;



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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateKeeperRankNoti object:nil];
    
    [self getranklist];
    

}


-(void)getranklist
{
    [[NetWorking shareNetWorking] RequestWithAction:kRankList Params:nil itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                
                _money_today = [data objectForKey:@"today"];
                _money_month  = [data objectForKey:@"month"];
                _users_today = [data objectForKey:@"newuser_today"];
                
                [_firstTableView reloadData];
                [_secondTableView reloadData];
                [_thirdTableView reloadData];
                
            }
        }
    }];
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
    if (tableView == _firstTableView) {
        
        if (_money_today.count == 0) {
            
            return 1;
            
        }
        return _money_today.count;
    }
    if (tableView == _secondTableView) {
        
        if (_users_today.count == 0) {
            return 1;
            
        }
        
        return _users_today.count;
    }
    
    if (tableView == _thirdTableView) {
        
        if (_money_month.count == 0) {
            
            return 1;
            
        }
        
        return _money_month.count;
        
    }
    
    return 0;
    
  
    
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
    
    NSDictionary *dict = nil;
    
    
    if (tableView == _firstTableView) {
        
        
        if (_money_today.count == 0) {
            
            
            BlankCell *_blankCell = [[[NSBundle mainBundle] loadNibNamed:@"BlankCell" owner:self options:nil]firstObject];
            
            return _blankCell;
            
            
            
        }
        
        
        dict = [_money_today objectAtIndex:indexPath.row];
        
        
        cell.moneyLabel.text = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"order_old_amount"]];
        

    }
    else if (tableView == _secondTableView)
    {
        
        if (_users_today.count == 0) {
            
            
            BlankCell *_blankCell = [[[NSBundle mainBundle] loadNibNamed:@"BlankCell" owner:self options:nil]firstObject];
            
            return _blankCell;
            
            
            
        }
        dict = [_users_today objectAtIndex:indexPath.row];
        
        cell.moneyLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"countuser"]];
        
    }
    else if (tableView == _thirdTableView)
    {
        
        if (_money_month.count == 0) {
            
            
            BlankCell *_blankCell = [[[NSBundle mainBundle] loadNibNamed:@"BlankCell" owner:self options:nil]firstObject];
            
            return _blankCell;
            
            
            
        }
        
        
        
        dict = [_money_month objectAtIndex:indexPath.row];
        
        
        cell.moneyLabel.text = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"sum"]];
        
    }
    
    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[[dict objectForKey:@"avatar"]objectForKey:@
                                            "origin"]] placeholderImage:kDefaultHeadImage];
    
    cell.keeperNameLabel.text = [dict objectForKey:@"real_name"];
    
    cell.keeperLevelLabel.text = [dict objectForKey:@"level_name"];
    
    cell.moneyLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    return cell;
}



@end
