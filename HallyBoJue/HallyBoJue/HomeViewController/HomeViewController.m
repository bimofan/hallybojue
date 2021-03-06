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
#import "YuyueViewController.h"
#import "CustomerViewController.h"
#import "FollowUserController.h"
#import "KeeperSortViewController.h"
#import "FAQViewController.h"
#import "SettingViewController.h"





CGFloat cellHeight = 45;

@interface HomeViewController ()
{
    NSInteger selectedSection;
    
    
    
}

@property (nonatomic,strong) NSArray *slideTitles;
@property(nonatomic,strong) HomeHeaderView *homeHeaderView;
@property(nonatomic,strong) UIView*selectedBackView;
@property (nonatomic,strong) NSDictionary *keeperRankData;
@property (nonatomic,strong) NSDictionary *unreaddict;



@property(nonatomic,strong) FirstPageViewController *firstpageController;
@property(nonatomic,strong) YuyueViewController*yuyuepageController;
@property (nonatomic,strong) CustomerViewController *customerViewController;
@property (nonatomic,strong) FollowUserController *followUserController;
@property (nonatomic,strong) KeeperSortViewController *keeperSortViewController;
@property (nonatomic,strong) FAQViewController *faqViewController;
@property (nonatomic,strong) SettingViewController *settingViewController;










@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"哈里伯爵－管家端";
    
    _slideTabelView.delegate = self;
    _slideTabelView.dataSource = self;

    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"logo"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedAvatar:) name:kChangedAvatarNoti object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successCatchOrder:) name:kSuccesCatchOrder object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKeeperRank) name:kUpdateKeeperRankNoti object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getunreadnumber) name:kHadUpdateFollowNoti object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getunreadnumber) name:kRecevieNewOrderNoti object:nil];
    
    
    
    
    [self.headerView addSubview:self.homeHeaderView];
    
    
     [_contentView addSubview:self.firstpageController.view];
    
    selectedSection = 0;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
  
    


}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:kHadLogin]) {
        
        UINavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
        
        [self presentViewController:loginNav animated:YES completion:nil];
        
        
        
    }
    else
    {
        [self.homeHeaderView setdata];
        
        [self getKeeperRank];
        
        [self getunreadnumber];
        
        
        
        
    }
}


#pragma mark - 获取未读消息数
-(void)getunreadnumber
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin]) {
        
        int keeper_id = [UserInfo getkeeperid];
        int store_id = [UserInfo getstoreid];
        
        [[NetWorking shareNetWorking] RequestWithAction:kUnReadNumber Params:@{@"keeper_id":@(keeper_id),@"store_id":@(store_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
           
            if (isSuccess) {
                
                _unreaddict = data;
                
                [_slideTabelView reloadData];
                
                
            }
        }];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter ]removeObserver:self name:kChangedAvatarNoti object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSuccesCatchOrder object:nil];
    
    
}

-(HomeHeaderView*)homeHeaderView
{
    if (!_homeHeaderView) {
        
        
        NSArray  *apparray= [[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView" owner:nil options:nil];
        
        _homeHeaderView = [apparray firstObject];
      
        
        _homeHeaderView.frame = CGRectMake(0, 0, self.headerView.frame.size.width, self.headerView.frame.size.height);
        
        
         
        
    }
    
    return _homeHeaderView;
    
}

-(NSArray*)slideTitles
{
    if (!_slideTitles) {
        
        _slideTitles = @[@{@"selected":@(1),@"title":@"首页",@"image":@"zhuye2",@"image2":@"zhuye"},@{@"selected":@(0),@"title":@"预约管理",@"image":@"pinglun",@"image2":@"pinglun33"},@{@"selected":@(0),@"title":@"客户管理",@"image":@"kehu2",@"image2":@"kehu"},@{@"selected":@(0),@"title":@"跟进管理",@"image":@"gengjin2",@"image2":@"gengjin"},@{@"selected":@(0),@"title":@"排行榜",@"image":@"paihangbang2",@"image2":@"paihangbang"},@{@"selected":@(0),@"title":@"FAQ",@"image":@"faq2",@"image2":@"faq"},@{@"selected":@(0),@"title":@"设置",@"image":@"shezhi",@"image2":@"shezhi11"}];
        
        
        
        
    }
    
    return _slideTitles;
    
}




#pragma mark - 获取头部排行
-(void)getKeeperRank
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin]) {
        
        int keeper_id = [UserInfo getkeeperid];
        int store_id = [UserInfo getstoreid];
        
        [[NetWorking shareNetWorking] RequestWithAction:kMyRank Params:@{@"keeper_id":@(keeper_id),@"store_id":@(store_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
            
            
            if (isSuccess) {
                
             
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.homeHeaderView setRankData:data];
                        
                        _keeperRankData = data;
                        
                    });
                  
                    
                 
                    
                
            }
        }];
    }
 
}

#pragma mark － 首页子页面
-(FirstPageViewController*)firstpageController
{
    if (!_firstpageController) {
        
        
        _firstpageController = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstPageViewController"];
        
        _firstpageController.view.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        
       
        
    }
    
    return _firstpageController;
    
}

#pragma mark - 预约管理
-(YuyueViewController*)yuyuepageController
{
    if (!_yuyuepageController) {
        
        _yuyuepageController = [self.storyboard instantiateViewControllerWithIdentifier:@"YuyueViewController"];
        
        _yuyuepageController.view.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        
        _yuyuepageController.superViewController = self;
        
        
    }
    
    
    return _yuyuepageController;
    
}

#pragma mark - 客户管理
-(CustomerViewController*)customerViewController
{
    if (!_customerViewController) {
        
        _customerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
        
        _customerViewController.view.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        
    }
    
    return _customerViewController;
    
}

#pragma mark - 跟进提醒
-(FollowUserController*)followUserController
{
    if (!_followUserController) {
        
        _followUserController = [self.storyboard instantiateViewControllerWithIdentifier:@"FollowUserController"];
        
        _followUserController.view.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        
    }
    
    return _followUserController;
    
}

#pragma mark - 排行榜
-(KeeperSortViewController*)keeperSortViewController
{
    if (!_keeperSortViewController) {
        
        _keeperSortViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"KeeperSortViewController"];
        
        _keeperSortViewController.view.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
    }
    
    return _keeperSortViewController;
    
}

#pragma mark - FAQ
-(FAQViewController*)faqViewController
{
    if (!_faqViewController) {
        
        _faqViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FAQViewController"];
        
        _faqViewController.view.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
    }
    
    return _faqViewController;
    
}

#pragma mark - 设置
-(SettingViewController*)settingViewController
{
    if (!_settingViewController) {
        
        _settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
        
        _settingViewController.view.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
    }
    
    return _settingViewController;
    
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
        cell.slideimageview.image =  [UIImage imageNamed:[dict objectForKey:@"image2"]];
        
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.titlelabel.textColor = kDarkGrayColor;
        
        cell.slideimageview.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    }
    
    int num = 0;
    
    switch (indexPath.section) {
        case 0:
        {
             num = [[_unreaddict objectForKey:@"catch_num"]intValue];
            
          
        }
        break;
       case 1:
        {
            num = [[_unreaddict objectForKey:@"appoint_num"]intValue];
        }
        break;

      case 3:
        {
             num = [[_unreaddict objectForKey:@"follow_num"]intValue];
        }
        break;
        
        
        default:
        {
           
            num = 0;
            
            
        }
        break;
    }
    
    if (num > 0) {
        
        cell.numberLabel.adjustsFontSizeToFitWidth = YES;
        
        cell.numberLabel.hidden = NO;
        cell.numberLabel.text = [NSString stringWithFormat:@"%d",num];
        
    }
    else
    {
        cell.numberLabel.hidden = YES;
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
  
    
    
    
    [self switchSubPage:indexPath.section];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - 切换界面
-(void)switchSubPage:(NSInteger)section
{
    
    [self setselected:section];
    
    if (section == selectedSection) {
        
        return;
        
    }
    
  
    
    for (UIView*view in self.contentView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    
    switch (section) {
        case 0:  // 首页
        {
            [self.contentView addSubview:self.firstpageController.view];
            
        }
            break;
        
        case 1:  //预约管理
        {
            [self.contentView addSubview:self.yuyuepageController.view];
            
        }
            break;
        case 2:  //客户管理
        {
            [self.contentView addSubview:self.customerViewController.view];
            
            
        }
            break;
        case 3:  //跟进提醒
        {
            [self.contentView addSubview:self.followUserController.view];
            
            
        }
            break;
        case 4: //排行榜
        {
            [self.contentView addSubview:self.keeperSortViewController.view];
            
        }
            break;
        case 5: //faq
        {
            [self.contentView addSubview:self.faqViewController.view];
            
        }
            break;
        case 6:
        {
            [self.contentView addSubview:self.settingViewController.view];
            
            
        }
            
            
        default:
            break;
    }
    
      selectedSection = section;
    
    
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


#pragma mark -抢单成功 
-(void)successCatchOrder:(NSNotification*)note
{
    
    
    
    [self switchSubPage:1];
    
    [self  getunreadnumber];
    
    
    
    
}


#pragma mark - 修改了头像 
-(void)changedAvatar:(NSNotification*)noti
{
    self.homeHeaderView.headImageView.image = [UIImage imageWithData:noti.object];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
