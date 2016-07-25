//
//  PushHistoryViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/25.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "PushHistoryViewController.h"
#import "PushHistoryCell.h"
#import "BlankCell.h"

@interface PushHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSInteger pageSize;
    
}

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation PushHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    _headImageView.clipsToBounds= YES;
    _headImageView.layer.cornerRadius  = _headImageView.frame.size.width/2;

    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _historyTableView.delegate = self;
    _historyTableView.dataSource = self;
    
    page = 1;
    pageSize = 15;
    
    [_historyTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [_historyTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    
}

-(void)headerRefresh
{
    page = 1;
    
    [self getData];
}

-(void)footerRefresh
{
    page ++;
    
    [self getData];
    
}

-(void)setCUserModel:(CUserModel *)cUserModel
{
    
    
    _cUserModel = cUserModel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_cUserModel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    _nameLabel.text = _cUserModel.nickname;
    _vipNameLabel.text = _cUserModel.level_name;
    _vipAddressLabel.text = _cUserModel.vip_address;
    

    [_dataSource removeAllObjects];
    
    [_historyTableView reloadData];
    
    
    [_historyTableView.header beginRefreshing];
    
   
    
    
    
    
    
}

-(void)getData
{
    
    NSString *user_id = _cUserModel.user_id;
    
    int keeper_id = [UserInfo getkeeperid];
    
    
    [[NetWorking shareNetWorking]RequestWithAction:kPushHistorey Params:@{@"user_id":user_id,@"keeper_id":@(keeper_id),@"page":@(page),@"pagesize":@(pageSize)} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        [_historyTableView.footer endRefreshing];
        [_historyTableView.header endRefreshing];
        
        if (isSuccess) {
            
            if (page == 1) {
                
                _dataSource = [[NSMutableArray alloc]init];
                
                
            }
            
            DataModel *model = (DataModel*)data;
            
            
            [_dataSource addObjectsFromArray:model.items];
            
            
            if (page >= model.totalpage) {
                
                [_historyTableView.footer noticeNoMoreData];
            }
            else
            {
                [_historyTableView.footer resetNoMoreData];
                
                
            }
            
            [_historyTableView reloadData];
            
            
           
            
            
        }
    }];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 1;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _dataSource.count;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataSource.count == 0) {
        
        
        BlankCell *_blankCell = [[[NSBundle mainBundle] loadNibNamed:@"BlankCell" owner:self options:nil]firstObject];
        
        _blankCell.userInteractionEnabled = NO;
        
        return _blankCell;
        
        
    }
    
    
    PushHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PushHistoryCell"];
    
    NSDictionary *onehistory = [_dataSource objectAtIndex:indexPath.section];
    
    NSInteger type = [[onehistory objectForKey:@"type"]integerValue];
    
    if (type == 1) {
        
        
        cell.servviceNameLabel.text =  [NSString stringWithFormat:@"推荐的服务:%@",[onehistory objectForKey:@"title"]];
        
        cell.conentLabel.text = [onehistory objectForKey:@"content"];
        
        cell.carLabel.text = [NSString stringWithFormat:@"服务车辆:%@   %@",[onehistory objectForKey:@"brand_name"],[onehistory objectForKey:@"plate_number"]];
        
        
        
    }
    else
    {
        
        cell.servviceNameLabel.text =  @"未推荐服务";
        
        cell.conentLabel.text = [onehistory objectForKey:@"content"];
        
        cell.carLabel.text = [NSString stringWithFormat:@"服务车辆:%@   %@",[onehistory objectForKey:@"brand_name"],[onehistory objectForKey:@"plate_number"]];
        
    }
    
    cell.timeLabel.text = [onehistory objectForKey:@"add_time"];
    
    return cell;
    
    
}


@end
