//
//  HomeViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/1.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeSlideCell.h"
#import "LoginViewController.h"
#import "HomeHeaderView.h"
#import "FirstPageViewController.h"



CGFloat cellHeight = 70;

@interface HomeViewController ()

@property (nonatomic,strong) NSArray *slideTitles;
@property(nonatomic,strong) HomeHeaderView *homeHeaderView;
@property(nonatomic,strong) UIView*selectedBackView;

@property(nonatomic,strong) FirstPageViewController *firstpageController;




@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"哈里伯爵－管家端";
    
    
    _slideTabelView.delegate = self;
    _slideTabelView.dataSource = self;
    _slideTabelView.backgroundColor = kBackgroundColor;
    
    
    [self.headerView addSubview:self.homeHeaderView];
    
    
     [_contentView addSubview:self.firstpageController.view];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:kHadLogin]) {
        
        UINavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
        
        [self presentViewController:loginNav animated:YES completion:nil];
        
        
        
    }
    else
    {
        [self.homeHeaderView setdata];
        
    }
}

-(HomeHeaderView*)homeHeaderView
{
    if (!_homeHeaderView) {
        
        
        NSArray  *apparray= [[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView" owner:nil options:nil];
        
        _homeHeaderView = [apparray firstObject];
      
        
        _homeHeaderView.frame = CGRectMake(0, 0, ScreenWidth, self.headerView.frame.size.height);
        
        
         
        
    }
    
    return _homeHeaderView;
    
}

-(NSArray*)slideTitles
{
    if (!_slideTitles) {
        
        _slideTitles = @[@{@"selected":@(1),@"title":@"首页",@"imageName":@""},@{@"selected":@(0),@"title":@"预约管理"},@{@"selected":@(0),@"title":@"客户管理"},@{@"selected":@(0),@"title":@"跟进管理"},@{@"selected":@(0),@"title":@"排行榜"},@{@"selected":@(0),@"title":@"FAQ"}];
        
        
                                                                                                                                                                                                                  
        
        
        
    }
    
    return _slideTitles;
    
}

#pragma mark － 初始化首页子页面
-(FirstPageViewController*)firstpageController
{
    if (!_firstpageController) {
        
        
        _firstpageController = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstPageViewController"];
        
        _firstpageController.view.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        
       
        
        
    }
    
    return _firstpageController;
    
}


#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSlideCell"];
    
    
    NSDictionary *dict = [_slideTitles objectAtIndex:indexPath.section];
    
    BOOL selected = [[dict objectForKey:@"selected"]boolValue];
    
    cell.titlelabel.text = [dict objectForKey:@"title"];
    
    if (selected) {
        
        cell.backgroundColor = kLightBlueColor;
        cell.titlelabel.textColor = [UIColor whiteColor];
        
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.titlelabel.textColor = kDarkGrayColor;
        
        
    }
    
    

    
    
    
    
    
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.slideTitles.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*blankView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    
    blankView.backgroundColor = [UIColor clearColor];
    
    
    return blankView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    
    
    [self setselected:indexPath.section];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(void)setselected:(NSInteger)section
{
    
    NSMutableArray *muarray = [[NSMutableArray alloc]init];
  
    
    for (int i = 0; i<_slideTitles.count; i++) {
        
        NSDictionary *dict= [ _slideTitles objectAtIndex:i] ;
        
        NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
        
        if (i == section) {
            
            [mudict setObject:@(1) forKey:@"selected"];
        }
        else
        {
            [mudict setObject:@(0) forKey:@"selected"];
        }
        
        [muarray addObject:mudict];
        
        
    }
    
    _slideTitles = muarray;
    

      [_slideTabelView reloadData];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
