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
   
    
    _tableWidth = (self.view.frame.size.width - 2*kViewOffset)/3.0;
    
    _tableHeight = self.view.frame.size.height;
    

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
        
    }
    
    return _thirdTableView;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KeepersortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KeepersortCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KeepersortCell" owner:self options:nil]firstObject];
        
        
    }
    
    
    return cell;
}



@end
